import 'package:flutter/material.dart';
import 'package:smartflask/components/colorPalette.dart';
import 'package:smartflask/components/firebase/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

// Assuming you have these imports
import 'package:smartflask/components/ArcProgressIndicator.dart';
// ... other necessary imports

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double progress = 0.0;
  int drankToday = 0;
  int dailyGoal = 2000;

  @override
  void initState() {
    super.initState();
    // Optionally, fetch today's data on widget load
    _updateTodayData();
  }

  Future<void> _updateTodayData() async {
    int totalDrank = await fetchTodayData();
    double newProgress = totalDrank / dailyGoal;

    setState(() {
      drankToday = totalDrank;
      progress = newProgress.clamp(0.0, 1.0);
    });
  }

  Future<int> fetchTodayData() async {
    final userUID = AuthenticationHelper().uid;
    final date = DateTime.now();
    final formattedDate = DateFormat('MM-dd-yyyy').format(date);

    final docSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userUID)
        .collection('water-drank')
        .doc(formattedDate)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data()!;
      final waterConsumption = data['water-consumption'] as Map<String, dynamic>;

      List<int> timestamps =
      waterConsumption.keys.map((e) => int.parse(e)).toList();
      timestamps.sort();

      List<int> waterLevels = timestamps
          .map((ts) => waterConsumption[ts.toString()] as int)
          .toList();

      int totalWaterDrankMm = 0;
      for (int i = 1; i < waterLevels.length; i++) {
        int difference = waterLevels[i - 1] - waterLevels[i];
        if (difference > 0) {
          totalWaterDrankMm += difference;
        }
      }

      int totalWaterDrankMl = convertMmToMl(totalWaterDrankMm);
      return totalWaterDrankMl;
    } else {
      return 0;
    }
  }

  int convertMmToMl(int mm) {
    // Adjust the conversion factor based on your bottle's dimensions
    double conversionFactor = 710 / 200; // Example: 710 ml capacity, 200 mm height
    return (mm * conversionFactor).toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        // Your original Card widget
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          margin: EdgeInsets.all(10),
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Container(
                  child: ArcProgressIndicator(
                    progress: progress,
                    strokeWidth: 8.0,
                    child: Icon(
                      Icons.water_drop_outlined,
                      color: ColorPalette.primary,
                      size: 75,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    '$drankToday / $dailyGoal ml drank',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                TextButton(
                  onPressed: _updateTodayData,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Refresh'),
                      Icon(Icons.refresh),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
        // The BottomSheetClass Card
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          elevation: 4,
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: BottomSheetClass(),
          ),
        ),
      ],
    );
  }
}

class BottomSheetClass extends StatefulWidget {
  const BottomSheetClass({super.key});

  @override
  _BottomSheetClassState createState() => _BottomSheetClassState();
}

class _BottomSheetClassState extends State<BottomSheetClass> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return _BottomSheetContent();
            },
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Amount of water this week',
              style: TextStyle(fontSize: 24),
            ),
            Icon(Icons.arrow_forward, color: ColorPalette.primary),
          ],
        ),
      ),
    );
  }
}

class _BottomSheetContent extends StatefulWidget {
  @override
  __BottomSheetContentState createState() => __BottomSheetContentState();
}

class __BottomSheetContentState extends State<_BottomSheetContent> {
  String selectedDay = DateFormat('MM-dd-yyyy').format(DateTime.now());
  late Future<Map<String, int>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchLast7DaysData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
            height: 60,
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(7, (index) {
                    final date = DateTime.now().subtract(Duration(days: index));
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: DateDisplay(
                        date: date,
                        isSelected:
                        selectedDay == DateFormat('MM-dd-yyyy').format(date),
                        onTap: () {
                          setState(() {
                            selectedDay =
                                DateFormat('MM-dd-yyyy').format(date);
                          });
                        },
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: FutureBuilder<Map<String, int>>(
              future: futureData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No data available');
                }
                final data = snapshot.data!;
                // Display data for the selected day
                int waterDrank = data[selectedDay] ?? 0;
                return Center(
                  child: Text(
                    'Water drank on ${DateFormat('MM/dd/yyyy').format(DateFormat('MM-dd-yyyy').parse(selectedDay))}: $waterDrank ml',
                    style: TextStyle(fontSize: 20),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DateDisplay extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final VoidCallback onTap;

  DateDisplay(
      {Key? key,
        required this.date,
        required this.onTap,
        required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dayNumber = DateFormat('d').format(date);
    String dayName = DateFormat('E').format(date);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[200] : Colors.blue[50],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              dayNumber,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.blue,
              ),
            ),
            Text(
              dayName,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<Map<String, int>> fetchLast7DaysData() async {
  final userUID = AuthenticationHelper().uid; // Replace with actual user UID if needed
  final now = DateTime.now();
  final Map<String, int> last7DaysData = {};

  for (int i = 0; i < 7; i++) {
    final date = now.subtract(Duration(days: i));
    final formattedDate = DateFormat('MM-dd-yyyy').format(date);

    final docSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userUID)
        .collection('water-drank')
        .doc(formattedDate)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data()!;
      final waterConsumption = data['water-consumption'] as Map<String, dynamic>;

      List<int> timestamps =
      waterConsumption.keys.map((e) => int.parse(e)).toList();
      timestamps.sort();

      List<int> waterLevels = timestamps
          .map((ts) => waterConsumption[ts.toString()] as int)
          .toList();

      int totalWaterDrankMm = 0;
      for (int j = 1; j < waterLevels.length; j++) {
        int difference = waterLevels[j - 1] - waterLevels[j];
        if (difference > 0) {
          totalWaterDrankMm += difference;
        }
      }

      int totalWaterDrankMl = convertMmToMl(totalWaterDrankMm);

      last7DaysData[formattedDate] = totalWaterDrankMl;
    }
  }

  return last7DaysData;
}

int convertMmToMl(int mm) {
  // Adjust the conversion factor based on your bottle's dimensions
  double conversionFactor = 710 / 200; // Example: 710 ml capacity, 200 mm height
  return (mm * conversionFactor).toInt();
}
