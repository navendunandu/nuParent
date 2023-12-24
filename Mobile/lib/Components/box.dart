import 'package:flutter/material.dart';
import 'package:nu_parent/main.dart';
import 'package:flutter_tts/flutter_tts.dart';

class BoxList extends StatefulWidget {
  final List<Map<String, dynamic>> dentalVList;

  const BoxList({
    Key? key,
    required this.dentalVList,
  }) : super(key: key);

  @override
  State<BoxList> createState() => _BoxListState();
}

class _BoxListState extends State<BoxList> {
  FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.dentalVList.map((map) {
        final text = map['text'] as String;
        return Box(flutterTts: flutterTts, text: text);
      }).toList(),
    );
  }
}

class Box extends StatelessWidget {
  final FlutterTts flutterTts;
  final String text;

  const Box({
    Key? key,
    required this.flutterTts,
    required this.text,
  }) : super(key: key);

  Future speak(String stext) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.speak(stext);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: Text(text),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    speak(text);
                  },
                  icon: Icon(Icons.volume_up_rounded),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
