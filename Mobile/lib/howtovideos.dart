import 'package:flutter/material.dart';
import 'package:nu_parent/main.dart';

class HowToVideos extends StatefulWidget {
  const HowToVideos({super.key});

  @override
  State<HowToVideos> createState() => _HowToVideosState();
}

class _HowToVideosState extends State<HowToVideos> {
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
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/Vector2.png'),
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter)),
        child: Padding(padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 300,
                  child: Text('What causes cavities?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.darkblue),)),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                    color: AppColors.black, // Border color
                    width: 2.0, // Border width
                  ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.asset('assets/Cavities.png',fit: BoxFit.cover, height: 150, width: 300, ))),
                const SizedBox(
                  height: 25,
                ),
                const SizedBox(
                  width: 300,
                  child: Text('Parents’ Guide to Tooth brushing for Children ages 0-2 years old', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.darkblue),)),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                    color: AppColors.black, // Border color
                    width: 2.0, // Border width
                  ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.asset('assets/Baby.png',fit: BoxFit.cover, height: 150, width: 300, ))),
                const SizedBox(
                  height: 25,
                ),
                const SizedBox(
                  width: 300,
                  child: Text('Parents’ Guide to Toothbrushing and Flossing for Children ages 3-6 years old', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.darkblue),)),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                    color: AppColors.black, // Border color
                    width: 2.0, // Border width
                  ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.asset('assets/Brushing.png',fit: BoxFit.cover, height: 150, width: 300, ))),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),),
      ),
    );
  }
}