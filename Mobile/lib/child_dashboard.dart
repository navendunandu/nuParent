import 'package:flutter/material.dart';
import 'package:nu_parent/brushing_instruction.dart';
import 'package:nu_parent/dietary_intake.dart';
import 'package:nu_parent/main.dart';
import 'package:nu_parent/oral_hygiene.dart';
import 'package:nu_parent/settings.dart';

class ChildDashboard extends StatefulWidget {
  const ChildDashboard({super.key});

  @override
  State<ChildDashboard> createState() => _ChildProfileState();
}

class _ChildProfileState extends State<ChildDashboard> {
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
                color: AppColors.darkblue,
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
                    color: Color.fromARGB(255, 200, 230, 255),
                  ),
                ),
              ),
              Positioned(
                left: 250, top: 5,
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
                    color: Color.fromARGB(255, 0, 60, 110),
                  ),
                ),
              ),
              Positioned(
                left: 345, top: 5,
                child: Container(
                  width:40,
                  height:40,
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
                    color: Color.fromARGB(196, 136, 202, 255),
                  ),
                ),
              ),
              Positioned(
                left: 300, top: 110,
                child: Container(
                  width:12,
                  height:12,
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
                    color: Color.fromARGB(255, 0, 122, 223),
                  ),
                ),
              ),
              Positioned(
                left: 320, top: 150,
                child: Container(
                  width:50,
                  height:50,
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
                    color: Color.fromARGB(255, 0, 122, 223),
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
                            const Text(
                              'Ciaa Anumod',
                              style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.white),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: AppColors.white,
                                ))
                          ],
                        ),
                        const Text(
                          'Girl, 6 years',
                          style: TextStyle(
                              fontSize: 20,
                              color: AppColors.white,
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
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const OralHygiene()));
                },
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      color: AppColors.lightblue,
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
                      child: Text(
                    'Oral hygiene',
                    style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  )),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const DietaryIntake()));
                },
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      color: AppColors.lightblue,
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
                      child: Text(
                    'Dietary intake',
                    style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
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
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const BrushingInstruction()));
                },
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      color: AppColors.lightblue,
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
                      child: Text(
                    'Brushing instructions',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  )),
                ),
              ),
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    color: AppColors.lightblue,
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
                    child: Text(
                  'Dental visits',
                  style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
