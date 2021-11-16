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
                  Icon(Icons.assignment),
                  SizedBox(width: 5,),
                  Text(id, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                  Spacer(),
                  Text(room, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                ],
              )
            ],
          ),
        ),
    );
  }
}
