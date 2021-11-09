import 'package:apartment_app/src/pages/tab_pages/dweller_search/model/dweller_info.dart';
import 'package:flutter/material.dart';

class DwellerCard extends StatelessWidget {
  final DwellerModel dweller;
  final funtion;

  const DwellerCard({Key? key, required this.dweller, required this.funtion})
      : super(key: key);

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
              Text(
                "Tên : " + this.dweller.name.toString(),
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Số CMND",
                    style: TextStyle(fontSize: 15),
                  ),
                  Spacer(),
                  Text(
                    this.dweller.cmnd.toString(),
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(Icons.phone),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Số điện thoại:",
                    style: TextStyle(fontSize: 15),
                  ),
                  Spacer(),
                  Text(
                    this.dweller.phone.toString(),
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(Icons.home),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Căn hộ:",
                    style: TextStyle(fontSize: 15),
                  ),
                  Spacer(),
                  Text(
                    this.dweller.idApartment.toString(),
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
