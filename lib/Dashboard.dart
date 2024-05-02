import 'package:flutter/material.dart';
import 'package:smartflask/components/homepage.dart';
import 'package:smartflask/explorePage.dart';
import 'package:smartflask/insightsPage.dart';
import 'package:smartflask/profilePage.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}
class _DashboardState extends State<Dashboard> {
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