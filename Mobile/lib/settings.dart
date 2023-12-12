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
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/Vector-1.png'),
                 fit: BoxFit.scaleDown, alignment: Alignment.bottomCenter,
               )),
        child: ListView(
          children: [
            const SizedBox(
                height: 140,
                child: Center(
                    child: Text(
                  'Settings',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkblue),
                ))),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Reminder()));
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
