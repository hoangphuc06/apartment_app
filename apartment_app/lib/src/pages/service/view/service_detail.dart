import 'package:animated_float_action_button/animated_floating_action_button.dart';
import 'package:animated_float_action_button/float_action_button_text.dart';
import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/service/firebase/fb_service.dart';
import 'package:apartment_app/src/pages/service/model/service_model.dart';
import 'package:apartment_app/src/widgets/appbars/my_app_bar.dart';
import 'package:apartment_app/src/widgets/dialog/msg_dilog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'add_service_page.dart';

class ServiceDetailPage extends StatefulWidget {
  late ServiceModel service;
   ServiceDetailPage({Key? key,
    required this.service}) : super(key: key);
  @override
  _ServiceDetailPageState createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends State<ServiceDetailPage> {
  final GlobalKey<AnimatedFloatingActionButtonState> fabKey = GlobalKey();
  ServiceFB fb = new ServiceFB();
  bool _isAdd = false;
  bool _canDelete = false;
  @override
  Widget build(BuildContext context) {
    CheckforDelete();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar("Thông tin dịch vụ"),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Thông tin chi tiết
                _title("Thông tin chi tiết"),
                SizedBox(height: 10,),
                _detail("Tên dịch vụ", widget.service.name.toString()),
                // SizedBox(height: 10,),
                // _detail("Loại dịch vụ", widget.service.type.toString()),
                SizedBox(height: 10,),
                _detail("Phí dịch vụ", widget.service.charge.toString()),
                SizedBox(height: 30,),
                _title("Khác"),
                SizedBox(height: 10,),
                _note(widget.service.detail.toString()),
                SizedBox(height: 50,)
              ],
            ),
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
      onPressed: ()async{
        fabKey.currentState!.animate();

   dynamic Result=  await  Navigator.push(context, MaterialPageRoute(builder: (context) => AddServicPage(sv:this.widget.service)));
    if(Result.runtimeType==ServiceModel)
      {
        setState(() {
          this.widget.service=Result;
        });
      }
      },
      icon: Icons.mode_edit,
      text: "Sửa",
      textLeft: -80,
    );
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
      color: Colors.blueGrey.withOpacity(0.2),
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
            content: Text('Bạn có chắc muốn xóa dịch vụ này?'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    // Remove the box
                    setState(() {
                      _isAdd = false;
                    });
                    if(_canDelete == true)
                    {
                      fabKey.currentState!.animate();
                      this.fb.delete(widget.service.id.toString());
                      Navigator.pop(context);
                      Navigator.of(context).pop();
                    }
                    else{
                      Navigator.of(context).pop();
                      MsgDialog.showMsgDialog(context, "Không thể xóa dịch vụ đang được sử dụng", "");}
                    // Close the dialog
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
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("service_apartment").where('idService',isEqualTo: widget.service.id.toString()).get();
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
