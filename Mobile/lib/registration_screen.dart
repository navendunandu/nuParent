import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nu_parent/child_registration.dart';
import 'dart:io';
import 'package:nu_parent/main.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _dateController = TextEditingController();
  XFile? _selectedImage;
  String? _imageUrl;
  DateTime? _selectedDate;
  String selectedGender = '';

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
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000, 1, 1),
      lastDate: DateTime(2050, 12, 31),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }

  String? selectedPrefix;
  List<String> prefix = ['Mr', 'Mrs', 'Ms'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: SingleChildScrollView(
          child: Form(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
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
                  const Text('Please make sure all the details are right.'),
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
                            child: _selectedImage == null && _imageUrl == null
                                ? const Icon(
                                    Icons.add,
                                    size: 40,
                                    color:  Color.fromARGB(255, 134, 134, 134),
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
                    height: 30,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 84,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            hintText: 'Prefix',
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 10.0,
                            ),
                            filled: true,
                            fillColor: const Color.fromARGB(31, 121, 120, 120),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (String? newValue) {},
                          isExpanded: false,
                          items: prefix
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Name',
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 25.0,
                            ),
                            filled: true,
                            fillColor: const Color.fromARGB(31, 121, 120, 120),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  IntlPhoneField(
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 25.0),
                      filled: true,
                      fillColor: const Color.fromARGB(31, 121, 120, 120),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none),
                    ),
                    initialCountryCode: 'IN',
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
                      suffixIcon: const Icon(Icons.calendar_month_outlined),
                      hintText: 'Date of Birth',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 25.0),
                      filled: true,
                      fillColor: const Color.fromARGB(31, 121, 120, 120),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none),
                    ),
                    onTap: _selectDate,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Select Gender'),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Radio<String>(
                            value: 'Male',
                            groupValue: selectedGender,
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value!;
                              });
                            },
                          ),
                          const Text('Male'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'Female',
                            groupValue: selectedGender,
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value!;
                              });
                            },
                          ),
                          const Text('Female'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'Other',
                            groupValue: selectedGender,
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value!;
                              });
                            },
                          ),
                          const Text('Other'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Address Line',
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 25.0,
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(31, 121, 120, 120),
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
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegistrationChild()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.fromLTRB(138.0, 15, 138.0, 15),
                      ),
                      child: const Text(
                        'Register',
                        style: TextStyle(fontSize: 20, color: AppColors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
