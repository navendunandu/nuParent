import 'package:flutter/material.dart';
import 'package:nu_parent/Components/bottom_bar.dart';
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

  bool isPlaying = false;

  Future speak(String stext) async {
    if (isPlaying) {
      print('Speech Stops');
      flutterTts.stop();
      setState(() {
        isPlaying = false;
      });
    } else {
      await flutterTts.setLanguage("en-US");
      await flutterTts.speak(stext);
      setState(() {
        isPlaying = true;
      });
    }
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
    'Do not wet the toothbrush before use.',
    'Seek advice from a dentist on whether your child would benefit from interdental flossing.',
    'Floss before brushing. If you floss after brushing, food, plaque, and bacteria will remain in your mouth until you brush again.',
    'The fluoride in your toothpaste is also better able to protect your teeth when particles are removed first.',
  ];

  final String items3 =
      'Do not wet the toothbrush before use. Seek advice from a dentist on whether your child would benefit from interdental flossing. Floss before brushing. If you floss after brushing, food, plaque, and bacteria will remain in your mouth until you brush again. The fluoride in your toothpaste is also better able to protect your teeth when particles are removed first.';
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(),
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
                'Before Brushing',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
              child: Image.asset(
                'assets/MotherChild.png',
                height: 200,
              ),
            ),
            const Center(
              child: Text(
                'How to Choose the Best Toothbrush',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
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
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.lightblue,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2.0,
                      blurRadius: 4.0,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (String item in item2)
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 7, bottom: 7),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8, 6, 10, 0),
                                      child: Icon(
                                        Icons.circle,
                                        size: 12,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    // Text('\u2022',style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: AppColors.primaryColor)),
                                    Flexible(
                                        child: Text(item,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.primaryColor)))
                                  ],
                                ),
                              )
                            // Text(
                            //   '\u2022 $item', // Unicode character for bullet point
                            //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
                            // ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          speak(items3);
                        },
                        icon: Icon(
                          isPlaying
                              ? Icons.stop_circle_rounded
                              : Icons.volume_up_rounded,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            //   child: ListView.builder(
            //     shrinkWrap: true,
            //     physics: const NeverScrollableScrollPhysics(),
            //     itemCount: item2.length,
            //     itemBuilder: (BuildContext context, int index) {
            //       return Box(
            //         text: item2[index],
            //         flutterTts: flutterTts,
            //         colour: AppColors.primaryColor,
            //       );
            //     },
            //   ),
            // ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
