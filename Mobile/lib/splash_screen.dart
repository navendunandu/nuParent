import 'package:flutter/material.dart';
import 'package:nu_parent/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    gotoLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/Vector1.png',
            fit: BoxFit.cover,
          ),

          // Container with a centered image
          SizedBox(
            width: 100,
            child: Center(
              child: Image.asset(
                'assets/Logo.jpeg',
                fit: BoxFit.contain,
                width: 300,
                // Additional properties can be added here if needed
              ),
            ),
          ),
        ],
      ),
    );
  }

  void gotoLogin() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }
}
