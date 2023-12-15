import 'package:flutter/material.dart';
import 'package:nu_parent/Components/appbar.dart';
import 'package:nu_parent/main.dart';

class PregnantMothersParents extends StatefulWidget {
  const PregnantMothersParents({super.key});

  @override
  State<PregnantMothersParents> createState() => _PregnantMothersParentsState();
}

class _PregnantMothersParentsState extends State<PregnantMothersParents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 245, 251, 255),
                Color.fromARGB(255, 175, 203, 244),
                Color.fromARGB(255, 245, 251, 255),
              ],
              stops: [0.1, 0.2, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.clamp,
            ),
            color: AppColors.white,
            image: DecorationImage(
              image: AssetImage('assets/Vector-1.png'),
              fit: BoxFit.scaleDown,
              alignment: Alignment.bottomCenter,
            )),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: ListView(
            children: [
              const CustomAppBar(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    children: [
                      Text(
                        'Pregnant mothers',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: AppColors.primaryColor),
                      ),
                      Text(
                        '&',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: AppColors.primaryColor),
                      ),
                      Text(
                        'Parents / Caregivers oral hygiene',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: AppColors.primaryColor),
                      )
                    ],
                  ),
                  Expanded(
                      child: Image.asset(
                    'assets/PregMother.png',
                    fit: BoxFit.fitWidth,
                  ))
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Good Dental Health Is Important When Pregnant',
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'When you’re pregnant, you may be more prone to gum disease and cavities, which can affect your baby’s health. Follow these 3 steps to protect your teeth:',
                      style: TextStyle(
                          color: Color.fromARGB(255, 183, 28, 28),
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.lightblue,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2.0,
                        blurRadius: 4.0,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'See a dentist or dental hygienist (it’s safe!) for your routine dental appointments. Don’t delay seeing your dentist if you have any worries about your teeth and gums.',
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.volume_up_rounded,
                              size: 34,
                            ),
                          )
                        ],
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.lightblue,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2.0,
                        blurRadius: 4.0,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Floss Daily.',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.volume_up_rounded,
                            size: 34,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.lightblue,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2.0,
                        blurRadius: 4.0,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Brush your teeth twice a day with fluoride-containing toothpaste and maintain a healthy diet.",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.volume_up_rounded,
                            size: 34,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.lightblue,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2.0,
                        blurRadius: 4.0,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Avoid sweetened beverages and foods.",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.volume_up_rounded,
                            size: 34,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: ClipOval(
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/FatherSon.jpeg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(' Parents oral hygiene is an important factor to protect your child’s teeth', style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w600, fontSize: 14),),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Primary caregivers are the main source of passing the bacteria that cause tooth decay to their newborns. These bacteria can spread to infants through contact with the caregiver’s saliva, such as sharing utensils or kissing on the lips, or cleaning pacifiers with the mouth.', style: TextStyle(color: Color.fromARGB(255, 183, 28, 28), fontWeight: FontWeight.w600, fontSize: 14),),
                          SizedBox(
                            height: 10,
                          ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.lightblue,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2.0,
                        blurRadius: 4.0,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Although baby teeth eventually fall out, they are very important for your child's oral health and development and well-being. Baby teeth are crucial because they reserve space for adult teeth and naturally fall out when the permanent ones are ready to come in. Hence early removal of baby teeth can cause the permanent teeth to erupt out of line. They help in speech development and assist in providing good nutrition to the child through proper chewing. So, set a good example and care for your child’s teeth.",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.volume_up_rounded,
                            size: 34,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
