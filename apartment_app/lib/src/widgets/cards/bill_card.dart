import 'package:flutter/material.dart';
import 'package:apartment_app/src/colors/colors.dart';

class BillCard extends StatelessWidget {
  final String MonthYear;
  final String billdate;
  final String status;
  final funtion;
  const BillCard({
    Key? key,
    required this.MonthYear,
    required this.billdate,
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
              Text("Hóa đơn tháng " + MonthYear, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Row(
                children: [
                  Icon(Icons.calendar_today),
                  SizedBox(width: 5,),
                  Text("Ngày lập hóa đơn:", style: TextStyle(fontSize: 15),),
                  Spacer(),
                  Text(billdate, style: TextStyle(fontSize: 15),),
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
                        color: status == "chưa thanht toán"? myGreen :  myRed ,
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