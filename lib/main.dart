import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smartflask/SplashScreen.dart';

import 'package:smartflask/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Raleway',
        colorScheme: ColorScheme(
            primary: Colors.blue,
            secondary: Colors.blueAccent,
            surface: Colors.white70,
            background: Colors.white,
            error: Colors.red,
            onPrimary: Colors.black,
            onSecondary: Colors.black,
            onBackground: Colors.white,
            onSurface: Colors.black,
            onError: Colors.white,
            brightness: Brightness.light
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}