import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/tab_pages/apartment_search/model/apartment_model.dart';
import 'package:flutter/material.dart';
class ApartmentDetail extends StatefulWidget {
  late  ApartmentModel apartemt;
  ApartmentDetail({Key? key,
    required this.apartemt}) : super(key: key);
  @override
  _ApartmentDetailState createState() => _ApartmentDetailState();
}

class _ApartmentDetailState extends State<ApartmentDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: myGreen,
        elevation: 0,
        centerTitle: true,
        title:  Text(
         'Thong tin Can ho',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Card(
              elevation: 2,
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Text("Căn hộ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.home , "Căn hộ:", widget.apartemt.id.toString()),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.category, "Loại căn hộ", widget.apartemt.category!.name.toString()),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.people_alt, "Sô người đang ở", widget.apartemt.numOfDweller.toString()+'/'+widget.apartemt.category!.amountDweller.toString()),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.wysiwyg, "Trang thái", widget.apartemt.status.toString()),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 2,
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Thông tin", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.bed, "Số phòng ngủ", widget.apartemt.category!.amountBedroom.toString()),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.wc, "Số phòng vệ sinh", widget.apartemt.category!.amountWc.toString()),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.crop_square_rounded, "Diện tích", widget.apartemt.category!.area.toString()+" m2"),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.home, "Tầng", widget.apartemt.floorid.toString()),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _detailInfo(IconData icons, String title, String value) => Row(
    children: [
      Icon(icons),
      SizedBox(width: 5,),
      Text(title, style: TextStyle(fontSize: 15),),
      Spacer(),
      Text(value, style: TextStyle(fontSize: 15),),
    ],
  );
}
