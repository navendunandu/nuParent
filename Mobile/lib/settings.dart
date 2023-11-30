import 'package:flutter/material.dart';
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
                onPressed: () {},
                icon: const Icon(Icons.arrow_back_ios_new), //Back Icon
              ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/Vector2.png'), fit: BoxFit.cover, alignment: Alignment.bottomCenter)
        ),
        child: ListView(
          children: [
            const SizedBox(
              height: 90,
              child: Stack(
                children: [
                  Center(child: Text('Settings', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500, color: AppColors.darkblue),))
                ],
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(6),
              tileColor: AppColors.tileprimaryblue,
              title: const Text("Child's Details", textAlign: TextAlign.center,),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const ViewProfile()));
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(6),
              tileColor: AppColors.tilesecondaryblue,
              title: const Text("How to Videos", textAlign: TextAlign.center,),
              onTap: (){},
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(6),
              tileColor: AppColors.tileprimaryblue,
              title: const Text("Remainders", textAlign: TextAlign.center,),
              onTap: (){},
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(6),
              tileColor: AppColors.tilesecondaryblue,
              title: const Text("FAQs", textAlign: TextAlign.center,),
              onTap: (){},
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(6),
              tileColor: AppColors.tileprimaryblue,
              title: const Text("Contact", textAlign: TextAlign.center,),
              onTap: (){},
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(6),
              tileColor: AppColors.tilesecondaryblue,
              title: const Text("Share", textAlign: TextAlign.center,),
              onTap: (){},
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(6),
              tileColor: AppColors.tileprimaryblue,
              title: const Text("Legal", textAlign: TextAlign.center,),
              onTap: (){},
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(6),
              tileColor: AppColors.tilesecondaryblue,
              title: const Text("Rate", textAlign: TextAlign.center,),
              onTap: (){},
            )
          ],
        ),
      ),
    );
  }
}