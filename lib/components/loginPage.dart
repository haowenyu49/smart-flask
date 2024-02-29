import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'firebase/authentication.dart';


class LoginPage extends StatelessWidget{
  const LoginPage({super.key});

@override
Widget build(BuildContext context) {
  return Scaffold(
     appBar: AppBar(),
     body: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            borderRadius : BorderRadius.only(
              topLeft: Radius.circular(60),
              topRight: Radius.circular(60),
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60),
            ),
            color : Color.fromRGBO(246, 246, 246, 1),
          ),
          child: Column(

              children: <Widget>[
                Expanded(
                    child: Text('SmartFlask.', textAlign: TextAlign.center, style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Open Sans Hebrew',
                        fontSize: 40,
                        letterSpacing: -0.44999998807907104,
                        fontWeight: FontWeight.normal,
                        height: 1
                    ),)
                ),
                Expanded(
                    child: Text('Welcome back.', textAlign: TextAlign.center, style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Raleway',
                        fontSize: 24,
                        letterSpacing: -0.44999998807907104,
                        fontWeight: FontWeight.normal,
                        height: 1
                    ),)
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(

                      children:[
                        TextField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.account_circle_outlined),
                            labelText: 'Username',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30))
                            )
                        ),
                      ),
                        SizedBox(height: 15),
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock_outline),
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(30)
                                  ))
                          ),
                        ),
                    ]
                  ),
                ),
                Expanded(
                    child: Text('Sign in', textAlign: TextAlign.center, style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'Raleway',
                        fontSize: 24,
                        letterSpacing: -0.44999998807907104,
                        fontWeight: FontWeight.normal,
                        height: 1
                    ),)
                ),Expanded(
                    child: Text('or continue with', textAlign: TextAlign.center, style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Raleway',
                        fontSize: 20,
                        letterSpacing: -0.44999998807907104,
                        fontWeight: FontWeight.normal,
                    ),)
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        // Handle button tap
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          child: Image.network(
                            'http://pngimg.com/uploads/google/google_PNG19635.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 10,),
                    InkWell(
                      onTap: () {
                        // Handle button tap
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          child: Image.network(
                            'https://pngimg.com/uploads/apple_logo/apple_logo_PNG19668.png',
                            height: 25,
                            width: 25,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      // Handle tap: Navigate to registration screen
                    },
                    child: Text(
                      'Not a member? Register Now',
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
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      // Handle tap: Navigate to forgot password screen
                    },
                    child: Text(
                      'Forgot Password?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.33000001311302185),
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
                ),
                Expanded(
                    child: Divider(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        thickness: 1
                    )
                ),
              ]
          )
      )
  );
}

}
