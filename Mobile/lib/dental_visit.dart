import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:nu_parent/Components/appbar.dart';
import 'package:nu_parent/Components/box.dart';
import 'package:nu_parent/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DentalVisit extends StatefulWidget {
  const DentalVisit({Key? key}) : super(key: key);

  @override
  State<DentalVisit> createState() => _DentalVisitState();
}

class _DentalVisitState extends State<DentalVisit> {
  late Future<List<Map<String, dynamic>>> _dentalVListFuture;
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _dentalVListFuture = _getData();
  }

  Future<List<Map<String, dynamic>>> _getData() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('dentalvisit');

    try {
      // Get documents from the collection
      QuerySnapshot querySnapshot = await collectionReference.get();

      // Process each document in the collection
      List<Map<String, dynamic>> data = querySnapshot.docs
          .map((DocumentSnapshot document) =>
              document.data() as Map<String, dynamic>)
          .toList();

      return data;
    } catch (e) {
      print("Error getting data: $e");
      return [];
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
            fit: BoxFit.scaleDown,
            alignment: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          children: [
            const CustomAppBar(),
            const Center(
              child: Text(
                'Dental visits',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
            Image.asset('assets/DentistCheck.png'),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _dentalVListFuture,
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
                      itemCount: dataList.length +
                          1, // Add 1 for the additional text item
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          // Display the first item from dataList
                          final text =
                              dataList[index]['dentalvisit'] as String? ??
                                  'Default Text';
                          return Box(
                            text: text,
                            flutterTts: flutterTts,
                          );
                        } else if (index == 1) {
                          // Display the second item from dataList
                          final text =
                              dataList[index]['dentalvisit'] as String? ??
                                  'Default Text';
                          return Box(
                            text: text,
                            flutterTts: flutterTts,
                          );
                        } else if (index == 2) {
                          // Display specific text after the first 2 items
                          return const Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Text(
                                  'What does a fluoride varnish do?',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Text(
                                  'Fluoride in varnish enters the tooth enamel and makes the tooth hard. It prevents new cavities and slows down or stops decay from getting worse. If tooth decay is just starting, it repairs the tooth.',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          );
                        } else {
                          // Display the remaining items from dataList
                          final dataIndex =
                              index - 1; // Adjust index for dataList
                          final text =
                              dataList[dataIndex]['dentalvisit'] as String? ??
                                  'Default Text';
                          return Column(
                            children: [
                              Box(
                                text: text,
                                flutterTts: flutterTts,
                              ),
                            ],
                          );
                        }
                      },
                    );
                  }
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Text(
                'Visit British Society of Pediatric Dentistry: https://www.bspd.co.uk/Kidsvids for videos on how to take care of kids teeth age wise.',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Image.asset('assets/FamilyTeethCaring.png'),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
