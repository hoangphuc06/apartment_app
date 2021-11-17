import 'package:apartment_app/src/colors/colors.dart';
import 'package:flutter/material.dart';

class FloorInfoCard extends StatelessWidget {
  final String id;
  final String status;
  final funtion;
  const FloorInfoCard({
    Key? key,
    required this.id,
    required this.status,
    required this.funtion
  }) : super(key: key);

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
                Icon(Icons.home),
                SizedBox(width: 5,),
                Text(this.id, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                Spacer(),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 15,
                    color: status == "Trống"? myGreen : status == "Đã bán"? myRed : Colors.orange,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
