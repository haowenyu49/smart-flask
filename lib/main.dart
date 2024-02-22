import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:smartflask/components/ArcProgressIndicator.dart';
import 'package:smartflask/main.dart';
import 'package:smartflask/components/pie_chart.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
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

                    child: TextButton(onPressed: () {},
                      child: const Row (
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: <Widget> [
                          Text('Amount of water this week',
                          style: TextStyle(fontSize: 28,color:Colors.blue),),
                          Icon(Icons.arrow_forward, color: Colors.blue,),
                        ],
                    ),
                    ),
                    ),
                ),
                Card (
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: EdgeInsets.all(20),

                    child: TextButton(onPressed: () {}, child: const Row (
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget> [
                          Icon(Icons.insert_chart, color: Colors.blue),
                          Text('See my insights',
                              style: TextStyle(fontSize: 28,color:Colors.blue)),
                        ]
                    ),
                      ),
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

