import 'package:flutter/material.dart';
import 'package:nu_parent/login_screen.dart';
import 'package:nu_parent/main.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: RadialGradient(
          colors: [
            Color.fromARGB(255, 245, 251, 255),
            AppColors.tileprimaryblue
          ],
          radius: .5, // Adjust the radius based on your preference
          center: Alignment(0.2, -.6),
        )),
        child: ListView(
          children: [
<<<<<<< HEAD
            Stack(
              children: [
                Center(
                    child: Image.asset(
                  'assets/success.png',
                  width: 300,
                )),
                Positioned(
                  left: 140,
                  top: 100,
                  child: ClipOval(
                    child: Container(
                      color: AppColors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Image.asset(
                          'assets/nuParent.png',
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
=======
            Center(
                child: Image.asset(
              'assets/success.png',
              width: 300,
            )),
>>>>>>> 1a2fbb1bcc3d72577c380ce4a7ec01e16ee3d455
            const Text(
              'Registration Successfully',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            Text(
              'Welcome to nuParent.',
              textAlign: TextAlign.center,
              style: GoogleFonts.sansita(
                  textStyle: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor)),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              },
              child: const Text(
                'Back to Login',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
