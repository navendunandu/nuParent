import 'package:flutter/material.dart';
import 'package:nu_parent/Components/wavebg.dart';
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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_new), //Back Icon
        ),
      ),
      body: Stack(
        children: [ 
          const Positioned(
          bottom: 0,
          child: WaveBackground(color: Color.fromARGB(255, 125, 166, 199)),
        ),
          SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'View Profile',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      // style: const ButtonStyle(backgroundColor: AppColors.white),
                      child: const Text('Edit'),
                    )
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.person_add_alt_1_outlined),
                        label: const Text('Add another profile'))
                  ],
                )
              ],
            ),
          ),
        ),
        ]
      ),
    );
  }
}
