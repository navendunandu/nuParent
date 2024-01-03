import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nu_parent/Components/appbar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class EditProfile extends StatefulWidget {
  final String? childId;

  const EditProfile({Key? key, required this.childId}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String name = '';
  String gender = '';
  String dob = '';
  String address = '';
  String image = 'assets/dummy-profile-pic.png';
  bool isLoading = true; // Add a loading state
  String? selectedGender;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadChildData();
  }

  void updateSelectedGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
  }

  void updateProfile() async {
    if (widget.childId != null) {
      final userDoc =
          FirebaseFirestore.instance.collection('child').doc(widget.childId);

      await userDoc.update({
        'name': nameController.text,
        'address': addressController.text,
        'gender': selectedGender,
      }).then((_) async {
        // Update the local state with the new data.
        setState(() {
          name = nameController.text;
          address = addressController.text;
        });

        // Handle updating the profile picture here (if needed).
        if (_selectedImage != null) {
          final storage = FirebaseStorage.instance;
          final Reference storageRef =
              storage.ref().child('user_profile_images/${widget.childId}.jpg');
          final UploadTask uploadTask =
              storageRef.putFile(File(_selectedImage!.path));

          await uploadTask.whenComplete(() async {
            final imageUrl = await storageRef.getDownloadURL();
            setState(() {
              image = imageUrl; // Update profileImageUrl with new URL
            });
            userDoc.update({
              'imageUrl': imageUrl,
            });
          });
        }

        // Show a success message or navigate to another page.
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Profile updated successfully'),
        ));
      }).catchError((error) {
        print('Error updating user data: $error');
        // Handle the error.
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error updating profile: $error'),
        ));
      });
    }
  }

  Future<void> loadChildData() async {
    if (widget.childId != "") {
      try {
        final userDoc =
            FirebaseFirestore.instance.collection('child').doc(widget.childId);
        final documentSnapshot = await userDoc.get();

        if (documentSnapshot.exists) {
          final childData = documentSnapshot.data();
          setState(() {
            name = childData?['name'] ?? 'Name not Found';
            address = childData?['address'] ?? 'address not Found';
            dob = childData?['dateOfBirth'] ?? 'dateOfBirth not Found';
            selectedGender = childData?['gender'] ?? 'gender not Found';

            if (childData?['imageUrl'] != null) {
              image = childData?['imageUrl'];
            }

            isLoading = false; // Set loading state to false
          });
        }
      } catch (error) {
        // Handle any potential errors
        print('Error retrieving user data: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? _buildLoading() // Show loading indicator while data is being fetched
          : buildProfileContent(), // Show content when data is loaded
    );
  }

  Widget _buildLoading() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/Logo.png',
            height: 150,
          ),
          const SizedBox(height: 40),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }

  Widget buildProfileContent() {
    return Container(
      decoration: const BoxDecoration(
          gradient: RadialGradient(
        colors: [
          Color.fromARGB(255, 245, 251, 255),
          Color.fromARGB(255, 175, 203, 244),
        ],
        radius: .5, // Adjust the radius based on your preference
        center: Alignment(0.2, -.6),
      )),
      child: ListView(
        children: [
          CustomAppBar(),
          Form(
              child: Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              children: [
                Text(
                  'Edit Profile',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _pickImage(); // Open image picker
                  },
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: _selectedImage != null
                        ? FileImage(File(_selectedImage!.path))
                        : (image != "assets/dummy-profile-pic.png"
                            ? NetworkImage(image)
                            : AssetImage('assets/dummy-profile-pic.png')
                                as ImageProvider),
                    child: Icon(Icons.edit),
                  ),
                ),

                SizedBox(height: 20),
                // Registration Details with Edit Buttons
                ListTile(
                  title: Text('Name: $name'),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Handle editing the name field.
                      nameController.text =
                          name; // Initialize the field with current value.
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Edit Name'),
                            content: TextField(
                              controller: nameController,
                              decoration: InputDecoration(hintText: 'New Name'),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  updateProfile();
                                  Navigator.of(context).pop();
                                },
                                child: Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
                ListTile(
                  title: Text('Address: $address'),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Handle editing the email field.
                      addressController.text =
                          address; // Initialize the field with the current value.
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Edit Email'),
                            content: TextField(
                              controller: addressController,
                              decoration:
                                  InputDecoration(hintText: 'New Email'),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  updateProfile();
                                  Navigator.of(context).pop();
                                },
                                child: Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Gender",
                    style: TextStyle(fontSize: 18.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildGenderButton(Icons.male, 'male'), // Male button
                    buildGenderButton(Icons.female, 'female'), // Female button
                    buildGenderButton(
                        Icons.transgender, 'others'), // Female button
                  ],
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ))
        ],
      ),
    );
  }

  XFile? _selectedImage;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = XFile(pickedFile.path);
      });
    }
  }

  Widget buildGenderButton(IconData icon, String gender) {
    return OutlinedButton(
      style: ButtonStyle(
        side: MaterialStateProperty.all(BorderSide(
          width: 1,
          color: selectedGender == gender ? Colors.blue : Color(0xff4338CA),
        )),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed) ||
                states.contains(MaterialState.selected)) {
              return Colors.blue.withOpacity(0.2);
            } else if (selectedGender == gender) {
              return Colors.blue.withOpacity(0.1);
            }
            return Colors.transparent;
          },
        ),
      ),
      onPressed: () {
        updateSelectedGender(gender);
      },
      child: Icon(icon),
    );
  }
}
