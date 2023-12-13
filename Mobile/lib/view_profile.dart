import 'package:flutter/material.dart';
import 'package:nu_parent/Components/appbar.dart';
import 'package:nu_parent/main.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({super.key});

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/Vector-1.png'),
                 fit: BoxFit.scaleDown, alignment: Alignment.bottomCenter,
               )),
        child: Column(
          children: [
            const CustomAppBar(),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'View Profile',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, // Set background color
                          foregroundColor:
                              AppColors.primaryColor, // Set text color
                          side: const BorderSide(
                              color:
                                  AppColors.primaryColor), // Add black border
                        ),
                        onPressed: () {},
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
                        onPressed: () {},
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
              decoration: const BoxDecoration(color: Color.fromARGB(255, 220, 231, 253)),
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: Row(
                  children: [
                    Stack(children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 216, 225, 233),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Stack(children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            child: Image.asset(
                              'assets/dummy-profile-pic.png',
                              height: 90,
                            ),
                          ),
                        ]),
                      ),
                      Positioned(
                        left: 63,
                        top: 63,
                        child: IconButton(
                            iconSize: 20,
                            padding: const EdgeInsets.all(5),
                            onPressed: () {},
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(106, 58, 58, 58)),
                              minimumSize: MaterialStatePropertyAll(Size(8, 8)),
                            ),
                            color: const Color.fromARGB(255, 185, 185, 185),
                            icon: const Icon(
                              Icons.camera_alt_rounded,
                              color: AppColors.black,
                            )),
                      )
                    ]),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Ciaa Anumod',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black),
                    ),
                    // DropdownButton(items: const [], onChanged: (Object? value) { print('hi'); },),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: AppColors.black,
                        ))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Child Details',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Column(
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
                        SizedBox(
                          width: 50,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '6 Years',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '23/06/2016',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Female',
                              style: TextStyle(
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
      ),
    );
  }
}
