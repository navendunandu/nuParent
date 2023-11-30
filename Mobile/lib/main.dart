import 'package:flutter/material.dart';
import 'package:nu_parent/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class AppColors {
  static const primaryColor = Colors.blueAccent;
  static const accentColor = Colors.blue;
  static const white = Colors.white;
  static const black = Colors.black;
  static const green = Color.fromARGB(255, 0, 176, 6);
  static const lightpink = Color.fromARGB(255, 253,244,244);
  static const lightblue = Color.fromARGB(255, 73, 163, 237);
  static const whiteblue= Color.fromARGB(255, 207, 221, 233);
  static const darkblue = Color.fromARGB(255, 13, 71, 161);
  static const tileprimaryblue = Color.fromARGB(255, 187, 222, 251);
  static const tilesecondaryblue = Color.fromARGB(255, 227, 242, 253);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
