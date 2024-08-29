import 'package:flutter/material.dart';
import 'package:smartflask/components/colorPalette.dart';
import 'package:smartflask/components/homepage.dart';
import 'package:smartflask/explorePage.dart';
import 'package:smartflask/insightsPage.dart';
import 'package:smartflask/main.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        title:
            const Text('Smart Flask', style: TextStyle(fontFamily: 'Raleway')),
        backgroundColor: ColorPalette.primary,
      ),
      body: pages[selectedPageIndex],
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: 8, left: 8, right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(24), topLeft: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
                color: Color(0x35000000), spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(24),
          ),
          child: NavigationBar(
            backgroundColor: ColorPalette.bg,
            indicatorColor: ColorPalette.secondary,
            destinations: [
              NavigationDestination(
                  icon: Icon(
                    Icons.home,
                    color: ColorPalette.accent,
                  ),
                  label: 'Home'),
              NavigationDestination(
                  icon: Icon(Icons.explore, color: ColorPalette.accent),
                  label: 'Explore'),
              NavigationDestination(
                  icon: Icon(Icons.bar_chart, color: ColorPalette.accent),
                  label: 'Insights'),
              NavigationDestination(
                  icon: Icon(Icons.account_circle, color: ColorPalette.accent),
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
      ),
    );
  }
}
