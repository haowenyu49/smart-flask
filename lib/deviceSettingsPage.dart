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

        setState(() {
          batteryLevel = (data['batteryLevel'] ?? 0.0).toDouble();
          waterLevel = (data['waterLevel'] ?? 0.0).toDouble();
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
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: devicePaired
              ? RefreshIndicator(
            onRefresh: _fetchDeviceData,
            child: ListView(
              children: [
                Text('Device ID: $deviceId'),
                SizedBox(height: 20),
                BatteryLevelWidget(batteryLevel: batteryLevel),
                SizedBox(height: 20),
                WaterBottleWidget(waterLevel: waterLevel),
              ],
            ),
          )
              : Column(
            children: [
              TextField(
                controller: _deviceIdController,
                decoration: InputDecoration(labelText: 'Enter Device ID'),
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
        ));
  }
}

class BatteryLevelWidget extends StatelessWidget {
  final double batteryLevel; // Expected to be between 0.0 and 100.0

  BatteryLevelWidget({required this.batteryLevel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Battery Level',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        LinearProgressIndicator(
          value: batteryLevel / 100.0,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(
            batteryLevel > 20 ? Colors.green : Colors.red,
          ),
        ),
        SizedBox(height: 5),
        Text('${batteryLevel.toStringAsFixed(0)}%'),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Water Level',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        CustomPaint(
          size: Size(100, 200),
          painter: WaterBottlePainter(waterLevel: waterLevel),
        ),
        SizedBox(height: 5),
        Text('${(waterLevel * 100).toStringAsFixed(0)}% full'),
      ],
    );
  }
}

class WaterBottlePainter extends CustomPainter {
  final double waterLevel; // Expected to be between 0.0 and 1.0

  WaterBottlePainter({required this.waterLevel});

  @override
  void paint(Canvas canvas, Size size) {
    // Draw the bottle outline
    Paint bottlePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    Path bottlePath = Path();
    double bottleWidth = size.width * 0.6;
    double bottleNeckHeight = size.height * 0.2;
    double bottleBodyHeight = size.height * 0.7;
    double bottleNeckWidth = bottleWidth * 0.5;

    double left = (size.width - bottleWidth) / 2;
    double right = left + bottleWidth;
    double top = 0;
    double bottom = size.height;

    // Neck
    bottlePath.moveTo(left + (bottleWidth - bottleNeckWidth) / 2, top);
    bottlePath.lineTo(
        left + (bottleWidth - bottleNeckWidth) / 2, top + bottleNeckHeight);
    bottlePath.lineTo(
        right - (bottleWidth - bottleNeckWidth) / 2, top + bottleNeckHeight);
    bottlePath.lineTo(
        right - (bottleWidth - bottleNeckWidth) / 2, top);

    // Body
    bottlePath.moveTo(left, top + bottleNeckHeight);
    bottlePath.lineTo(left, bottom);
    bottlePath.lineTo(right, bottom);
    bottlePath.lineTo(right, top + bottleNeckHeight);

    canvas.drawPath(bottlePath, bottlePaint);

    // Fill the bottle with water
    Paint waterPaint = Paint()
      ..color = Colors.blue.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    double waterTop = bottom - (bottleBodyHeight * waterLevel);

    Path waterPath = Path();
    waterPath.moveTo(left, bottom);
    waterPath.lineTo(left, waterTop);
    waterPath.lineTo(right, waterTop);
    waterPath.lineTo(right, bottom);
    waterPath.close();

    canvas.drawPath(waterPath, waterPaint);
  }

  @override
  bool shouldRepaint(covariant WaterBottlePainter oldDelegate) {
    return oldDelegate.waterLevel != waterLevel;
  }
}
