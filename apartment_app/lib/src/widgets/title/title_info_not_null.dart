import 'package:flutter/material.dart';

class TitleInfoNotNull extends StatelessWidget {
  const TitleInfoNotNull({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(text, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
      Text(" *", style: TextStyle(color: Colors.red, fontSize: 16),),
    ],);
  }
}

