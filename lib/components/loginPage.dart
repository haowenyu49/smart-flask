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
          width: 393,
          height: 852,
          decoration: BoxDecoration(
            borderRadius : BorderRadius.only(
              topLeft: Radius.circular(60),
              topRight: Radius.circular(60),
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60),
            ),
            color : Color.fromRGBO(246, 246, 246, 1),
          ),
          child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                const Positioned(
                    top: 194,
                    child: Text('SmartFlask.', textAlign: TextAlign.center, style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Open Sans Hebrew',
                        fontSize: 40,
                        letterSpacing: -0.44999998807907104,
                        fontWeight: FontWeight.normal,
                        height: 1
                    ),)
                ),Positioned(

                    top: 257,
                    left: 79,
                    child: Text('Welcome back.', textAlign: TextAlign.center, style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Raleway',
                        fontSize: 24,
                        letterSpacing: -0.44999998807907104,
                        fontWeight: FontWeight.normal,
                        height: 1
                    ),)
                ),Positioned(
                    top: 312,
                    left: 52,
                    child: Container(
                        width: 288,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius : BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          border : Border.all(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            width: 1,
                          ),
                        )
                    )
                ),Positioned(
                    top: 390,
                    left: 52,
                    child: Container(
                        width: 288,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius : BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          border : Border.all(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            width: 1,
                          ),
                        )
                    )
                ),Positioned(
                    top: 330,
                    left: 40,
                    child: Text('username', textAlign: TextAlign.center, style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        fontFamily: 'Raleway',
                        fontSize: 16,
                        letterSpacing: -0.44999998807907104,
                        fontWeight: FontWeight.normal,
                        height: 1
                    ),)
                ),Positioned(
                    top: 407,
                    left: 40,
                    child: Text('password', textAlign: TextAlign.center, style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.23000000417232513),
                        fontFamily: 'Raleway',
                        fontSize: 16,
                        letterSpacing: -0.44999998807907104,
                        fontWeight: FontWeight.normal,
                        height: 1
                    ),)
                ),Positioned(
                    top: 491,
                    left: 52,
                    child: SvgPicture.asset(
                        'assets/images/rectangle4154.svg',
                        semanticsLabel: 'rectangle4154'
                    )
                ),Positioned(
                    top: 504,
                    left: 118,
                    child: Text('Sign in', textAlign: TextAlign.center, style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'Raleway',
                        fontSize: 24,
                        letterSpacing: -0.44999998807907104,
                        fontWeight: FontWeight.normal,
                        height: 1
                    ),)
                ),Positioned(
                    top: 571,
                    left: 79,
                    child: Text('or continue with', textAlign: TextAlign.center, style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Raleway',
                        fontSize: 20,
                        letterSpacing: -0.44999998807907104,
                        fontWeight: FontWeight.normal,
                        height: 1
                    ),)
                ),Positioned(
                    top: 800,
                    left: 64,
                    child: Text('Not a member? Register Now', textAlign: TextAlign.center, style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Raleway',
                        fontSize: 16,
                        letterSpacing: -0.44999998807907104,
                        fontWeight: FontWeight.normal,
                        height: 1
                    ),)
                ),Positioned(
                    top: 445,
                    left: 142,
                    child: Text('Forgot Password?', textAlign: TextAlign.center, style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.33000001311302185),
                        fontFamily: 'Raleway',
                        fontSize: 16,
                        letterSpacing: -0.44999998807907104,
                        fontWeight: FontWeight.normal,
                        height: 1
                    ),)
                ),Positioned(
                    top: 588,
                    left: 275,
                    child: Divider(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        thickness: 1
                    )

                ),Positioned(
                    top: 588,
                    left: 15,
                    child: Divider(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        thickness: 1
                    )

                ),Positioned(
                    top: 676,
                    left: 104,
                    child: Container(
                        width: 40,
                        height: 48,
                        decoration: BoxDecoration(
                          color : Color.fromRGBO(255, 255, 255, 1),
                        ),
                        child: Stack(
                            children: <Widget>[
                              Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                      width: 40,
                                      height: 48,

                                      child: Stack(
                                          children: <Widget>[
                                            Positioned(
                                                top: 0,
                                                left: 0,
                                                child: SvgPicture.asset(
                                                    'assets/images/vector.svg',
                                                    semanticsLabel: 'vector'
                                                )
                                            ),
                                          ]
                                      )
                                  )
                              ),
                            ]
                        )
                    )
                ),Positioned(
                    top: 672,
                    left: 232,
                    child: Container(
                        width: 57,
                        height: 57,
                        decoration: BoxDecoration(
                          color : Color.fromRGBO(255, 255, 255, 1),
                        ),
                        child: Stack(
                            children: <Widget>[
                              Positioned(
                                  top: 23.75,
                                  left: 28.5,
                                  child: SvgPicture.asset(
                                      'assets/images/vector.svg',
                                      semanticsLabel: 'vector'
                                  )
                              ),Positioned(
                                  top: 33.463748931884766,
                                  left: 5.153750419616699,
                                  child: SvgPicture.asset(
                                      'assets/images/vector.svg',
                                      semanticsLabel: 'vector'
                                  )
                              ),Positioned(
                                  top: 16.767501831054688,
                                  left: 2.374998092651367,
                                  child: SvgPicture.asset(
                                      'assets/images/vector.svg',
                                      semanticsLabel: 'vector'
                                  )
                              ),Positioned(
                                  top: 2.375,
                                  left: 5.153750419616699,
                                  child: SvgPicture.asset(
                                      'assets/images/vector.svg',
                                      semanticsLabel: 'vector'
                                  )
                              ),Positioned(
                                  top: 2.375,
                                  left: 2.375,
                                  child: SvgPicture.asset(
                                      'assets/images/vector.svg',
                                      semanticsLabel: 'vector'
                                  )
                              ),
                            ]
                        )
                    )
                ),Positioned(
                    top: 656,
                    left: 79,
                    child: Container(
                        width: 93,
                        height: 93,
                        decoration: BoxDecoration(
                          borderRadius : BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                          border : Border.all(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            width: 1,
                          ),
                        )
                    )
                ),Positioned(
                    top: 653,
                    left: 214,
                    child: Container(
                        width: 93,
                        height: 93,
                        decoration: BoxDecoration(
                          borderRadius : BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                          border : Border.all(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            width: 1,
                          ),
                        )
                    )
                ),
              ]
          )
      )
  );
}

}
