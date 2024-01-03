import 'package:flutter/material.dart';
import 'package:nu_parent/Components/appbar.dart';
import 'package:nu_parent/child_registration.dart';
import 'package:nu_parent/edit_profile.dart';
import 'package:nu_parent/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({super.key});

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  String? id = '';
  String name = '';
  String gender = '';
  String dob = '';
  String image = 'assets/dummy-profile-pic.png';
  int? childAge;
  int? childMonth;
  List<Map<String, dynamic>> childDataList = [];

  void calculateAge(String dateOfBirth) {
    try {
      DateTime birthDate = DateFormat("dd-MM-yyyy").parse(dateOfBirth);

      // Get the current date
      DateTime currentDate = DateTime.now();

      print('Current Date: $currentDate');
      print('DOB: $birthDate');
      print('Current Month: ${currentDate.month}');
      print('Birth Month: ${birthDate.month}');

      int birthMonth = currentDate.month - birthDate.month;
      birthMonth = birthMonth.abs();

      int age = currentDate.year - birthDate.year;

      // print('Calculated Birth Month: $birthMonth');

      if (currentDate.month < birthDate.month ||
          (currentDate.month == birthDate.month &&
              currentDate.day < birthDate.day)) {
        age--;
      }

      // print('Calculated Age: $age');
      setState(() {
        childAge = age;
        childMonth = birthMonth;
      });
    } catch (e) {
      print("Error parsing date of birth: $e");
    }
  }

  void addChild() {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;
    if (userId != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RegistrationChild(
                    docId: userId,
                    action: 'ADD',
                  )));
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
    ChildDocs.clear();
    querySnapshot.docs.forEach((DocumentSnapshot document) {
      // Access the data in each document
      // print('${document.id} => ${document.data()}');
      if (id == '') {
        id = document.id;
        print('ID: ${document.id}');
      }
      Map<String, dynamic> documentData =
          document.data() as Map<String, dynamic>;

      // Add the 'id' field to documentData
      documentData['id'] = document.id;

      if (name.isEmpty) {
        name = documentData['name'];
        gender = documentData['gender'];
        dob = documentData['dateOfBirth'];
        image = documentData['imageUrl'];
        calculateAge(dob);
      }
      ChildDocs.add(documentData);
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
      image = selectedChild['imageUrl'] ?? '';
      calculateAge(dob);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
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
            return buildProfileContent();
          }
        },
      ),
    );
  }

  Widget buildProfileContent() {
    return Container(
      height: double.infinity,
      decoration: const BoxDecoration(
          color: AppColors.white,
          image: DecorationImage(
            image: AssetImage('assets/Vector-1.png'),
            fit: BoxFit.scaleDown,
            alignment: Alignment.bottomCenter,
          )),
      child: ListView(
        children: [
          const CustomAppBar(),
          Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 25.0, right: 25.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'View Profile',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // Set background color
                        foregroundColor:
                            AppColors.primaryColor, // Set text color
                        side: const BorderSide(
                            color: AppColors.primaryColor), // Add black border
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditProfile(childId: id)));
                      },
                      child: const Text('Edit'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primaryColor,
                        elevation: 0.0, // Disable elevation
                      ),
                      onPressed: () {
                        addChild();
                      },
                      icon: const Icon(Icons.person_add_alt_1_outlined,
                          color: AppColors.primaryColor),
                      label: const Text('Add another profile',
                          style: TextStyle(color: AppColors.primaryColor)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            height: 180,
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 220, 231, 253)),
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 216, 225, 233),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: (image != "assets/dummy-profile-pic.png"
                        ? Image.network(
                            image,
                            fit: BoxFit.cover,
                            height: 100,
                          )
                        : Image.asset('assets/dummy-profile-pic.png',
                            height: 100, fit: BoxFit.cover)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black),
                  ),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    itemBuilder: (BuildContext context) {
                      return ChildDocs.map((Map<String, dynamic> child) {
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
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Child Details',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Age',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                                fontSize: 18),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Date of Birth',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                                fontSize: 18),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Gender',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                                fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            displayAge(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            dob,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            gender,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
