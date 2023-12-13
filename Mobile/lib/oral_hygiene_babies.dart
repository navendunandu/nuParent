import 'package:flutter/material.dart';
import 'package:nu_parent/main.dart';

class OralHygieneBabies extends StatefulWidget {
  const OralHygieneBabies({super.key});

  @override
  State<OralHygieneBabies> createState() => _OralHygieneBabiesState();
}

class _OralHygieneBabiesState extends State<OralHygieneBabies> {
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
        title: const Center(
            child: Text(
          'Oral hygiene of babies (0-3 years)',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppColors.darkblue,
              fontWeight: FontWeight.w500,
              fontSize: 18),
        )),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.more_vert_rounded)),
        ],
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/Vector2.png'),
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter)),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.lightblue,
                    boxShadow: [
                      // Add shadow for elevation
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
                              'Wipe your infant’s gums or teeth, especially along the gum line, with a soft cloth after breast or bottle feeding.',
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
                      // Add shadow for elevation
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
                            'Avoid giving your baby a bottle or Sippy cup with anything other than water when putting them to bed.',
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
              // const BulletList(
              //     text:
              //         'Wipe your infant’s gums or teeth, especially along the gum line, with a soft cloth after breast or bottle feeding.'),
              // const BulletList(
              //     text:
              //         'Avoid giving your baby a bottle or Sippy cup with anything other than water when putting them to bed.'),
              // const BulletList(
              //     text:
              //         "When a baby's teeth start coming in, it's important to brush them twice a day with a soft, small toothbrush and plain water to protect them. Last thing at night (or before bedtime) and on one other occasion using only a smear of toothpaste."),
              // const BulletList(
              //     text:
              //         "Avoid behaviours that involve sharing saliva, such as sharing a spoon to taste baby food, cleaning a dropped pacifier by mouth, or wiping the baby's mouth with a cloth that has saliva on it. Avoid kissing the baby on the mouth if you have tooth or gum disease."),
              // const BulletList(
              //     text:
              //         "Make sure to take your baby to the dentist when the first teeth erupt or around age one to identify any dental problems early. Please visit the dental Check by 1 campaign website: https://dentalcheckbyone.co.uk/"),
              // const BulletList(
              //     text:
              //         "Start reducing the frequency of bottle and Sippy cup usage as a way to calm a child's behaviour when they are around 12 months old."),
              // const BulletList(
              //     text:
              //         "Brush your child's teeth with a small amount of fluoridated toothpaste, about the size of a green pea, especially before going to bed."),
              // const BulletList(
              //     text:
              //         "Check your child's teeth regularly by lifting their lip to see if there are any white or brown spots on them."),
              // Image.asset(
              //   'assets/WhiteSpots.png',
              //   height: 200,
              // ),
              // const BulletList(
              //     text:
              //         "When selecting over-the-counter medications for children, you can read the product labels or consult a pharmacist to identify options that are sugar-free or have reduced sugar content. Some liquid medications may contain sugar or sweeteners to improve the taste. In such cases, the doctor or pharmacist can help you find alternatives without added sugars."),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     const Expanded(
              //         child: BulletList(
              //             text:
              //                 "When selecting over-the-counter medications for children, you can read the product labels or consult a pharmacist to identify options that are sugar-free or have reduced sugar content. Some liquid medications may contain sugar or sweeteners to improve the taste. In such cases, the doctor or pharmacist can help you find alternatives without added sugars.")),
              //     Image.asset(
              //       'assets/MotherBaby.png',
              //       width: 130,
              //     )
              //   ],
              // ),
              // const SizedBox(
              //   height: 150,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
