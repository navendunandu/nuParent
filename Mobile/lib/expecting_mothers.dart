import 'package:flutter/material.dart';
import 'package:nu_parent/Components/bulleted_list.dart';
import 'package:nu_parent/main.dart';

class ExpectingMothers extends StatefulWidget {
  const ExpectingMothers({super.key});

  @override
  State<ExpectingMothers> createState() => _ExpectingMothersState();
}

class _ExpectingMothersState extends State<ExpectingMothers> {
  final List<String> items = [
    'It is recommended that you visit a dentist before becoming pregnant to get any necessary dental treatments and to assess your risk of tooth and gum disease.',
    'Hormonal changes during pregnancy can increase the risk of developing dental problems such as gum disease and tooth decay, it is critical to focus on dental health during pregnancy.',
    'Emphasis on the food pyramid, eating a well-balanced diet and getting plenty of calcium. Sweets and low-nutritional foods should be avoided.',
    'Focus on low-sugar snacks, such as celery and carrot sticks, milk, cheese, and other dairy products, to reduce the risk of tooth decay.',
  ];
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
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: ListView(
            children: [
              Center(child: Image.asset('assets/EatWell.png')),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Expecting Mothers',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.darkblue,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
              const BulletList(text: 'It is recommended that you visit a dentist before becoming pregnant to get any necessary dental treatments and to assess your risk of tooth and gum disease.'),
              const BulletList(text: 'Hormonal changes during pregnancy can increase the risk of developing dental problems such as gum disease and tooth decay, it is critical to focus on dental health during pregnancy.'),
              const BulletList(text: 'Emphasis on the food pyramid, eating a well-balanced diet and getting plenty of calcium. Sweets and low-nutritional foods should be avoided.'),
              const BulletList(text: 'It is recommended that you visit a dentist before becoming pregnant to get any necessary dental treatments and to assess your risk of tooth and gum disease.'),
            ],
          ),
        ),
      ),
    );
  }
}
