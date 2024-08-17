import 'package:flutter/material.dart';

class DietPage extends StatelessWidget {
  const DietPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title')
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Keto Diet',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10,),
              Text('Hello',
              style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 10,),
              Text('Recommended Dishes',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
              ),

            ],
        ),
      )
    );
  }
}
