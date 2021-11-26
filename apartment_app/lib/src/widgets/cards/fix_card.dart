import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/fix/model/fix_model.dart';
import 'package:flutter/material.dart';

class FixCard extends StatelessWidget {
  final Fix fix;
  final funtion;
  const FixCard({Key? key,
    required this.fix,
    required this.funtion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: funtion,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blueGrey.withOpacity(0.2),
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.build),
                SizedBox(width: 5,),
                Text(this.fix.idRoom.toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                Spacer(),
                Text(
                  fix.status.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: fix.status.toString()=="Đang chờ"? myRed : fix.status.toString()=="Đã tiếp nhận" ? myYellow : myGreen,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}