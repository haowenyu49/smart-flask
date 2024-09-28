import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DeviceSettingsPage extends StatefulWidget {
  @override
  _DeviceSettingsPageState createState() => _DeviceSettingsPageState();
}

class _DeviceSettingsPageState extends State<DeviceSettingsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool devicePaired = false;
  bool isLoading = false;
  String? deviceId;
  double batteryLevel = 0.0;
  double waterLevel = 0.0; // Represented as a percentage (0.0 to 1.0)

  final _deviceIdController = TextEditingController();

  // Assumed total internal height of the bottle in millimeters
  static const double maxBottleHeightMm = 250.0;

  @override
  void initState() {
    super.initState();
    _loadDeviceIdFromPrefs();
  }

  Future<void> _loadDeviceIdFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cachedDeviceId = prefs.getString('deviceID');

    if (cachedDeviceId != null && cachedDeviceId.isNotEmpty) {
      setState(() {
        deviceId = cachedDeviceId;
        devicePaired = true;
      });
      _fetchDeviceData();
    } else {
      // If no cached ID, check Firestore
      await _checkDevicePairing();
    }
  }

  Future<void> _checkDevicePairing() async {
    User? user = _auth.currentUser;
    DocumentSnapshot userDoc =
    await _firestore.collection('users').doc(user!.uid).get();

    if (userDoc.exists) {
      Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;

      if (data.containsKey('deviceID')) {
        setState(() {
          deviceId = data['deviceID'];
          devicePaired = deviceId!.isNotEmpty;
        });
        // Cache the device ID locally
        _saveDeviceIdToPrefs(deviceId!);
        _fetchDeviceData();
      }
    }
  }

  Future<void> _saveDeviceIdToPrefs(String deviceId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('deviceID', deviceId);
  }

  Future<void> pairDevice() async {
    setState(() {
      isLoading = true;
    });

    try {
      User? user = _auth.currentUser;
      await _firestore.collection('users').doc(user!.uid).update({
        'deviceID': _deviceIdController.text,
      });

      // Cache the device ID locally
      await _saveDeviceIdToPrefs(_deviceIdController.text);

      setState(() {
        devicePaired = true;
        deviceId = _deviceIdController.text;
      });
      _fetchDeviceData();
    } catch (e) {
      print('Failed to update device ID: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchDeviceData() async {
    if (deviceId == null) return;

    try {
      DocumentSnapshot deviceDoc =
      await _firestore.collection('devices').doc(deviceId).get();

      if (deviceDoc.exists) {
        Map<String, dynamic> data = deviceDoc.data() as Map<String, dynamic>;

        // Extract the distance from the cap to the water surface in millimeters
        double distanceFromCapMm = (data['distanceFromCapMm'] ?? 0.0).toDouble();

        // Calculate water level as a percentage
        double calculatedWaterLevel =
            (maxBottleHeightMm - distanceFromCapMm) / maxBottleHeightMm;

        // Ensure waterLevel is between 0.0 and 1.0
        calculatedWaterLevel = calculatedWaterLevel.clamp(0.0, 1.0);

        setState(() {
          batteryLevel = (data['batteryLevel'] ?? 0.0).toDouble();
          waterLevel = calculatedWaterLevel;
        });
      } else {
        print('Device data not found.');
      }
    } catch (e) {
      print('Failed to fetch device data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Device Settings'),
          elevation: 2,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: devicePaired
                ? RefreshIndicator(
              onRefresh: _fetchDeviceData,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Device ID: $deviceId',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    BatteryLevelWidget(batteryLevel: batteryLevel),
                    SizedBox(height: 40),
                    WaterBottleWidget(waterLevel: waterLevel),
                  ],
                ),
              ),
            )
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _deviceIdController,
                  decoration:
                  InputDecoration(labelText: 'Enter Device ID'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isLoading ? null : pairDevice,
                  child: isLoading
                      ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : Text('Confirm Device ID'),
                ),
              ],
            ),
          ),
        ));
  }
}

class BatteryLevelWidget extends StatelessWidget {
  final double batteryLevel; // Expected to be between 0.0 and 100.0

  BatteryLevelWidget({required this.batteryLevel});

  @override
  Widget build(BuildContext context) {
    Color batteryColor =
    batteryLevel > 20 ? Colors.green : Colors.red; // Color based on level

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Battery Level',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 60,
              height: 120,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[700]!, width: 2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 56,
                  height: 116 * (batteryLevel / 100.0).clamp(0.0, 1.0),
                  color: batteryColor,
                ),
              ),
            ),
            Text(
              '${batteryLevel.toStringAsFixed(0)}%',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 2.0,
                    color: Colors.black,
                    offset: Offset(0.5, 0.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class WaterBottleWidget extends StatelessWidget {
  final double waterLevel; // Expected to be between 0.0 and 1.0

  WaterBottleWidget({required this.waterLevel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Water Level',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // The bottle image
            Image.asset(
              'assets/images/bottle.png',
              width: 150,
              height: 300,
              fit: BoxFit.contain,
            ),
            // The water level overlay
            ClipRect(
              child: Align(
                alignment: Alignment.bottomCenter,
                heightFactor:
                waterLevel.clamp(0.0, 1.0), // Adjust this to change the water level
                child: Container(
                  width: 150,
                  height: 300,
                  color: Colors.blue.withOpacity(0.6),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Text('${(waterLevel * 100).toStringAsFixed(0)}% full'),
      ],
    );
  }
}
