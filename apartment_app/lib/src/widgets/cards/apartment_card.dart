import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/category_apartment/model/category_apartment_model.dart';
import 'package:apartment_app/src/pages/tab_pages/apartment_search/model/apartment_model.dart';
import 'package:flutter/material.dart';

class ApartmentCard extends StatelessWidget {
  final ApartmentModel apartment;
  final funtion;
  const ApartmentCard({Key? key,
    required this.apartment,
    required this.funtion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: funtion,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Căn hộ " + this.apartment.id.toString(), style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Row(
              children: [
                Icon(Icons.person),
                SizedBox(width: 5,),
                Text("Số người đang ở:", style: TextStyle(fontSize: 15),),
                Spacer(),
                Text(this.apartment.numOfDweller.toString(), style: TextStyle(fontSize: 15),),
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
                  this.apartment.status.toString(),
                  style: TextStyle(
                      fontSize: 15,
                      color: this.apartment.status == "Trống"? myRed : this.apartment.status == "Đã bán"? myGreen : myYellow,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Icon(Icons.home),
                SizedBox(width: 5,),
                Text("Tầng:", style: TextStyle(fontSize: 15),),
                Spacer(),
                Text(this.apartment.floorid.toString(), style: TextStyle(fontSize: 15),),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
