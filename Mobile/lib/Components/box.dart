import 'package:flutter/material.dart';
import 'package:nu_parent/main.dart';

class BoxList extends StatelessWidget {
  final List<Map<String, dynamic>> dentalVList;

  const BoxList({
    Key? key,
    required this.dentalVList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: dentalVList.map((map) {
        final text = map['text'] as String;
        return Box(text: text);
      }).toList(),
    );
  }
}

class Box extends StatelessWidget {
  final String text;

  const Box({
    Key? key,
    required this.text,
  }) : super(key: key);

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
              const Padding(
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
    );
  }
}
