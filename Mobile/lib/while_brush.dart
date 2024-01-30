import 'package:flutter/material.dart';
import 'package:nu_parent/main.dart';
import 'package:nu_parent/Components/appbar.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:nu_parent/Components/box.dart';
import 'package:nu_parent/timer.dart';

class WhileBrush extends StatefulWidget {
  const WhileBrush({super.key});

  @override
  State<WhileBrush> createState() => _WhileBrushState();
}

class _WhileBrushState extends State<WhileBrush> {
  FlutterTts flutterTts = FlutterTts();

  Future speak(String stext) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.speak(stext);
  }

  final List<String> items = [
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
            const Center(
              child: Text(
                'After Brushing',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
            Image.asset('assets/FamilyBrushing2.jpg'),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: ListView.builder(
                shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return Box(
                    text: items[index],
                    flutterTts: flutterTts,
                    colour: AppColors.primaryColor, 
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => CountdownPage(),));
              }, child: const Text('Timer', style: TextStyle(color: AppColors.primaryColor),)),
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset('assets/BrushBasket.png', height: 200,),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
