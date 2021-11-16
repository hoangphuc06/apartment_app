import 'package:apartment_app/src/colors/colors.dart';
import 'package:flutter/material.dart';

class FloorCard extends StatelessWidget {
  final String name;
  final String numOfApm;
  final funtion;
  const FloorCard({
    Key? key,
    required this.name,
    required this.numOfApm,
    required this.funtion
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: funtion,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        width: 150,
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.all(16),
        //alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.apartment_sharp, size: 40,),
            SizedBox(height: 5,),
            Text("Tầng " + name, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black),)
          ],
        ),
      ),
    );
  }
}
