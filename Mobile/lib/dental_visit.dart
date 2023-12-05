import 'package:flutter/material.dart';
import 'package:nu_parent/Components/bulleted_list.dart';
import 'package:nu_parent/main.dart';

class DentalVisit extends StatefulWidget {
  const DentalVisit({super.key});

  @override
  State<DentalVisit> createState() => _DentalVisitState();
}

class _DentalVisitState extends State<DentalVisit> {
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
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset('assets/Doctors.png', width: 200, alignment: Alignment.center,)),
              Center(child: Text("Dental Visits", style: TextStyle(color: AppColors.darkblue, fontSize: 22, fontWeight: FontWeight.bold),)),
              const BulletList(
                  text:
                      "Take your baby to the dentist before his or her first birthday to prevent dental problems throughout their lifetime. Regularly scheduled oral health assessments with counselling during the first year of your child’s life. Please visit the dental Check by 1 campaign website: https://dentalcheckbyone.co.uk/"),
              const BulletList(
                  text:
                      "Talk to your dentist or doctor about putting fluoride varnish on your child’s teeth as soon as the first tooth appears."),
                      const SizedBox(height: 30,),
              const Text("What does a fluoride varnish do?", style: TextStyle(color: AppColors.darkblue),),
              const Text(
                  "Fluoride in varnish enters the tooth enamel and makes the tooth hard. It prevents new cavities and slows down or stops decay from getting worse. If tooth decay is just starting, it repairs the tooth.", style: TextStyle(color: AppColors.darkblue),),
                      const SizedBox(height: 30,),
              const BulletList(
                  text:
                      "If your child's teeth have spots or cavities, professional fluoride varnish applications are recommended at least twice a year. If your child has three or more lesions in their teeth, they are at high risk for cavities."),
              const BulletList(
                  text:
                      "Ask your child's dentist about applying protective coatings on their teeth called dental sealants when needed to prevent tooth decay."),
                      const SizedBox(height: 30,),
              const Text(
                  "Visit British Society of Pediatric Dentistry: https://www.bspd.co.uk/Kidsvids for videos on how to take care of kids teeth age wise.", style: TextStyle(color: AppColors.darkblue),)
            ],
          ),
        ),
      ),
    );
  }
}
