import 'package:flutter/material.dart';

Widget backButton(BuildContext context) {
  return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.black,
        size: 25.0,
      ),
    onPressed: () {
        Navigator.pop(context);
    },
  );
}