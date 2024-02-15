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
                              child: Icon(Icons.water_drop_outlined,
                                color: Colors.blue,
                                size:75,
                            ),
                    ),
                        ),
                        Positioned(
                          bottom: 2,
                          child: Text(
                          '764/500 ml drank',
                          style: TextStyle(fontSize: 24),
                        ),
                        ),
                        TextButton(onPressed: () {}, child: Row (
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
                )
              ],
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

