import 'package:flutter/material.dart';
import 'package:nu_parent/Components/bottom_bar.dart';
import 'package:nu_parent/Reminder.dart';
import 'package:nu_parent/main.dart';
import 'package:nu_parent/Components/appbar.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:nu_parent/Components/box.dart';

class PrepareBrush extends StatefulWidget {
  const PrepareBrush({super.key});

  @override
  State<PrepareBrush> createState() => _AfterBrushState();
}

class _AfterBrushState extends State<PrepareBrush> {
  FlutterTts flutterTts = FlutterTts();

  Future speak(String stext) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.speak(stext);
  }

  List<Map<String, dynamic>> items1 = [
    {
      "title": "Decide on a Manual or Electric/Battery-Powered Toothbrush",
      "text":
          "Pick a toothbrush that makes brushing fun for your kids. It doesn't matter if it's an electric or manual one, as long as you spend two minutes brushing your child's teeth two times a day with fluoride toothpaste."
    },
    {
      "title": "Select the Best Type of Bristle ",
      "text":
          "A small-headed toothbrush with medium-texture bristles is recommended for brushing children’s teeth. You can also choose a toothbrush labelled and marketed according to your child’s.",
    },
    {
      "title": "Pick Out a Brush Handle that's Best for you ",
      "text":
          "Choose a toothbrush handle that suits your needs, such as one with an angled, non-slip grip, or a flexible neck handle."
    },
    {
      "title": "Brushing Grip ",
      "text":
          "Hold the brush using the palm of your hand. Avoid brushing too hard."
    },
    {
      "title": "Give Your Kids the Power to Choose",
      "text":
          "There are plenty of fun options for toothbrushes with their favourite cartoon character or animal and several kid-approved flavoured kinds of toothpaste!"
    },
    {
      "title": "Do not share the toothbrush",
      "text": "To avoid sharing the toothbrush, colour-code it."
    }
  ];

  final List<String> item2 = [
    'Replace the toothbrush when the bristles start twisting or bending, or every three months, whichever comes first.',
    "Change toothbrushes after you've had a cold or any contagious disease since the bristles can collect germs that can lead to reinfection.",
    "Store your toothbrush in a place where it will dry quickly. Don't store it in a toothbrush box, or in water after you have finished brushing.",
  ];
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: check ? BottomBar() : null,
      body: Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          image: DecorationImage(
            image: AssetImage('assets/Vector-1.png'),
            fit: BoxFit.cover,
            alignment: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          children: [
            const CustomAppBar(),
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: Text(
                'Preparing to Brush',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 0,
                      offset: const Offset(
                          4, 4), // Adjust the shadow offset as needed
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/Brushes.png',
                ),
              ),
            ),
            const Center(
              child: Text(
                'How to Choose the Best Toothbrush',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items1.length,
                itemBuilder: (BuildContext context, int index) {
                  return Box(
                    text: items1[index]["text"],
                    title: items1[index]["title"],
                    flutterTts: flutterTts,
                    colour: AppColors.primaryColor,
                  );
                },
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Center(
              child: Text(
                'Toothbrush Replacement',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: item2.length,
                itemBuilder: (BuildContext context, int index) {
                  return Box(
                    text: item2[index],
                    flutterTts: flutterTts,
                    colour: AppColors.primaryColor,
                  );
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Reminder(),
                    ));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/planning.png',
                    width: 80,
                  ),
                  Text(
                    'Set Reminder',
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
