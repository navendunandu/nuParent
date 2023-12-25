// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nu_parent/Components/appbar.dart';
import 'package:nu_parent/childprofile_pop.dart';
import 'dart:io';
import 'package:nu_parent/main.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _dateController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _prefix;
  XFile? _selectedImage;
  String? _imageUrl;
  DateTime? _selectedDate;
  String? _selectedGender = '';

  bool _obscureText = true;
  // bool _isChecked = false;
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = XFile(pickedFile.path);
      });
    }
  }

  void _selectDate() async {
    final DateTime currentDate = DateTime.now();
    final DateTime lastDate = currentDate.subtract(
        const Duration(days: 6570)); // 6570 days is approximately 18 years

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate:
          _selectedDate ?? lastDate, // Use lastDate if _selectedDate is null
      firstDate: DateTime(1900, 1, 1),
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
        print(_dateController.text);
      });
    }
  }

  String? selectedPrefix;
  List<String> prefix = ['Mr', 'Mrs', 'Ms'];

  Future<void> _registerUser() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passController.text,
      );

      if (userCredential != null) {
        await _storeUserData(userCredential.user!.uid);
        Fluttertoast.showToast(
          msg: "Regsitration Successfull",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      print("Error registering user: $e");
      // Handle error, show message or take appropriate action
    }
  }

  Future<void> _storeUserData(String userId) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
          await firestore.collection('users').doc(userId).set({
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'dateOfBirth': _dateController.text,
        'prefix': _prefix,
        'gender': _selectedGender,
        'address': _addressController.text,
        // Add more fields as needed
      });

      await _uploadImage(userId);

      // Navigate to a new page with the document ID
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ChildProfilePop(docId: userId)),
      );
    } catch (e) {
      print("Error storing user data: $e");
      // Handle error, show message or take appropriate action
    }
  }

  Future<void> _uploadImage(String userId) async {
    try {
      if (_selectedImage != null) {
        Reference ref =
            FirebaseStorage.instance.ref().child('user_images/$userId.jpg');
        UploadTask uploadTask = ref.putFile(File(_selectedImage!.path));
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

        String imageUrl = await taskSnapshot.ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({
          'imageUrl': imageUrl,
        });
      }
    } catch (e) {
      print("Error uploading image: $e");
      // Handle error, show message or take appropriate action
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 138, 183, 219),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              gradient: RadialGradient(
            colors: [
              Color.fromARGB(255, 245, 251, 255),
              Color.fromARGB(255, 175, 203, 244),
            ],
            radius: .5, // Adjust the radius based on your preference
            center: Alignment(0.2, -.6),
          )),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: CustomAppBar(),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Registration',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(
                            'Please make sure all the details are right.'),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundColor: const Color(0xff4c505b),
                                  backgroundImage: _selectedImage != null
                                      ? FileImage(File(_selectedImage!.path))
                                      : _imageUrl != null
                                          ? NetworkImage(_imageUrl!)
                                          : const AssetImage(
                                                  'assets/dummy-profile-pic.png')
                                              as ImageProvider,
                                  child: _selectedImage == null &&
                                          _imageUrl == null
                                      ? const Icon(
                                          Icons.add,
                                          size: 40,
                                          color: Color.fromARGB(
                                              255, 134, 134, 134),
                                        )
                                      : null,
                                ),
                                if (_selectedImage != null || _imageUrl != null)
                                  const Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: CircleAvatar(
                                      backgroundColor: AppColors.white,
                                      radius: 18,
                                      child: Icon(
                                        Icons.edit,
                                        size: 18,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: 'Name',
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 25.0,
                            ),
                            filled: true,
                            fillColor: const Color.fromARGB(241, 241, 241, 255),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 25.0,
                            ),
                            filled: true,
                            fillColor: const Color.fromARGB(241, 241, 241, 255),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        IntlPhoneField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            hintText: 'Phone Number',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 25.0),
                            filled: true,
                            fillColor: const Color.fromARGB(241, 241, 241, 255),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none),
                          ),
                          initialCountryCode: 'GB',
                          disableLengthCheck: true,
                          onChanged: (phone) {
                            print(phone.completeNumber);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: _dateController,
                          readOnly: true,
                          decoration: InputDecoration(
                            suffixIcon:
                                const Icon(Icons.calendar_month_outlined),
                            hintText: 'Date of Birth',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 25.0),
                            filled: true,
                            fillColor: const Color.fromARGB(241, 241, 241, 255),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none),
                          ),
                          onTap: _selectDate,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            hintText: 'Prefix',
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 10.0,
                            ),
                            filled: true,
                            fillColor: const Color.fromARGB(241, 241, 241, 255),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              _prefix = newValue;
                            });
                          },
                          isExpanded: false,
                          items: prefix
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Select Gender'),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Radio<String>(
                                  activeColor: AppColors.primaryColor,
                                  value: 'Male',
                                  groupValue: _selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender = value!;
                                    });
                                  },
                                ),
                                const Text('Male'),
                              ],
                            ),
                            Row(
                              children: [
                                Radio<String>(
                                  activeColor: AppColors.primaryColor,
                                  value: 'Female',
                                  groupValue: _selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender = value!;
                                    });
                                  },
                                ),
                                const Text('Female'),
                              ],
                            ),
                            Row(
                              children: [
                                Radio<String>(
                                  activeColor: AppColors.primaryColor,
                                  value: 'Other',
                                  groupValue: _selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender = value!;
                                    });
                                  },
                                ),
                                const Text('Other'),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _addressController,
                          decoration: InputDecoration(
                            hintText: 'Address Line',
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 25.0,
                            ),
                            filled: true,
                            fillColor: const Color.fromARGB(241, 241, 241, 255),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: _obscureText,
                          controller: _passController,
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: _togglePasswordVisibility,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 25.0),
                                child: Icon(_obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                            ),
                            hintText: 'Password',
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 25.0,
                            ),
                            filled: true,
                            fillColor: const Color.fromARGB(241, 241, 241, 255),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    _registerUser();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    padding: const EdgeInsets.fromLTRB(
                                        10.0, 15, 10.0, 15),
                                  ),
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(
                                        fontSize: 20, color: AppColors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
