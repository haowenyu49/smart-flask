import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartflask/components/firebase/authentication.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class InsightsPage extends StatefulWidget {
  const InsightsPage({super.key});

  @override
  State<InsightsPage> createState() => _InsightsPageState();
}

class _InsightsPageState extends State<InsightsPage> {
  String? _selectedRange = "Today";
  List<String> _ranges = ['Today', 'Last 7 Days', 'Last 30 Days', 'All Time'];
  List<WaterConsumption> _data = [];
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String userId = AuthenticationHelper().uid;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    List<WaterConsumption> data = [];
    DateTime now = DateTime.now();
    DateTime startDate = now;

    switch (_selectedRange) {
      case 'Today':
        startDate = DateTime(now.year, now.month, now.day);
        break;
      case 'Last 7 Days':
        startDate = now.subtract(Duration(days: 7));
        break;
      case 'Last 30 Days':
        startDate = now.subtract(Duration(days: 30));
        break;
      case "All Time":
        startDate = DateTime(2023); // Adjust as per your requirements
        break;
    }

    try {
      // Fetch all documents in 'water-drank'
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('water-drank')
          .get();

      // Filter the documents based on the selected date range
      data = snapshot.docs.map((doc) {
        final docData = doc.data() as Map<String, dynamic>;

        // Parse the document ID to get the date (assuming IDs are in 'MM-dd-yyyy' format)
        DateTime docDate = DateFormat('MM-dd-yyyy').parse(doc.id);

        // Only include documents within the selected range
        if (docDate.isAfter(startDate) || docDate.isAtSameMomentAs(startDate)) {
          // Parse the water consumption amounts, ensure it's not null
          final waterConsumption = docData['water-consumption'] as Map<String, dynamic>?;

          if (waterConsumption == null) {
            return null; // Skip this document if water-consumption is missing
          }

          // Parse the water levels
          List<int> waterLevels = waterConsumption.values.map((e) => e as int).toList();

          // Calculate the total amount consumed, ignoring refills
          int totalWaterDrankMm = 0;
          for (int i = 1; i < waterLevels.length; i++) {
            int currentLevel = waterLevels[i];
            int previousLevel = waterLevels[i - 1];

            // Only count the decreases as consumption
            if (currentLevel < previousLevel) {
              totalWaterDrankMm += previousLevel - currentLevel;
            }
          }

          // Convert from mm to ml based on your bottle's capacity
          double conversionFactor = 621.04 / 226; // 21 oz bottle (621.04 ml) and 226 mm height
          int totalWaterDrankMl = (totalWaterDrankMm * conversionFactor).toInt();

          return WaterConsumption(
            docDate,              // Use the parsed document date
            totalWaterDrankMl,     // Total amount of water consumed in ml
          );
        }
        return null; // Return null if the document is outside the range
      })
          .whereType<WaterConsumption>() // This will remove null values
          .toList(); // Convert to a list of non-null WaterConsumption

      setState(() {
        _data = data;
        print("Data processed: $_data"); // Debug: print processed data
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                DropdownButton<String>(
                  value: _selectedRange,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRange = newValue;
                      _fetchData();
                    });
                  },
                  items: _ranges.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Expanded(
                  child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(), // Changed from DateTimeAxis to CategoryAxis
                    title: ChartTitle(text: 'Water Consumption Over Time'),
                    legend: Legend(isVisible: false),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <CartesianSeries<WaterConsumption, String>>[
                      LineSeries<WaterConsumption, String>(
                        dataSource: _data,
                        xValueMapper: (WaterConsumption consumption, _) =>
                            consumption.formattedTime(_selectedRange!), // Use formatted time as xValue
                        yValueMapper: (WaterConsumption consumption, _) =>
                        consumption.totalAmount,
                        name: 'Water Consumption',
                        dataLabelSettings: DataLabelSettings(isVisible: true),
                      )
                    ],
                  ),
                )
              ],
            )));
  }
}

class WaterConsumption {
  final DateTime time;
  final int totalAmount;

  WaterConsumption(this.time, this.totalAmount);

  WaterConsumption.fromMap(Map<String, dynamic> map, String id)
      : time = DateTime.parse(id),
        totalAmount = map['amount'];

  Map<String, dynamic> toMap() {
    return {
      'time': time,
      'amount': totalAmount,
    };
  }

  // New method to return formatted time
  String formattedTime(String selectedRange) {
    if (selectedRange == 'Today') {
      // If the selected range is 'Today', return the time in 'h:mm a' format
      return DateFormat('h:mm a').format(time);
    } else {
      // For any other range, return the date in 'MM/dd/yyyy' format
      return DateFormat('MM/dd/yyyy').format(time);
    }
  }
}
