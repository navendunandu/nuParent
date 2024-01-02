import 'package:flutter/material.dart';
import 'package:nu_parent/Components/appbar.dart';
import 'package:nu_parent/Components/box.dart';
import 'package:nu_parent/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tts/flutter_tts.dart';

class PregnantOralHygiene extends StatefulWidget {
  const PregnantOralHygiene({super.key});

  @override
  State<PregnantOralHygiene> createState() => _PregnantOralHygieneState();
}

class _PregnantOralHygieneState extends State<PregnantOralHygiene> {
  String? ageId;

  FlutterTts flutterTts = FlutterTts();
  late Future<List<Map<String, dynamic>>> _dietaryIntake;
  @override
  void initState() {
    super.initState();
    _dietaryIntake = _getData();
  }

  Future<List<Map<String, dynamic>>> _getData() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference collectionRef = firestore.collection('ageGroups');
      QuerySnapshot querySnapshot =
          await collectionRef.where('age', isEqualTo: 'Pregnant Mother').get();
      if (querySnapshot.docs.isNotEmpty) {
        // Access the first (and only) document
        DocumentSnapshot doc = querySnapshot.docs[0];
        ageId = doc.id;
        // doc.id will give you the document ID
        print('Document ID: ${doc.id}');
      } else {
        print('No document found with age = 0 - 1');
      }

      // Use the extracted age value to query the "oralHygiene" collection
      QuerySnapshot dietary = await FirebaseFirestore.instance
          .collection('oralHygiene')
          .where('age', isEqualTo: ageId)
          .get();

      // Process each document in the "oralHygiene" collection
      List<Map<String, dynamic>> data = dietary.docs
          .map((DocumentSnapshot document) =>
              document.data() as Map<String, dynamic>)
          .toList();

      return data;
    } catch (e) {
      print("Error getting data: $e");
      return [];
    }
  }

  Future speak(String stext) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.speak(stext);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            color: AppColors.white,
            image: DecorationImage(
              image: AssetImage('assets/Vector-1.png'),
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            )),
        child: ListView(
          children: [
            const CustomAppBar(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 25),
                        child: Text(
                          'Pregnant Mothers Oral Hygiene',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  'assets/PregnentMother.png',
                  height: 150,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Good Dental Health Is Important When Pregnant',
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'When you’re pregnant, you may be more prone to gum disease and cavities, which can affect your baby’s health. Follow these 3 steps to protect your teeth:',
                    style: TextStyle(
                        color: Colors.red[700], fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _dietaryIntake,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While data is being fetched, show a custom loading layout
                    return Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/Logo.png', // Replace with the path to your logo
                            height: 100,
                          ),
                          const SizedBox(height: 16),
                          const CircularProgressIndicator(),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    // If an error occurs during data fetching, show an error message
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    // If no data is available, show a message indicating no data
                    return const Text('No dental visit data available');
                  } else {
                    // If data is available, create Box widgets with custom layout
                    final dataList = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: dataList.length,
                      itemBuilder: (context, index) {
                        final text =
                            dataList[index]['oralHygiene'] as String? ??
                                'Default Text';
                        return Column(
                          children: [
                            Box(
                              text: text,
                              flutterTts: flutterTts,
                            ),
                          ],
                        );
                      },
                    );
                  }
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
