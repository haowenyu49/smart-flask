import 'package:flutter/material.dart';
import 'package:smartflask/main.dart';

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
  @override
  Widget build(BuildContext context)
  {
    //
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Smart Flask'),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          child: const Text('ml drank'),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black,
                width: 3,
            ),
            borderRadius: BorderRadius.all((Radius.circular(20)))
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

