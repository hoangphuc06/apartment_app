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
                  Icon(Icons.apartment),
                  SizedBox(width: 5,),
                  Text(this.categoryApartment.name.toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                  Spacer(),
                  Text(this.categoryApartment.area.toString()+" m²", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                ],
              )
            ],
          ),
      ),
    );
  }
}
