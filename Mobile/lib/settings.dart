import 'package:flutter/material.dart';
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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new), //Back Icon
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/Vector2.png'),
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter)),
        child: ListView(
          children: [
            SizedBox(
              height: 140,
              child: Stack(
                children: [
                  Positioned(
                    left: 90,
                    top: 5,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(33, 0, 0, 0),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0, 0),
                          ),
                        ],
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 213, 232, 251),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 80,
                    top: 5,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(33, 0, 0, 0),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0, 0),
                          ),
                        ],
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 213, 232, 251),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 92,
                    top: 82,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(33, 0, 0, 0),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0, 0),
                          ),
                        ],
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 0, 131, 231),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 125,
                    top: 75,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(33, 0, 0, 0),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0, 0),
                          ),
                        ],
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 99, 137, 165),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 40,
                    top: 25,
                    child: Container(
                      width: 55,
                      height: 55,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(33, 0, 0, 0),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0, 0),
                          ),
                        ],
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 0, 82, 140),
                      ),
                    ),
                  ),
                  const Center(
                      child: Text(
                    'Settings',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        color: AppColors.darkblue),
                  ))
                ],
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(2),
              tileColor: AppColors.tileprimaryblue,
              title: const Text(
                "Child's Details",
                textAlign: TextAlign.center,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ViewProfile()));
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(2),
              tileColor: AppColors.tilesecondaryblue,
              title: const Text(
                "How to Videos",
                textAlign: TextAlign.center,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HowToVideos()));
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(2),
              tileColor: AppColors.tileprimaryblue,
              title: const Text(
                "Reminders",
                textAlign: TextAlign.center,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Reminder()));
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(2),
              tileColor: AppColors.tilesecondaryblue,
              title: const Text(
                "FAQs",
                textAlign: TextAlign.center,
              ),
              onTap: () {},
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(2),
              tileColor: AppColors.tileprimaryblue,
              title: const Text(
                "Contact",
                textAlign: TextAlign.center,
              ),
              onTap: () {},
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(2),
              tileColor: AppColors.tilesecondaryblue,
              title: const Text(
                "Share",
                textAlign: TextAlign.center,
              ),
              onTap: () {},
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(2),
              tileColor: AppColors.tileprimaryblue,
              title: const Text(
                "Legal",
                textAlign: TextAlign.center,
              ),
              onTap: () {},
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(2),
              tileColor: AppColors.tilesecondaryblue,
              title: const Text(
                "Rate",
                textAlign: TextAlign.center,
              ),
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
