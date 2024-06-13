import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:smartflask/components/ArcProgressIndicator.dart';
import 'package:smartflask/components/firebase/authentication.dart';
import 'package:smartflask/main.dart';
import 'package:smartflask/components/pie_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  int selectedPageIndex = 0;
  double progress = 0.0;
  int drankToday = 0;
  int dailyGoal = 2000;

  @override
  Widget build(BuildContext context)
  {
    return Center(

      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Card(
                margin: EdgeInsets.all(10),
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                        children: <Widget> [
                          Positioned(
                            bottom: 8,
                            child: ArcProgressIndicator(
                              progress: progress,
                              strokeWidth: 8.0,
                              child: const Icon(Icons.water_drop_outlined,
                                color: Colors.blue,
                                size:75,
                              ),
                            ),
                          ),
                           Positioned(
                            bottom: 2,
                            child: Text(
                              '$drankToday / $dailyGoal ml drank',
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                          TextButton(onPressed: () async {
                            DateTime time = DateTime.now();
                            String date = DateFormat('MM-dd-yyyy').format(time);
                            List<int> waterLevels = await AuthenticationHelper().getWaterLevel(date);
                            if (waterLevels.isNotEmpty) {
                              int totalDrank = waterLevels.reduce((a, b) => a + b);
                              double newProgress = totalDrank / dailyGoal;

                              setState(() {
                                drankToday = totalDrank;
                                progress = newProgress;
                              });
                            } else {
                              setState(() {
                                drankToday = 0;
                                progress = 0.0;
                              });
                            }

                          },
                              child: const Row (
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget> [
                                    Text('Refresh'),
                                    Icon(Icons.refresh),
                                  ]
                              )
                          ),
                          SizedBox(height: 20),
                        ]
                    )
                )
            ),
            Card(
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: BottomSheetClass(),
              ),
            ),

            Card (
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: EdgeInsets.all(20),

                  child: TextButton(onPressed: () {}, child: const Row (
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget> [
                        Text('Set Reminder',
                            style: TextStyle(fontSize: 20,color:Colors.blue)),
                      ]
                  )
                  ),
                )
            ),
          ]
      ),
    );
  }

}
class DateDisplay extends StatelessWidget {
  final DateTime date;
  final VoidCallback onTap;

  DateDisplay({Key? key, required this.date, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dayNumber = DateFormat('d').format(date); // Day number, e.g., "23"
    String dayName = DateFormat('E').format(date); // Day name abbreviation, e.g., "Mon"

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8), // Reduced padding
        decoration: BoxDecoration(
          color: Colors.blue[50], // Change to desired background color
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              dayNumber,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16, // Reduced font size if necessary
                color: Colors.blue, // Change to desired text color
              ),
            ),
            Text(
              dayName,
              style: TextStyle(
                fontSize: 12, // Reduced font size if necessary
                color: Colors.grey[600], // Change to desired text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class BottomSheetClass extends StatefulWidget {
  const BottomSheetClass({super.key});

  @override
  _BottomSheetClassState createState() => _BottomSheetClassState();

}
class _BottomSheetClassState extends State<BottomSheetClass> {

  String selectedDay = DateFormat('EEEE').format(DateTime.now());

  Future<Map<String, dynamic>> fetchLast7DaysData() async {
    final userUID = AuthenticationHelper().uid; // Replace with actual user UID.
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(userUID).get();
    return userDoc.data()!['waterDrank'] ?? {};
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: TextButton(
            onPressed: () {
              showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                        height: 600,
                        color: Colors.white,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 10),
                              Container(
                                height: 60,
                                child: Center(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
                                      child: IntrinsicWidth(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center, // Center the children
                                          children: List<Widget>.generate(7, (index) {
                                            final date = DateTime.now().subtract(Duration(days: index));
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: DateDisplay(
                                                  date: date,
                                                  onTap: () {
                                                    setState(() {
                                                      selectedDay = DateFormat('EEEE').format(date);
                                                    });
                                                  },
                                              ),
                                            );
                                          }),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 10),
                              Expanded(
                                child: FutureBuilder<Map<String, dynamic>>(
                                  future: fetchLast7DaysData(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    }
                                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                      return Text('No data available');
                                    }
                                    final data = snapshot.data!;
                                    // Your logic here to display the fetched data
                                    // For simplicity, this example just lists the amounts
                                    return ListView.builder(
                                      itemCount: data.length,
                                      itemBuilder: (context, index) {
                                        final dayData = data[index];
                                        return ListTile(
                                          title: Text(DateFormat('MM/dd').format(dayData['date'])),
                                          subtitle: Text('${dayData['amount']} ml'),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ]));
                  });
            },
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
              Text(
                'Amount of water this week',
                style: TextStyle(fontSize: 28, color: Colors.blue),
              ),
              Icon(Icons.arrow_forward, color: Colors.blue),
            ])));
  }
}


//
// Text('Amount of water this week',
// style: TextStyle(fontSize: 28,color:Colors.blue),),
// Icon(Icons.arrow_forward, color: Colors.blue,),


Future<List<Map<String, dynamic>>> fetchLast7DaysData() async {
  final userUID = 'YOUR_USER_UID';
  final now = DateTime.now();
  final sevenDaysAgo = now.subtract(Duration(days: 7));

  final querySnapshot = await FirebaseFirestore.instance
      .collection('water_consumption')
      .where('userId', isEqualTo: userUID)
      .where('date', isGreaterThanOrEqualTo: sevenDaysAgo)
      .orderBy('date', descending: true)
      .limit(7)
      .get();

  return querySnapshot.docs
      .map((doc) => doc.data() as Map<String, dynamic>)
      .toList();
}