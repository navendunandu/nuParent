import 'package:flutter/material.dart';
import 'package:nu_parent/login_screen.dart';
import 'package:nu_parent/main.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Center(
                  child: Image.asset(
                'assets/success.png',
                width: 300,
              )),
              Padding(
                padding: const EdgeInsets.only(left: 138.0, top: 100),
                child: ClipOval(

                  child: Container(
                    color: AppColors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Image.asset('assets/nuParent.png', width: 50, height: 50,),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Text(
            'Registration Successfully',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          Text(
            'Welcome to nuParent.',
            style: GoogleFonts.sansita(textStyle:const TextStyle(fontSize: 32, fontWeight: FontWeight.w600, color: AppColors.primaryColor) ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            child: const Text(
              'Back to Login',
              style: TextStyle(fontSize: 20, color: AppColors.primaryColor),
            ),
          )
        ],
      ),
    );
  }
}
