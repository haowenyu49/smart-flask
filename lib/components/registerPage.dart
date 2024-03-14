// Figma Flutter Generator Frame12Widget - FRAME
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'firebase/authentication.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 393,
        height: 852,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60),
            topRight: Radius.circular(60),
            bottomLeft: Radius.circular(60),
            bottomRight: Radius.circular(60),
          ),
          color: Color.fromRGBO(246, 246, 246, 1),
        ),
        child: Stack(children: <Widget>[
          Positioned(
              top: 194,
              left: 64,
              child: Text(
                'Register',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'Open Sans Hebrew',
                    fontSize: 40,
                    letterSpacing: -0.44999998807907104,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )),
          Positioned(
              top: 257,
              left: 79,
              child: Text(
                'Welcome!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'Raleway',
                    fontSize: 24,
                    letterSpacing: -0.44999998807907104,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )),
          Positioned(
              top: 312,
              left: 52,
              child: Container(
                  width: 288,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    border: Border.all(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      width: 1,
                    ),
                  ))),
          Positioned(
              top: 390,
              left: 52,
              child: Container(
                  width: 288,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    border: Border.all(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      width: 1,
                    ),
                  ))),
          Positioned(
              top: 468,
              left: 52,
              child: Container(
                  width: 288,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    border: Border.all(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      width: 1,
                    ),
                  ))),
          Positioned(
              top: 330,
              left: 40,
              child: Text(
                'username',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    fontFamily: 'Raleway',
                    fontSize: 16,
                    letterSpacing: -0.44999998807907104,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )),
          Positioned(
              top: 486,
              left: 36,
              child: Text(
                'password',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.23000000417232513),
                    fontFamily: 'Raleway',
                    fontSize: 16,
                    letterSpacing: -0.44999998807907104,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )),
          Positioned(
              top: 408,
              left: 66,
              child: Text(
                'email',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.23000000417232513),
                    fontFamily: 'Raleway',
                    fontSize: 16,
                    letterSpacing: -0.44999998807907104,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )),
          Positioned(
            top: 558,
            left: 52,
            child: SvgPicture.asset('assets/images/rectangle4154.svg',
                semanticsLabel: 'rectangle4154'),
          ),
          Positioned(
              top: 571,
              left: 118,
              child: Text(
                'Register',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontFamily: 'Raleway',
                    fontSize: 24,
                    letterSpacing: -0.44999998807907104,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )),
          Positioned(
              top: 663,
              left: 81,
              child: Text(
                'or continue with',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'Raleway',
                    fontSize: 20,
                    letterSpacing: -0.44999998807907104,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )),
          Positioned(
              top: 680,
              left: 277,
              child: Divider(color: Color.fromRGBO(0, 0, 0, 1), thickness: 1)),
          Positioned(
              top: 680,
              left: 17,
              child: Divider(color: Color.fromRGBO(0, 0, 0, 1), thickness: 1)),
          Positioned(
              top: 737,
              left: 108,
              child: Container(
                  width: 36,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 36,
                            height: 44,
                            child: Stack(children: <Widget>[
                              Positioned(
                                top: 0,
                                left: 0,
                                child: SvgPicture.asset(
                                    'assets/images/vector.svg',
                                    semanticsLabel: 'vector'),
                              ),
                            ]))),
                  ]))),
          Positioned(
              top: 734,
              left: 232,
              child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                  child: Stack(children: <Widget>[
                    Positioned(
                      top: 21.66666603088379,
                      left: 26,
                      child: SvgPicture.asset('assets/images/vector.svg',
                          semanticsLabel: 'vector'),
                    ),
                    Positioned(
                      top: 30.528331756591797,
                      left: 4.701666831970215,
                      child: SvgPicture.asset('assets/images/vector.svg',
                          semanticsLabel: 'vector'),
                    ),
                    Positioned(
                      top: 15.29666805267334,
                      left: 2.1666648387908936,
                      child: SvgPicture.asset('assets/images/vector.svg',
                          semanticsLabel: 'vector'),
                    ),
                    Positioned(
                      top: 2.1666667461395264,
                      left: 4.701666831970215,
                      child: SvgPicture.asset('assets/images/vector.svg',
                          semanticsLabel: 'vector'),
                    ),
                    Positioned(
                      top: 2.1666667461395264,
                      left: 2.1666667461395264,
                      child: SvgPicture.asset('assets/images/vector.svg',
                          semanticsLabel: 'vector'),
                    ),
                  ]))),
          Positioned(
              top: 719,
              left: 85,
              child: Container(
                  width: 85,
                  height: 85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                    border: Border.all(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      width: 1,
                    ),
                  ))),
          Positioned(
              top: 716,
              left: 215,
              child: Container(
                  width: 85,
                  height: 85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                    border: Border.all(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      width: 1,
                    ),
                  ))),
        ]));
  }
}
