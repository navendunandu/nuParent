import 'package:flutter/material.dart';
import 'package:nu_parent/Components/bulleted_list.dart';
import 'package:nu_parent/main.dart';

class OralHygieneChildren extends StatefulWidget {
  const OralHygieneChildren({super.key});

  @override
  State<OralHygieneChildren> createState() => _OralHygieneChildrenState();
}

class _OralHygieneChildrenState extends State<OralHygieneChildren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Center(
            child: Text(
          'Oral hygiene of children (3-6 years)',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppColors.darkblue,
              fontWeight: FontWeight.w500,
              fontSize: 18),
        )),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.more_vert_rounded)),
        ],
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/Vector2.png'),
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter)),
        child: Padding(padding: const EdgeInsets.only(left: 25.0, right: 25.0), child: ListView(
          children: const [
            BulletList(text: "Brush last thing at night and at least on one other occasion using fluoride toothpaste, usually after breakfast.")
          ],
        ),),
      ),
    );
  }
}