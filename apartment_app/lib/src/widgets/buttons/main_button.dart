import 'package:apartment_app/src/colors/colors.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    Key? key,
    required this.name,
    required this.onpressed,
  }) : super(key: key);

  final String name;
  final onpressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
          color: myGreen,
          borderRadius: BorderRadius.circular(10.0)
      ),
      child: FlatButton(
        onPressed: onpressed,
        child: Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w400
          ),
        ),
      ),
    );
  }
}
