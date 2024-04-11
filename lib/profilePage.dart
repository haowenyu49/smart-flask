import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smartflask/components/card.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Card(

                margin: EdgeInsets.all(15),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50),
                      Text("Name Lastname",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Date joined", style: TextStyle(fontSize: 20),),
                          SizedBox(width: 10),
                          Text("2024", style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.w500))
                        ],
                      ),

                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Goals', style: TextStyle(fontSize: 30),),
                    Container(
                      height: 140,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          CustomCard(icon: Icons.water_drop_outlined, title: 'Water Consumption', subTitle: '3 Goals', onPressed: () {} ),
                          CustomCard(icon: Icons.ac_unit, title: 'Water Consumption', subTitle: '3 Goals', onPressed: () {} ),
                          CustomCard(icon: Icons.water_drop_outlined, title: 'Water Consumption', subTitle: '3 Goals', onPressed: () {} )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        )
    );
  }
}