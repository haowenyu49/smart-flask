import 'package:flutter/material.dart';
import 'package:smartflask/Dashboard.dart';
import 'package:smartflask/components/firebase/authentication.dart';
import 'package:smartflask/components/homepage.dart';
import 'package:smartflask/components/registerPage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('Smart Flask',
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(height: 40),
                Text('Log in',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                    textAlign: TextAlign.center),
                SizedBox(height: 20),
                LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool _obscureText = true;
  bool _isLoading = false;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter an email";
    }
    String pattern = r'^[^@]+@[^@]+\.[^@]+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a password";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: email,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.alternate_email),
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
              ),
              validator: _validateEmail,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: password,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                labelText: 'Password',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(_obscureText
                      ? Icons.visibility_off
                      : Icons.visibility),
                ),
              ),
              obscureText: _obscureText,
              validator: _validatePassword,
            ),
            SizedBox(height: 30),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : SizedBox(
              height: 60,
              child: FilledButton(
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.blue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _isLoading = true;
                    });
                    var result = await AuthenticationHelper().signIn(
                      email: email.text,
                      password: password.text,
                    );
                    setState(() {
                      _isLoading = false;
                    });
                    if (result == null) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const Dashboard()),
                              (Route<dynamic> route) => false);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(result)));
                    }
                  }
                },
                child: Text('Login'),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
              },
              child: Text(
                'Forgot Password?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontFamily: 'Raleway',
                  fontSize: 16,
                  letterSpacing: -0.44999998807907104,
                  fontWeight: FontWeight.normal,
                  height: 1,
                ),
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero, // Removes default padding
                tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Minimizes the tap target size
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildSocialButton(
                  assetName: 'assets/icons/apple-logo.png',
                  onTap: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    var result = await AuthenticationHelper().signInWithGoogle();
                    setState(() {
                      _isLoading = false;
                    });
                    if (result == null) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const Dashboard()),
                              (Route<dynamic> route) => false);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(result)));
                    }
                  },
                ),
                SizedBox(width: 16),
                _buildSocialButton(
                  assetName: 'assets/icons/google-logo.png',
                  onTap: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    var result = await AuthenticationHelper().signInWithGoogle();
                    setState(() {
                      _isLoading = false;
                    });
                    if (result == null) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const Dashboard()),
                              (Route<dynamic> route) => false);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(result)));
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not a member?',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(width: 2),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: Text(
                    'Register Now',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontFamily: 'Raleway',
                      fontSize: 16,
                      letterSpacing: -0.44999998807907104,
                      fontWeight: FontWeight.normal,
                      height: 1,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero, // Removes default padding
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Minimizes the tap target size
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton({required String assetName, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        assetName,
        width: 48,
        height: 48,
      ),
    );
  }
}
