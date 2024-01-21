import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nu_parent/Components/appbar.dart';
import 'package:nu_parent/brushing_instruction.dart';
import 'package:nu_parent/childprofile_pop.dart';
import 'package:nu_parent/dental_visit.dart';
import 'package:nu_parent/dietary_intake.dart';
import 'package:nu_parent/dietary_intake_birth.dart';
import 'package:nu_parent/dietary_intake_one.dart';
import 'package:nu_parent/dietary_intake_two.dart';
import 'package:nu_parent/main.dart';
import 'package:nu_parent/oral_hygiene.dart';
import 'package:nu_parent/oral_hygiene_babies.dart';
import 'package:nu_parent/oral_hygiene_children.dart';
import 'package:nu_parent/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ChildDashboard extends StatefulWidget {
  const ChildDashboard({super.key});

  @override
  State<ChildDashboard> createState() => _ChildProfileState();
}

class _ChildProfileState extends State<ChildDashboard> {
  String? id;
  String name = '';
  String gender = '';
  String dob = '';
  late int childAge;
  int? childMonth;
  List<Map<String, dynamic>> childDataList = [];

  void calculateAge(String dateOfBirth) {
    try {
      DateTime birthDate = DateFormat("dd-MM-yyyy").parse(dateOfBirth);

      DateTime currentDate = DateTime.now();
      Duration difference = currentDate.difference(birthDate);

      if (difference.inDays < 365) {
        int ageInMonths = (difference.inDays / 30).floor();
        setState(() {
          childAge = ageInMonths;
          childMonth = 0;
        });
      } else if (difference.inDays < 365 * 2) {
        // Less than two years
        int ageInYears = (difference.inDays / 365).floor();
        print('Calculated Age: $ageInYears year');
        setState(() {
          childAge = ageInYears;
          childMonth = 0;
        });
      } else {
        // More than two years
        int ageInYears = (difference.inDays / 365).floor();
        int ageInMonths = ((difference.inDays % 365) / 30).floor();
        print('Calculated Age: $ageInYears years and $ageInMonths months');
        setState(() {
          childAge = ageInYears;
          childMonth = ageInMonths;
        });
      }
    } catch (e) {
      print("Error parsing date of birth: $e");
    }
  }

  List<Map<String, dynamic>> ChildDocs = [];

