import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:smartflask/components/ArcProgressIndicator.dart';
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
  double progress = 0.152;
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'OpenSans'),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Smart Flask',
              style: TextStyle(fontFamily: 'Raleway')),

          backgroundColor: Colors.blue,
        ),
        body: Center(

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
                              const Positioned(
                                bottom: 2,
                                child: Text(
                                  '764/500 ml drank',
                                  style: TextStyle(fontSize: 24),
                                ),
                              ),
                              TextButton(onPressed: () {},
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
        ),


        bottomNavigationBar: NavigationBar(
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.home),
                label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.explore),
                label: 'Explore'),
            NavigationDestination(
                icon: Icon(Icons.bar_chart),
                label: 'Insights'),
            NavigationDestination(
                icon: Icon(Icons.account_circle),
                label: 'Profile')
          ],
          backgroundColor: Color.fromRGBO(224, 224, 224, 1),

          shadowColor: Colors.black,
          selectedIndex: selectedPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              selectedPageIndex = index;
            });
          },
          animationDuration: Duration(milliseconds: 1000),
        ),

      ),
    );
  }

}
class DateDisplay extends StatelessWidget {
  final DateTime date;

  DateDisplay({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dayNumber = DateFormat('d').format(date); // Day number, e.g., "23"
    String dayName = DateFormat('E').format(date); // Day name abbreviation, e.g., "Mon"

    return Container(
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
    );
  }
}

class BottomSheetClass extends StatelessWidget {
  const BottomSheetClass({super.key});

  Future<List<Map<String, dynamic>>> fetchLast7DaysData() async {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(Duration(days: 7));
    final userUID = 'YOUR_USER_UID'; // Replace with actual user UID.

    // Convert to Unix timestamp for comparison.
    final int sevenDaysAgoUnix = sevenDaysAgo.millisecondsSinceEpoch ~/ 1000;

    final querySnapshot = await FirebaseFirestore.instance
        .collection('water_consumption')
        .where('userId', isEqualTo: userUID)
        .where('timestamp', isGreaterThanOrEqualTo: sevenDaysAgoUnix)
        .orderBy('timestamp', descending: true)
        .get();

    return querySnapshot.docs
        .map((doc) => {
      ...doc.data() as Map<String, dynamic>,
      'date': DateTime.fromMillisecondsSinceEpoch(doc['timestamp'] * 1000)
    })
        .toList();
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
                                              child: DateDisplay(date: date),
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
                            child: FutureBuilder<List<Map<String, dynamic>>>(
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
