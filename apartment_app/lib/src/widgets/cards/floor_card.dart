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
      child: Card(
        elevation: 2,
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Tầng " + name, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Row(
                children: [
                  Icon(Icons.home),
                  SizedBox(width: 5,),
                  Text("Số căn hộ:", style: TextStyle(fontSize: 15),),
                  Spacer(),
                  Text(numOfApm, style: TextStyle(fontSize: 15),),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Icon(Icons.wysiwyg),
                  SizedBox(width: 5,),
                  Text("Đang sử dụng:", style: TextStyle(fontSize: 15),),
                  Spacer(),
                  Text("0", style: TextStyle(fontSize: 15),),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
