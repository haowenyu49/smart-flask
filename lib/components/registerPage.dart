import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// Note: Make sure you have 'flutter_svg' package added to your pubspec.yaml file.

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 48), // Provides spacing at the top
                Text(
                  'Register',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Open Sans Hebrew'
                  ),
                ),
                SizedBox(height: 8), // Space between "Register" and "Welcome"
                Text(
                  'Welcome!',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Open Sans Hebrew',
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(height: 32), // Space before text fields
                _buildTextField(hint: 'username'),
                SizedBox(height: 16), // Space between text fields
                _buildTextField(hint: 'email'),
                SizedBox(height: 16),
                _buildTextField(hint: 'password', obscureText: true),
                SizedBox(height: 24), // Space before the register button
                ElevatedButton(
                  child: Text('Register'),
                  onPressed: () {
                    // Handle register action
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // Button color
                    onPrimary: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.0), // Button size
                  ),
                ),
                SizedBox(height: 24), // Space before the 'or continue with' text
                Row(
                  children: [
                    Expanded(child: Divider(thickness: 1)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('or continue with'),
                    ),
                    Expanded(child: Divider(thickness: 1)),
                  ],
                ),
                SizedBox(height: 24), // Space before social buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildSocialButton(
                      assetName: 'assets/icons/apple.svg', 
                      onTap: () {
                        // Handle Apple sign in
                      },
                    ),
                    SizedBox(width: 16), // Space between buttons
                    _buildSocialButton(
                      assetName: 'assets/icons/google.svg', 
                      onTap: () {
                        // Handle Google sign in
                      },
                    ),
                  ],
                ),
                SizedBox(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 1, color: Colors.black)
                      ),
                      child: Image.network(
                        'https://pngimg.com/uploads/apple_logo/apple_logo_PNG19668.png',
                    ),
                    ),
                    SizedBox(width: 50),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(width: 1, color: Colors.black)

                      ),
                      child: Image.network(
                        'http://pngimg.com/uploads/google/google_PNG19635.png',
                      ),
                    )
                  ],
                ),
                // Space at the bottom
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String hint, bool obscureText = false}) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[200], // TextField background color
      ),
      obscureText: obscureText,
    );
  }

  Widget _buildSocialButton({required String assetName, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        assetName,
        width: 48, // Icon size
        height: 48,
      ),
    );
  }
}
