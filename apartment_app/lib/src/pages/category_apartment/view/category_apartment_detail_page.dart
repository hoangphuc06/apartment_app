import 'package:animated_float_action_button/animated_floating_action_button.dart';
import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/category_apartment/firebase/fb_category_apartment.dart';
import 'package:apartment_app/src/pages/category_apartment/model/category_apartment_model.dart';
import 'package:apartment_app/src/pages/category_apartment/view/edit_category_apartment_page.dart';
import 'package:apartment_app/src/widgets/appbars/my_app_bar.dart';
import 'package:apartment_app/src/widgets/dialog/msg_dilog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  CategoryApartmentFB categoryApartmentFB = new CategoryApartmentFB();
  bool _isAdd = false;
  bool _canDelete = false;

  @override
  Widget build(BuildContext context) {
    CheckforDelete();
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
      onPressed: _isAdd == false ? () => _AddConfirm(context) : null,
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
        color: Colors.blueGrey.withOpacity(0.2)
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
  void _AddConfirm(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('XÁC NHẬN'),
            content: Text('Bạn có chắc muốn xóa loại căn hộ này này?'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    // Remove the box
                    setState(() {
                      _isAdd = false;
                    });
                    fabKey.currentState!.animate();
                    if(_canDelete == true)
                    {
                      fabKey.currentState!.animate();
                      this.categoryApartmentFB.delete(widget.categoryApartment.id.toString());
                      Navigator.pop(context);
                      Navigator.of(context).pop();
                    }
                    else {
                      // Close the dialog
                      Navigator.of(context).pop();
                      MsgDialog.showMsgDialog(
                          context, "Không thể xóa loại phòng đang được sử dụng",
                          "");
                    }
                  },
                  child: Text('Có')),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: Text('Không'))
            ],
          );
        });
  }

  Future<void> CheckforDelete() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("floorinfo").where('categoryid',isEqualTo: widget.categoryApartment.id.toString()).get();
    //var con = contractFB.collectionReference.where('room',isEqualTo: this.widget.id_apartment).get();
    print(querySnapshot.docs.length);
    if(querySnapshot.docs.length == 0) {
      print("oke");
      _canDelete = true;
    }
    else {
      print("not oke");
      _canDelete = false;
    }
  }
}
