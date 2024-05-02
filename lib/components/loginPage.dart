import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Smart Flask',
                  style: TextStyle(fontSize: 30),),
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
        ));
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
                        borderRadius: BorderRadius.all(Radius.circular(25)))),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a valid email";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
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
                    )),
                obscureText: _obscureText,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a valid password";
                  }
                  return null;
                },
              ),
              SizedBox(height: 30,),
              SizedBox(
                height: 60,
                child: FilledButton(

                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      shape:
                      MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25))),
                    ),

                    onPressed: () {},
                    child: Text('Login')

                ),
              ),
              
              TextButton(
                onPressed: () {
                  // Handle tap: Navigate to registration screen
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
                  InkWell(
                    onTap: () {
                      // Handle button tap
                    },
                    child: Container(
                      padding: EdgeInsets.all(3),
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        child: Image.network(
                          'https://pngimg.com/uploads/apple_logo/apple_logo_PNG19666.png',
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  InkWell(
                    onTap: () {
                      // Handle button tap
                    },
                    child: Container(
                      padding: EdgeInsets.all(3),
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        child: Image.network(
                          'http://pngimg.com/uploads/google/google_PNG19635.png',
                          height: 25,
                          width: 25,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not a member?',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 2,),
                  TextButton(
                    onPressed: () {
                      // Handle tap: Navigate to registration screen
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
        ));
  }
}