import 'package:animated_float_action_button/animated_floating_action_button.dart';
import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/category_apartment/model/category_apartment_model.dart';
import 'package:apartment_app/src/pages/category_apartment/view/edit_category_apartment_page.dart';
import 'package:apartment_app/src/widgets/appbars/my_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategotyApartmentDetailPage extends StatefulWidget {
  late CategoryApartment categoryApartment;
  CategotyApartmentDetailPage({Key? key,
  required this.categoryApartment}) : super(key: key);

  @override
  _CategotyApartmentDetailPageState createState() => _CategotyApartmentDetailPageState();
}

class _CategotyApartmentDetailPageState extends State<CategotyApartmentDetailPage> {

  final GlobalKey<AnimatedFloatingActionButtonState> fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar("Thông tin"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title("Thông tin chi tiết"),
            SizedBox(height: 10,),
            _detail("Tên loại căn hộ", widget.categoryApartment.name.toString()),
            SizedBox(height: 10,),
            _detail("Diện tích", widget.categoryApartment.area.toString()),
            SizedBox(height: 10,),
            _detail("Số phòng ngủ", widget.categoryApartment.amountBedroom.toString()),
            SizedBox(height: 10,),
            _detail("Số phòng vệ sinh", widget.categoryApartment.amountWc.toString()),
            SizedBox(height: 10,),
            _detail("Số người tối đa", widget.categoryApartment.amountDweller.toString()),
            SizedBox(height: 30,),
            _title("Giá cả"),
            SizedBox(height: 10,),
            _detail("Giá bán", widget.categoryApartment.rentalPrice.toString() + "  VND"),
            SizedBox(height: 10,),
            _detail("Giá thuê", widget.categoryApartment.price.toString() + "  VND"),
            SizedBox(height: 30,),
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
        _gotoPage();
      },
      icon: Icons.mode_edit,
      text: "Sửa",
      textLeft: -80,
    );
  }

  void _gotoPage() async {
    final CategoryApartment c = await Navigator.push(context, MaterialPageRoute(builder: (context) => EditCategoryApartmentPage(this.widget.categoryApartment)));
    if (c!=null) {
      setState(() {
        this.widget.categoryApartment = c;
      });
    }
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
  _title(String text) => Text(
    text,
    style: TextStyle(
        color: Colors.black.withOpacity(0.5),
        fontWeight: FontWeight.bold
    ),
  );

  _detail(String name, String detail) => Container(
    padding: EdgeInsets.all(8),
    height: 50,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.grey.withOpacity(0.1)
    ),
    child: Row(
      children: [
        Text(
          name,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
        ),
        Spacer(),
        Text(
          detail,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500
          ),
        ),
      ],
    ),
  );

  _note(String text) => Container(
    width: double.infinity,
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.grey.withOpacity(0.1),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ghi chú",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10,),
        Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            height: 1.2,
          ),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 10,),
      ],
    ),
  );
}
