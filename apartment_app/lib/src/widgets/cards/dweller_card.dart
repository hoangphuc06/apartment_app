import 'package:apartment_app/src/pages/category_apartment/model/category_apartment_model.dart';
import 'package:apartment_app/src/pages/dweller/model/dweller_model.dart';
import 'package:flutter/material.dart';

class DwellerCard extends StatelessWidget {
  final Dweller dweller;
  final funtion;
  const DwellerCard({Key? key,
    required this.dweller,
    required this.funtion}) : super(key: key);

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
              Text(dweller.name.toString(), style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Row(
                children: [
                  Icon(Icons.wc),
                  SizedBox(width: 5,),
                  Text("Giới tính", style: TextStyle(fontSize: 15),),
                  Spacer(),
                  Text(
                    dweller.gender.toString()=="0"? "Nam" : "Nữ",
            
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
              SizedBox(height: 10,),
              Row(
                children: [
                  Icon(Icons.phone),
                  SizedBox(width: 5,),
                  Text("Số điện thoại", style: TextStyle(fontSize: 15),),
                  Spacer(),
                  Text(
                    dweller.phoneNumber.toString()==""? "Trống" : dweller.phoneNumber.toString(),
                    style: TextStyle(fontSize: 15),),
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
    )
      )
    );
  }
}
