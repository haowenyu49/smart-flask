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
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: const Color.fromRGBO(253, 237, 201, 1.0),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            toolbarHeight: 150,
            flexibleSpace: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Container(
                      height: 85,
                      width: 110,
                      decoration: const BoxDecoration(

                      ),
                    )
                )
              ],
            ),
          ),
          body: ListView(

          )
      )
    );
  }

}