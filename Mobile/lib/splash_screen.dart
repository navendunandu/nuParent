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
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(image: AssetImage('assets/Vector-1.png'), fit: BoxFit.scaleDown, alignment: Alignment.bottomCenter)
        ),
        child: Center(
          child: ClipOval(
            child: Image.asset(
              'assets/nuParent.png',
              fit: BoxFit.contain,
              width: 250,
            ),
          ),
        ),
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