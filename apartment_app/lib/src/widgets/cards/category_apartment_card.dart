import 'package:apartment_app/src/pages/category_apartment/model/category_apartment_model.dart';
import 'package:flutter/material.dart';

class CategoryApartmentCard extends StatelessWidget {
  final CategoryApartment categoryApartment;
  final funtion;
  const CategoryApartmentCard({Key? key,
    required this.categoryApartment,
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
              Text(categoryApartment.name.toString(), style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Row(
                children: [
                  Icon(Icons.crop_square_rounded),
                  SizedBox(width: 5,),
                  Text("Diện tích", style: TextStyle(fontSize: 15),),
                  Spacer(),
                  Text(categoryApartment.area.toString() + " m2", style: TextStyle(fontSize: 15),),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Icon(Icons.bed),
                  SizedBox(width: 5,),
                  Text("Số phòng ngủ:", style: TextStyle(fontSize: 15),),
                  Spacer(),
                  Text(categoryApartment.amountBedroom.toString(), style: TextStyle(fontSize: 15),),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Icon(Icons.wc),
                  SizedBox(width: 5,),
                  Text("Số phòng vệ sinh:", style: TextStyle(fontSize: 15),),
                  Spacer(),
                  Text(categoryApartment.amountWc.toString(), style: TextStyle(fontSize: 15),),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 5,),
                  Text("Số người ở:", style: TextStyle(fontSize: 15),),
                  Spacer(),
                  Text(categoryApartment.amountDweller.toString(), style: TextStyle(fontSize: 15),),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
