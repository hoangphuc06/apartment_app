import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/category_apartment/model/category_apartment_model.dart';
import 'package:apartment_app/src/pages/dweller/model/dweller_model.dart';
import 'package:flutter/material.dart';

class SearchDwellerCard extends StatelessWidget {
  final Dweller dweller;
  final funtion;
  const SearchDwellerCard({Key? key,
    required this.dweller,
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
                Icon(Icons.person),
                SizedBox(width: 5,),
                Text(this.dweller.name.toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                Spacer(),
                Text(
                  this.dweller.idApartment.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
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
