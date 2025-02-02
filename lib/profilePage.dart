import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartflask/DetailedUserPage.dart';
import 'package:smartflask/components/card.dart';
import 'package:smartflask/components/firebase/authentication.dart';
import 'package:smartflask/deviceSettingsPage.dart';
import 'package:smartflask/goalsPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedData = prefs.getString('userData');
    if (storedData != null) {
      setState(() {
        userData = Map<String, dynamic>.from(jsonDecode(storedData));
      });
    } else {
      await _fetchUserData();
    }
  }

  Future<void> _fetchUserData() async {
    DocumentSnapshot snapshot = await _firestore
        .collection('users')
        .doc(AuthenticationHelper().uid)
        .get();
    userData = snapshot.data() as Map<String, dynamic>?;
    if (userData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userData', jsonEncode(userData));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: userData == null
            ? CircularProgressIndicator()
            : SingleChildScrollView(
              child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                elevation: 10,
                margin: EdgeInsets.all(15),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            DetailedUserPage(userData: userData)));
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 50),
                        Text(
                          userData!['fullname'].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Date joined",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(width: 10),
              
                            // Updated code starts here
                            Builder(
                              builder: (context) {
                                DateTime dateJoined;
              
                                if (userData!["dateJoined"] is Timestamp) {
                                  dateJoined = (userData!["dateJoined"] as Timestamp).toDate();
                                } else if (userData!["dateJoined"] is String) {
                                  dateJoined = DateTime.parse(userData!["dateJoined"]);
                                } else if (userData!["dateJoined"] is int) {
                                  dateJoined = DateTime.fromMillisecondsSinceEpoch(userData!["dateJoined"]);
                                } else {
                                  dateJoined = DateTime.now(); // Or handle error appropriately
                                }
              
                                String formattedDate = DateFormat('MM/dd/yyyy').format(dateJoined);
              
                                return Text(
                                  formattedDate,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              },
                            ),
                            // Updated code ends here
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Goals',
                      style: TextStyle(fontSize: 30),
                    ),
                    Container(
                      height: 140,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          CustomCard(
                            icon: Icons.water_drop_outlined,
                            title: 'Water Consumption',
                            subTitle: '2 Goals',
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      GoalsPage(sectionToScroll: 'Water Consumption'),
                                ),
                              );
                            },
                          ),
                          CustomCard(
                            icon: Icons.fitness_center_rounded,
                            title: 'Activity',
                            subTitle: '2 Goals',
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      GoalsPage(sectionToScroll: 'Activity'),
                                ),
                              );
                            },
                          ),
                          CustomCard(
                            icon: Icons.favorite_border_outlined,
                            title: 'Health',
                            subTitle: '2 Goals',
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      GoalsPage(sectionToScroll: 'Health'),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Bottle',
                      style: TextStyle(fontSize: 30),
                    ),
                    CustomCard(icon: Icons.developer_board,
                        title: "Device Settings",
                        subTitle: "Set or Change Bottle Settings",
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => DeviceSettingsPage()));
                        }
                        )
                  ],
                ),
              ),
                        ],
                      ),
            ),
      ),
    );
  }
}
