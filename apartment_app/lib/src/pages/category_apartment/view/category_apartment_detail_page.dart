import 'package:animated_float_action_button/animated_floating_action_button.dart';
import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/category_apartment/model/category_apartment_model.dart';
import 'package:apartment_app/src/pages/category_apartment/view/edit_category_apartment_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategotyApartmentDetailPage extends StatefulWidget {
  final CategoryApartment categoryApartment;
  const CategotyApartmentDetailPage({Key? key,
  required this.categoryApartment}) : super(key: key);

  @override
  _CategotyApartmentDetailPageState createState() => _CategotyApartmentDetailPageState();
}

class _CategotyApartmentDetailPageState extends State<CategotyApartmentDetailPage> {

  final GlobalKey<AnimatedFloatingActionButtonState> fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: myGreen,
        elevation: 0,
        centerTitle: true,
        title:  Text(
          widget.categoryApartment.name.toString(),
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
                    Text("Thông tin chi tiết", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.crop_square_rounded, "Diện tích", widget.categoryApartment.area.toString() + " m2"),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.bed, "Số phòng ngủ", widget.categoryApartment.amountBedroom.toString()),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.wc, "Số phòng vệ sinh", widget.categoryApartment.amountWc.toString()),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.person, "Số người ở", widget.categoryApartment.amountDweller.toString()),
                    SizedBox(height: 10,),
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
                    SizedBox(height: 10,),
                    Text("Giá cả giao động", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    _priceInfo(
                        Icons.money,
                        "Giá thuê",
                        widget.categoryApartment.minRentalPrice.toString(),
                        widget.categoryApartment.maxRentalPrice.toString()
                    ),
                    SizedBox(height: 20,),
                    _priceInfo(
                        Icons.money,
                        "Giá bán",
                        widget.categoryApartment.minPrice.toString(),
                        widget.categoryApartment.maxPrice.toString()
                    ),
                    SizedBox(height: 10,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AnimatedFloatingActionButton(
          key: fabKey,
          fabButtons: <Widget>[
            edit(),
            delete(),
          ],
          colorStartAnimation: myGreen,
          colorEndAnimation: myGreen,
          animatedIconData: AnimatedIcons.menu_close //To principal button
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

  _priceInfo(IconData icons, String title, String minValue, String maxValue) => Column(
    children: [
      Row(
        children: [
          Icon(icons),
          SizedBox(width: 5,),
          Text(title, style: TextStyle(fontSize: 15),),
          Spacer(),
          Text(minValue + " - " + maxValue + " VNĐ", style: TextStyle(fontSize: 15),),
        ],
      ),

    ],
  );

  Widget edit() {
    return FloatActionButtonText(
      onPressed: (){
        fabKey.currentState!.animate();
        Navigator.push(context, MaterialPageRoute(builder: (context) => EditCategoryApartmentPage(this.widget.categoryApartment)));
      },
      icon: Icons.mode_edit,
      text: "Sửa",
      textLeft: -80,
    );
  }

  Widget delete() {
    return FloatActionButtonText(
      onPressed: (){
        fabKey.currentState!.animate();
      },
      icon: Icons.delete,
      textLeft: -80,
      text: "Xóa",
    );
  }
}
