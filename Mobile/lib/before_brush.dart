import 'package:flutter/material.dart';
import 'package:nu_parent/Reminder.dart';
import 'package:nu_parent/main.dart';
import 'package:nu_parent/Components/appbar.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:nu_parent/Components/box.dart';

class BeforeBrush extends StatefulWidget {
  const BeforeBrush({super.key});

  @override
  State<BeforeBrush> createState() => _BeforeBrushState();
}

class _BeforeBrushState extends State<BeforeBrush> {
  FlutterTts flutterTts = FlutterTts();

  Future speak(String stext) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.speak(stext);
  }

  List<Map<String, dynamic>> items1 = [
    {
      "title": "Determine if Your Child Really Needs a Fluoridated Toothpaste",
      "text":
          "Consult your dentist to find out if your child needs a fluoridated toothpaste. "
    },
    {
      "title": "Check the Fluoride Content",
      "text":
          "Children up to the age of 2 tend to swallow their toothpaste, which is harmful as ingesting fluoride can cause sickness. Hence, always pick a toothpaste that is designed for children and has fluoride content not more than 1000 ppm.  Fluoride helps in strengthening tooth enamel and preventing tooth decay.",
    },
    {
      "title": "Pick a Child-friendly Flavour",
      "text":
          "Mint is the most popular flavour for oral products throughout the world. However, when it comes to children, they prefer fruity flavours like strawberry or watermelon."
    },
  ];

  final List<String> item2 = [
    'You should never store your brush in a closed or airtight container, as bacteria love moisture and will thrive in this environment. Instead, place the brush in a cup or holder in an upright position to ensure that it dries off thoroughly. Avoid putting it in a drawer or cabinet, as well.',
    'A healthy mouth will require a clean and sanitary toothbrush, and by taking the time to make sure that you are storing yours properly, you can ensure that you are cleaning your teeth as effectively as possible.',
    'Parents or carers should brush the teeth more than once daily.',
    'Brush your child’s teeth last thing at night before bed and on 1 other occasion.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  'assets/MotherChild.png',
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
                    colour: AppColors.red,
                  );
                },
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Center(
              child: Text(
                'Why is it better to floss before brushing?',
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
                    colour: AppColors.red,
                  );
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
                child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Reminder()));
              },
              child: const Text(
                'Set Reminder',
                style: TextStyle(fontSize: 20),
              ),
            )),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
