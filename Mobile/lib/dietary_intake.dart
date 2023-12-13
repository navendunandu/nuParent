import 'package:flutter/material.dart';
import 'package:nu_parent/expecting_mothers.dart';
import 'package:nu_parent/main.dart';

class DietaryIntake extends StatefulWidget {
  const DietaryIntake({super.key});

  @override
  State<DietaryIntake> createState() => _DietaryIntakeState();
}

class _DietaryIntakeState extends State<DietaryIntake> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.more_vert_rounded)),
        ],
        title: const Center(
          child: Text(
            "Your Child’s Dietary Intake",
            style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 20),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.white,
            image: DecorationImage(
          image: AssetImage('assets/Vector-1.png'),
          fit: BoxFit.scaleDown,
          alignment: Alignment.bottomCenter,
        )),
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Column(
            children: [
              Image.asset(
                    'assets/Eating.png',
                  ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ExpectingMothers()));
                },
                child: Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
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
                      'Expecting Mothers',
                      style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
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
                    'From Birth to the First Year of Age',
                    style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
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
                    'First and Second Year of Age',
                    style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
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
                    'From Two to Six Years of Age',
                    style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
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
