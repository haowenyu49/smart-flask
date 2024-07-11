import "package:flutter/material.dart";

class DetailedUserPage extends StatelessWidget {
  final Map<String, dynamic>? userData;

  const DetailedUserPage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Info'),
      ),
      body: userData == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Full name",
              style: TextStyle(fontSize: 24),
            ),
            Container(
              padding: EdgeInsets.all(8),
              width: double.infinity,
              height: 100,
              child: Card(
                  elevation: 1,
                  child: Center(
                      child: Text(
                        "${userData!['fullname'].toString()}",
                        style: TextStyle(fontSize: 18),
                      ))),
            ),
            Text(
              "Email",
              style: TextStyle(fontSize: 24),
            ),
            Container(
              padding: EdgeInsets.all(8),
              width: double.infinity,
              height: 100,
              child: Card(
                  elevation: 1,
                  child: Center(
                      child: Text(
                        "${userData!['email'].toString()}",
                        style: TextStyle(fontSize: 18),
                      ))),
            ),
            Text(
              "Weight",
              style: TextStyle(fontSize: 24),
            ),
            Container(
              padding: EdgeInsets.all(8),
              width: double.infinity,
              height: 100,
              child: Card(
                  elevation: 1,
                  child: Center(
                      child: Text(
                        "${userData!['weight'].toString()}",
                        style: TextStyle(fontSize: 18),
                      ))),
            ),
            Text(
              "Date of Birth",
              style: TextStyle(fontSize: 24),
            ),
            Container(
              padding: EdgeInsets.all(8),
              width: double.infinity,
              height: 100,
              child: Card(
                  elevation: 1,
                  child: Center(
                      child: Text(
                        "${userData!['dob'].toString()}",
                        style: TextStyle(fontSize: 18),
                      ))),
            ),
            SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
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
                  onPressed: () {},
                  icon: Icon(Icons.delete),
                  label: Text('Delete Account'),
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
}
