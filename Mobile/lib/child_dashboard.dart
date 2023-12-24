// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:nu_parent/brushing_instruction.dart';
import 'package:nu_parent/dental_visit.dart';
import 'package:nu_parent/dietary_intake.dart';
import 'package:nu_parent/main.dart';
import 'package:nu_parent/oral_hygiene.dart';
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
  int? childAge;
  int? childMonth;
  List<Map<String, dynamic>> childDataList = [];
  int selectedChildIndex = 0;

  void calculateAge(String dateOfBirth) {
    try {
      // Parse the date of birth string into a DateTime object
      DateTime birthDate = DateFormat("dd-MM-yyyy").parse(dateOfBirth);

      // Get the current date
      DateTime currentDate = DateTime.now();

      print('Current Date: $currentDate');
      print('DOB: $birthDate');
      print('Current Month: ${currentDate.month}');
      print('Birth Month: ${birthDate.month}');

      int birthMonth = currentDate.month - birthDate.month;

      // Calculate the difference between the current date and the birth date
      int age = currentDate.year - birthDate.year;

      print('Calculated Birth Month: $birthMonth');

      // Adjust the age if the birthday hasn't happened yet this year

      if (currentDate.month < birthDate.month ||
          (currentDate.month == birthDate.month &&
              currentDate.day < birthDate.day)) {
        age--;
      }

      print('Calculated Age: $age');
      setState(() {
        childAge = age;
        childMonth = birthMonth;
      });
    } catch (e) {
      // Handle any errors that might occur during parsing
      print("Error parsing date of birth: $e");
    }
  }

  List<Map<String, dynamic>> ChildDocs = [];

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;
    final firestore = FirebaseFirestore.instance;
    final childCollection = firestore.collection('child');

// Query the collection with the where condition
    final query = childCollection.where('userId', isEqualTo: userId);

    query.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((DocumentSnapshot document) {
        // Access the data in each document
        print('${document.id} => ${document.data()}');

        // Explicitly cast document.data() to Map<String, dynamic>
        Map<String, dynamic> documentData =
            document.data() as Map<String, dynamic>;

        if (name.isEmpty) {
          // Store the first item's 'name' field in the variable
          id = documentData['id'];
          name = documentData['name'];
          gender = documentData['gender'];
          dob = documentData['dateOfBirth'];
          calculateAge(dob);
        }
        ChildDocs.add(documentData);
        print('Name: $name');
        print('Gender: $gender');
        print('Age: $childAge');
      });
    }).catchError((error) {
      print('Error getting documents: $error');
    });
  }
// ChildDocs.add(documentData);
  // print('Children Details');
  // ChildDocs.forEach((map) {
  //   print('Name: ${map['name']}');
  // });

  String displayAge() {
    if (childAge == 0) {
      return "$childMonth months";
    } else {
      return "$childAge years";
    }
  }

 void _childChange(String selectedChildId) {
  print('Selected child ID: $selectedChildId');
  // Add your logic here
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.lightblue,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.settings,
                  color: AppColors.white,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsScreen()));
                },
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
                color: AppColors.lightblue,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
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
  onSelected: _childChange, // Remove the parentheses
  itemBuilder: (BuildContext context) {
    return ChildDocs.map((Map<String, dynamic> child) {
      return PopupMenuItem<String>(
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OralHygiene()));
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DietaryIntake()));
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
                          builder: (context) => const BrushingInstruction()));
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
      ),
    );
  }
}
