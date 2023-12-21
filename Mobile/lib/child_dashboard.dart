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
  String name = 'Loading...';
  String gender = 'Loading...';
  String dob = 'Loading...';
  int age = 0;
  List<Map<String, dynamic>> childDataList = [];
  int selectedChildIndex = 0;

  int calculateAge(String dob) {
    // Parse the date string into a DateTime object
    DateTime dateOfBirth = DateFormat('dd-MM-yyyy').parse(dob);

    // Get the current date
    DateTime currentDate = DateTime.now();

    // Calculate the age
    int age = currentDate.year - dateOfBirth.year;

    // Adjust age based on the month and day
    if (currentDate.month < dateOfBirth.month ||
        (currentDate.month == dateOfBirth.month &&
            currentDate.day < dateOfBirth.day)) {
      age--;
    }

    return age;
  }

  @override
  void initState() {
    super.initState();
    _fetchChildData();
  }

  Future<void> _fetchChildData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final userId = user?.uid;
      final firestore = FirebaseFirestore.instance;
      final childCollection = firestore.collection('child');

      Query query = childCollection.where('userId', isEqualTo: userId);
      query.get().then((QuerySnapshot querySnapshot) {
        childDataList.clear(); // Clear existing data
        for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> childData =
              documentSnapshot.data() as Map<String, dynamic>;
          childDataList.add(childData);
        }

        // Update UI with the first child's data
        if (childDataList.isNotEmpty) {
          setState(() {
            updateUI(0);
          });
        }
      });
    } catch (e) {
      print('Error retrieving child data: $e');
    }
  }

  void updateUI(int index) {
    Map<String, dynamic> selectedChild = childDataList[index];
    name = selectedChild['name'];
    gender = selectedChild['gender'];
    dob = selectedChild['dob'];
    age = calculateAge(dob);
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
                            ), //Selected Child's Name
                            PopupMenuButton<int>(
                              icon: const Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: AppColors.primaryColor,
                              ),
                              itemBuilder: (BuildContext context) {
                                return List.generate(
                                  childDataList.length,
                                  (index) => PopupMenuItem<int>(
                                    value: index,
                                    child: ListTile(
                                      title: Text(childDataList[index]['name']),
                                    ),
                                  ),
                                );
                              },
                              onSelected: (int index) {
                                setState(() {
                                  selectedChildIndex = index;
                                  updateUI(index);
                                });
                              },
                            ) // This is where the dropdown of other child
                          ],
                        ),
                        Text(
                          "$gender, $age years",
                          style: const TextStyle(
                              fontSize: 20,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w500),
                        ) //Selected Child's Age and Gender
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
