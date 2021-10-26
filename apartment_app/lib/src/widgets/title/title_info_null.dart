import 'package:flutter/material.dart';

class TitleInfoNull extends StatelessWidget {
  const TitleInfoNull({
    Key? key,
    required this.text
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(text, style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),),
    ],);
  }
}
