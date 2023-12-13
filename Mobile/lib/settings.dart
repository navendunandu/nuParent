import 'package:flutter/material.dart';
import 'package:nu_parent/Components/appbar.dart';
import 'package:nu_parent/Reminder.dart';
import 'package:nu_parent/howtovideos.dart';
import 'package:nu_parent/main.dart';
import 'package:nu_parent/view_profile.dart';
// import 'package:nu_parent/main.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/Vector-1.png'),
                 fit: BoxFit.scaleDown, alignment: Alignment.bottomCenter,
               )),
        child: ListView(
          children: [
            const CustomAppBar(),
            const SizedBox(
                height: 80,
                child: Center(
                    child: Text(
                  'Settings',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor),
                ))),

            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const ViewProfile()));
              },
              child: Container(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 83, 128, 196)
                ),
                child: const Text(
                  "Edit Child's Details",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            GestureDetector(
              onTap: (){
                
              },
              child: Container(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 220, 231, 253)
                ),
                child: const Text(
                  "",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const HowToVideos()));
              },
              child: Container(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 83, 128, 196)
                ),
                child: const Text(
                  "How to Videos",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
           
            Container(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 220, 231, 253)
              ),
              child: const Text(
                "Reminders",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
                ),
                textAlign: TextAlign.center,
              ),
            ),
            
            Container(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 83, 128, 196)
              ),
              child: const Text(
                "Timers",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
                ),
                textAlign: TextAlign.center,
              ),
            ),
           
           Container(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 220, 231, 253)
              ),
              child: const Text(
                "Contact",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
                ),
                textAlign: TextAlign.center,
              ),
            ),
            
            Container(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 83, 128, 196)
              ),
              child: const Text(
                "Share",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
                ),
                textAlign: TextAlign.center,
              ),
            ),
           
           Container(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 220, 231, 253)
              ),
              child: const Text(
                "Rate the app",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
                ),
                textAlign: TextAlign.center,
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
