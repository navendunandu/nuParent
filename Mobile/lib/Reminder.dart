import 'package:flutter/material.dart';
import 'package:nu_parent/main.dart';

class Reminder extends StatefulWidget {
  const Reminder({super.key});

  @override
  State<Reminder> createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new), //Back Icon
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text('Reminder', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.darkblue),),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 180,
                width: 350,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color.fromARGB(255, 134, 155, 173)
                ),
                child: const Center(child: Text('Daily, toothbrush replacement & dentist visit Reminders', textAlign: TextAlign.center, style: TextStyle(fontSize: 16),)),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 180,
                width: 350,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color.fromARGB(255, 191, 216, 238)
                ),
                child: const Center(child: Text('Floss, Brush & Rinse Timers', textAlign: TextAlign.center, style: TextStyle(fontSize: 16),)),
              )
            ],
          ),
        ),
      ),
    );
  }
}