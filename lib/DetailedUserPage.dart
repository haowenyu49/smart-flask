import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartflask/components/firebase/authentication.dart';
import 'package:smartflask/components/loginPage.dart';

class DetailedUserPage extends StatefulWidget {
  final Map<String, dynamic>? userData;

  const DetailedUserPage({super.key, required this.userData});

  @override
  _DetailedUserPageState createState() => _DetailedUserPageState();
}

class _DetailedUserPageState extends State<DetailedUserPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _updateUserData(String key, dynamic value) async {
    // Update Firestore
    await _firestore
        .collection('users')
        .doc(AuthenticationHelper().uid)
        .update({key: value});

    // Update SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    widget.userData![key] = value;
    await prefs.setString('userData', jsonEncode(widget.userData));

    // Update the UI
    setState(() {});
  }

  // Show a dialog for editing a value
  Future<void> _showEditDialog(BuildContext context, String key, String currentValue, String label) {
    TextEditingController controller = TextEditingController(text: currentValue);

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit $label'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(labelText: label),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _updateUserData(key, controller.text); // Update data on submit
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Safely access the fields and provide default values if they are null
    String fullname = widget.userData?['fullname'] ?? 'Unknown'; // Fallback value: 'Unknown'
    String email = widget.userData?['email'] ?? 'Unknown';
    String weight = widget.userData?['weight']?.toString() ?? '0'; // Fallback value: '0'
    String dob = widget.userData?['dob'] ?? 'Unknown';

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text('User Info'),
      ),
      body: widget.userData == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Full name (clickable)
            Text(
              "Full name",
              style: TextStyle(fontSize: 24),
            ),
            GestureDetector(
              onTap: () {
                _showEditDialog(context, 'fullname', fullname, 'Full name');
              },
              child: Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                height: 100,
                child: Card(
                  elevation: 1,
                  child: Center(
                    child: Text(
                      fullname,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),

            // Email (clickable)
            Text(
              "Email",
              style: TextStyle(fontSize: 24),
            ),
            GestureDetector(
              onTap: () {
                _showEditDialog(context, 'email', email, 'Email');
              },
              child: Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                height: 100,
                child: Card(
                  elevation: 1,
                  child: Center(
                    child: Text(
                      email,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),

            // Weight (clickable)
            Text(
              "Weight",
              style: TextStyle(fontSize: 24),
            ),
            GestureDetector(
              onTap: () {
                _showEditDialog(context, 'weight', weight, 'Weight');
              },
              child: Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                height: 100,
                child: Card(
                  elevation: 1,
                  child: Center(
                    child: Text(
                      weight,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),

            // Date of Birth (clickable)
            Text(
              "Date of Birth",
              style: TextStyle(fontSize: 24),
            ),
            GestureDetector(
              onTap: () {
                _showEditDialog(context, 'dob', dob, 'Date of Birth');
              },
              child: Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                height: 100,
                child: Card(
                  elevation: 1,
                  child: Center(
                    child: Text(
                      dob,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),

            // Sign Out and Delete Account buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    AuthenticationHelper().signOut();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()), // Replace with your login screen
                          (route) => false,
                    );

                  },
                  icon: Icon(Icons.logout),
                  label: Text('Sign Out'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(255, 150, 150, 1),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    textStyle: TextStyle(fontSize: 18, color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    _showDeleteAccountDialog(context);
                  },
                  icon: Icon(Icons.delete),
                  label: Text(
                    'Delete Account',
                    style: TextStyle(fontSize: 14),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(255, 100, 100, 1),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    textStyle: TextStyle(fontSize: 18, color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Account'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Type in your password to confirm the delete.'),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await AuthenticationHelper().deleteAccount(passwordController.text);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()), // Replace with your login screen
                    (route) => false,
              );
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}
