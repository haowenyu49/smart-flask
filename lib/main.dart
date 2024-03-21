import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:smartflask/components/ArcProgressIndicator.dart';
import 'package:smartflask/components/homepage.dart';
import 'package:smartflask/components/loginPage.dart';
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
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'OpenSans'),
      home: HomePage()
    );
  }

}