import 'package:apartment_app/src/colors/colors.dart';
import 'package:flutter/material.dart';

class FloorInfoCard extends StatelessWidget {
  final String id;
  final String numOfDweller;
  final String status;
  final funtion;
  const FloorInfoCard({
    Key? key,
    required this.id,
    required this.numOfDweller,
    required this.status,
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
              Text("Căn hộ " + id, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 5,),
                  Text("Số người đang ở:", style: TextStyle(fontSize: 15),),
                  Spacer(),
                  Text(numOfDweller, style: TextStyle(fontSize: 15),),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Icon(Icons.wysiwyg_rounded),
                  SizedBox(width: 5,),
                  Text("Trạng thái:", style: TextStyle(fontSize: 15),),
                  Spacer(),
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 15,
                      color: status == "Trống"? myRed : status == "Đã bán"? myGreen : myYellow,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
