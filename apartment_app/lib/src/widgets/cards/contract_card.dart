import 'package:flutter/material.dart';

class ContractCard extends StatelessWidget {
  final String id;
  final String room;
  final String startDay;
  final String expirationDate;
  final String host;
  final funtion;
  const ContractCard({
    Key? key,
    required this.id,
    required this.room,
    required this.startDay,
    required this.expirationDate,
    required this.host,
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
              Text(id, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Row(
                children: [
                  Icon(Icons.home),
                  SizedBox(width: 5,),
                  Text(room, style: TextStyle(fontSize: 15),),
                  Spacer(),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Icon(Icons.calendar_today_outlined),
                  SizedBox(width: 5,),
                  Text("Từ ngày "+startDay.toString()+" đến "+expirationDate.toString(), style: TextStyle(fontSize: 15),),
                  Spacer(),
                  
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Icon(Icons.people_alt_outlined),
                  SizedBox(width: 5,),
                  Text("Người cho thuê "+host, style: TextStyle(fontSize: 15),),
                  Spacer(),
                  
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
