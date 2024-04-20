import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:nu_parent/Components/appbar.dart';
import 'package:nu_parent/Components/bottom_bar.dart';
import 'package:nu_parent/Components/box.dart';
import 'package:nu_parent/main.dart';

class Brushing extends StatefulWidget {
  const Brushing({Key? key, required this.documentId, required this.brushing, required this.image})
      : super(key: key);

  final String documentId;
  final String brushing;
  final String image;

  @override
  State<Brushing> createState() => _BrushingState();
}

class _BrushingState extends State<Brushing> {
  FlutterTts flutterTts = FlutterTts();

  bool check = false;

  Future speak(String stext) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.speak(stext);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(),
      body: Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          image: DecorationImage(
            image: AssetImage('assets/Vector-1.png'),
            fit: BoxFit.cover,
            alignment: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          children: [
            const CustomAppBar(),
            Center(
              child: Text(
                widget.brushing,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Image.network(widget.image),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder(
              future: fetchData(),
              builder:
                  (context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: const CircularProgressIndicator(),
                        )),
                  );
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: const Text('No data found', 
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var doc = snapshot.data![index];
                      var brushingTitle = doc['brushingTitle'];
                      var brushContent = List<String>.from(doc[
                          'brushContent']); // Convert dynamic to List<String>

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              '$brushingTitle',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: brushContent.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Box(
                                  text: brushContent[index],
                                  flutterTts: flutterTts,
                                  colour: AppColors.primaryColor,
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 149, 149, 149)
                          .withOpacity(0.5),
                      spreadRadius: 1.0,
                      blurRadius: 8.0,
                      offset: const Offset(2, 2),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  Future<List<DocumentSnapshot>> fetchData() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('brushingDetails')
        .where('brushGroup', isEqualTo: widget.documentId)
        .orderBy('brushingOrder', descending: false)
        .get();
    return snapshot.docs;
  }
}
