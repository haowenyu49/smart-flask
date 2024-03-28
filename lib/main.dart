import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:smartflask/components/ArcProgressIndicator.dart';
import 'package:smartflask/components/explorePage.dart';
import 'package:smartflask/components/homepage.dart';
import 'package:smartflask/components/insightsPage.dart';
import 'package:smartflask/components/loginPage.dart';
import 'package:smartflask/components/profilePage.dart';
import 'package:smartflask/components/registerPage.dart';
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
  final List<Widget> pages = [
    HomePage(),
    ExplorePage(),
    InsightsPage(),
    ProfilePage(),

  ];
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'OpenSans'),
      home:Scaffold(
        appBar: AppBar(
      title: const Text('Smart Flask',
          style: TextStyle(fontFamily: 'Raleway')),

      backgroundColor: Colors.blue,
    ),
        body: pages[selectedPageIndex],
        bottomNavigationBar: NavigationBar(
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      overlayColor: MaterialStateProperty.all(Colors.grey) ,
      indicatorColor: Colors.grey,
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