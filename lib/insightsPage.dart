import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  void initState(){
    super.initState();
    _fetchData();
  }
  void _fetchData() async {
    List<WaterConsumption> data = [];
    DateTime now = DateTime.now();
    DateTime startDate = now;

    switch(_selectedRange){
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
        startDate = DateTime(2023);
        break;
    }
    QuerySnapshot snapshot = await _firestore
    .collection('users')
    .doc(userId)
    .collection('water-drank')
    .where(FieldPath.documentId, isGreaterThanOrEqualTo: startDate.toIso8601String())
    .get();

    data = snapshot.docs.map((doc) {
      final docData = doc.data() as Map<String, dynamic>;
      return WaterConsumption.fromMap(docData, doc.id);
    }).toList();



    setState(() {
      _data = data;
    });
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
                    primaryXAxis: DateTimeAxis(),
                    title: ChartTitle(text: 'Water Consumption Over Time'),
                    legend: Legend(isVisible: false),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <CartesianSeries<WaterConsumption, DateTime>>[
                      LineSeries<WaterConsumption, DateTime>(
                        dataSource: _data,
                        xValueMapper: (WaterConsumption consumption, _) => consumption.time,
                        yValueMapper: (WaterConsumption consumption, _) => consumption.totalAmount,
                        name: 'Water Consumption',
                        dataLabelSettings: DataLabelSettings(isVisible: true),
                      )
                    ],
                  ))
            ],
          )

        )
    );
  }
}

class WaterConsumption{
  final DateTime time;
  final List<int> amounts;

  WaterConsumption(this.time, this.amounts);

  WaterConsumption.fromMap(Map<String, dynamic> map, String id)
      : time = DateTime.parse(id),
        amounts = List<int>.from(map['amount']);

  Map<String, dynamic> toMap(){
    return{
      'time': time,
      'amount': amounts
    };
  }
  double get totalAmount => amounts.fold(0, (sum, item) => sum + item);
}