import 'package:flutter/material.dart';
class CustomCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;
  final VoidCallback onPressed;

  const CustomCard(
      {super.key,
        required this.icon,
        required this.title,
        required this.subTitle,
        required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed, // Trigger the onPressed function when tapped
      child: Container(
        width: 200,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          elevation: 6,
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon),
                SizedBox(height: 30),
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(subTitle, style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
