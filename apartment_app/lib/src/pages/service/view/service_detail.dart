import 'package:animated_float_action_button/animated_floating_action_button.dart';
import 'package:animated_float_action_button/float_action_button_text.dart';
import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/service/firebase/fb_service.dart';
import 'package:apartment_app/src/pages/service/model/service_model.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: myGreen,
        elevation: 0,
        centerTitle: true,
        title:  Text(
          "Thông tin dịch vụ",
          //widget.service.name.toString(),
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
                    Text("CHI TIẾT", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.drive_file_rename_outline , "Tên dịch vụ", widget.service.name.toString()),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.attach_money , "Phí dịch vụ", widget.service.charge.toString()+" VNĐ"),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.credit_card, "Đơn vị", widget.service.type.toString()),
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
                    Text("GHI CHÚ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.service.detail.toString(),
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
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
      onPressed: (){
        fabKey.currentState!.animate();
        this.fb.delete(widget.service.id.toString());
        Navigator.pop(context);

      },
      icon: Icons.delete,
      textLeft: -80,
      text: "Xóa",
    );
  }
}