  Future<void> loadChildData() async {
  final user = FirebaseAuth.instance.currentUser;
  final userId = user?.uid;
  final firestore = FirebaseFirestore.instance;
  final childCollection = firestore.collection('child');

  final query = childCollection.where('userId', isEqualTo: userId);

  QuerySnapshot querySnapshot;
  try {
    querySnapshot = await query.get();
  } catch (error) {
    print('Error getting documents: $error');
    // You might want to throw an error or handle it as needed
    rethrow;
  }
  
  if (querySnapshot.docs.isEmpty) {
    // Redirect to a new page because there is no data
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ChildProfilePop(docId: user!.uid)), // Replace 'NoChildDataPage' with the actual new page widget
    );
    return;
  }

  ChildDocs.clear();
  querySnapshot.docs.forEach((DocumentSnapshot document) {
    // Access the data in each document
    // print('${document.id} => ${document.data()}');
    Map<String, dynamic> documentData =
        document.data() as Map<String, dynamic>;

    if (name.isEmpty) {
      id = documentData['id'];
      name = documentData['name'];
      gender = documentData['gender'];
      dob = documentData['dateOfBirth'];
      calculateAge(dob);
    }
    ChildDocs.add(documentData);
    // print('Name: $name');
  });
}


  String displayAge() {
    if (childAge == 0) {
      return "$childMonth months";
    } else {
      return "$childAge years";
    }
  }

  void _childChange(Map<String, dynamic> selectedChild) {
    print(selectedChild);

    setState(() {
      id = selectedChild['id'] ?? '';
      name = selectedChild['name'] ?? '';
      gender = selectedChild['gender'] ?? '';
      dob = selectedChild['dateOfBirth'] ?? '';
      calculateAge(dob);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: AppColors.lightblue,
      //   leading: IconButton(
      //     onPressed: () {
      //       exit(0);
      //     },
      //     icon: const Icon(Icons.arrow_back_ios_new),
      //   ),
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.only(right: 20.0),
      //       child: Container(
      //         decoration: const BoxDecoration(
      //           shape: BoxShape.circle,
      //           color: AppColors.primaryColor,
      //         ),
      //         child: IconButton(
      //           icon: const Icon(
      //             Icons.settings,
      //             color: AppColors.white,
      //           ),
      //           onPressed: () {
      //             Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                     builder: (context) => const SettingsScreen()));
      //           },
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      body: RefreshIndicator(
        onRefresh: () async {
        // Implement the logic to reload data here
        await loadChildData();
      },
        child: FutureBuilder(
          future: loadChildData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Return a loading indicator while data is being fetched
              return Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/Logo.png', // Replace with the path to your logo
                      height: 150,
                    ),
                    const SizedBox(height: 40),
                    const CircularProgressIndicator(),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              // Handle the error if loading fails
              return Center(
                child: Text('Error loading data: ${snapshot.error}'),
              );
            } else {
              // Data has been successfully loaded, display the main content
              return buildMainContent();
            }
          },
        ),
      ),
    );
  }

  Widget buildMainContent() {
    return ListView(
      children: [
        CustomAppBar(bgColor: AppColors.lightblue,),
        Container(
          height: 250,
          decoration: BoxDecoration(
              color: AppColors.lightblue,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 8),
                )
              ],
              borderRadius:
                  const BorderRadius.only(bottomLeft: Radius.circular(70))),
          child: Stack(children: [
            Positioned(
              left: 320,
              top: 45,
              child: Container(
                width: 130,
                height: 130,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(65, 0, 0, 0),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 0),
                    ),
                  ],
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 34, 78, 147),
                ),
              ),
            ),
            Positioned(
              left: 250,
              top: 5,
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(65, 0, 0, 0),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 0),
                    ),
                  ],
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 90, 148, 201),
                ),
              ),
            ),
            Positioned(
              left: 325,
              top: 75,
              child: Container(
                width: 25,
                height: 25,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(65, 0, 0, 0),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 0),
                    ),
                  ],
                  shape: BoxShape.circle,
                  color: Color.fromARGB(150, 255, 231, 231),
                ),
              ),
            ),
            Positioned(
              left: 300,
              top: 110,
              child: Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(65, 0, 0, 0),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 0),
                    ),
                  ],
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 55, 92, 154),
                ),
              ),
            ),
            Positioned(
              left: 320,
              top: 150,
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(65, 0, 0, 0),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 0),
                    ),
                  ],
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryColor),
                          ),
                          PopupMenuButton<String>(
                            icon: const Icon(Icons.keyboard_arrow_down_rounded),
                            itemBuilder: (BuildContext context) {
                              return ChildDocs.map(
                                  (Map<String, dynamic> child) {
                                return PopupMenuItem<String>(
                                  onTap: () {
                                    print(child);
                                    _childChange(child);
                                  },
                                  value: child['id'],
                                  child: Text(child['name']),
                                );
                              }).toList();
                            },
                          ),
                        ],
                      ),
                      Text(
                        "$gender, ${displayAge()}",
                        style: const TextStyle(
                            fontSize: 20,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  )
                ],
              ),
            ),
          ]),
        ),
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                if (childAge! <= 3) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OralHygieneBabies()));
                } else if (childAge! <= 6) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OralHygieneChildren()));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OralHygiene()));
                }
              },
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      )
                    ]),
                child: const Center(
                    child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Oral hygiene',
                    style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                )),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (childAge! <= 1) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DietaryIntakeBirth()));
                } else if (childAge! <= 2) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DietaryIntakeOne()));
                } else if (childAge! <= 6) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DietaryIntakeTwo()));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DietaryIntake()));
                }
              },
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      )
                    ]),
                child: const Center(
                    child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Dietary intake',
                    style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                )),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BrushingInstruction(age: childAge,)));
              },
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      )
                    ]),
                child: const Center(
                    child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Brushing instructions',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                )),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DentalVisit()));
              },
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      )
                    ]),
                child: const Center(
                    child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Dental visits',
                    style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                )),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  @override
  void dispose() {
    // Dispose of your animation controllers here
    super.dispose();
  }
}
