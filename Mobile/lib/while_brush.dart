import 'package:flutter/material.dart';
import 'package:nu_parent/main.dart';
import 'package:nu_parent/Components/appbar.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:nu_parent/Components/box.dart';
import 'package:nu_parent/timer.dart';

class WhileBrush extends StatefulWidget {
  final int age;
  const WhileBrush({Key? key, this.age = 4}) : super(key: key);

  @override
  State<WhileBrush> createState() => _WhileBrushState();
}

class _WhileBrushState extends State<WhileBrush> {
  FlutterTts flutterTts = FlutterTts();

  Future speak(String stext) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.speak(stext);
  }

  List<String> item1 = [];
  List<String> item2 = [];
  late String image = '';
  late String text = '';
  late String title = '';

  @override
  void initState() {
    super.initState();
    // print('Age=${widget.age}');
    init();
  }

  void init() {
    if (widget.age <= 2) {
      item1 = [
        "As soon as your baby's first baby tooth appears, begin brushing their teeth (usually at around 6 months). Brush teeth twice daily for about 2 minutes with fluoride toothpaste.",
        "Brush last thing at night before bed and one other time during the day, such as after breakfast.",
        "Use toothpaste that has at least 1,000ppm of fluoride (check label) for your child. However, if a dentist says otherwise, use the same toothpaste as the rest of the family.",
        "Use only a smear of toothpaste, about the size of a grain of rice.",
      ];
      item2 = [
        "Make sure children don't eat or lick toothpaste from the tube.",
        "After consuming acidic foods such as fruit juices, sour candies, and berries, make sure to brush your child’s teeth.",
        "It is safe for your child to swallow a small smear of toothpaste, this will not be harmful but they should not swallow large amounts.",
        "Be sure an adult always brushes the teeth, rather than the child brushing all alone. And a child can begin brushing their own teeth around the age of 8 years."
      ];
      image = 'assets/BabyBrush.jpg';
      text = 'Smear of toothpaste';
      title = 'Children aged 0-2 years';
    } else {
      item1 = [
        'Brush at least twice daily for about 2 minutes with fluoride toothpaste..',
        'Brush last thing at night before bed and one other time during the day, such as after breakfast.',
        'Use toothpaste with at least 1,000ppm of fluoride as indicated on the label, unless a dentist tells you otherwise, and use family toothpaste with 1,350ppm to 1,500ppm fluoride..',
        'Use only a pea-sized amount of toothpaste.',
      ];
      item2 = [
        "Spit out after brushing and don't rinse – if you rinse, the fluoride won't work as well.",
        "After consuming acidic foods such as fruit juices, sour candies, and berries, make sure to brush your child’s teeth.",
        "Make sure children don't eat or lick toothpaste from the tube.",
        "Be sure an adult always brushes the teeth, rather than the child brushing all alone. And a child can begin brushing their own teeth around the age of 8 years."
      ];
      image = 'assets/ChildBrush.jpg';
      text = 'Pea-sized blob of toothpaste';
      title = 'Children aged 3 - 6 years';
    }
  }

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
            const Center(
              child: Text(
                'While Brushing',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
            Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            Image.asset('assets/FamilyBrushing2.jpg'),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: item1.length,
                itemBuilder: (BuildContext context, int index) {
                  return Box(
                    text: item1[index],
                    flutterTts: flutterTts,
                    colour: AppColors.primaryColor,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Color.fromARGB(255, 149, 149, 149).withOpacity(0.5),
                        spreadRadius: 1.0,
                        blurRadius: 8.0,
                        offset: const Offset(2, 2),
                      )
                    ]),
                child: ClipRRect(
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
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
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
