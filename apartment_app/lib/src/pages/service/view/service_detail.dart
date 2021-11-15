import 'package:animated_float_action_button/animated_floating_action_button.dart';
import 'package:animated_float_action_button/float_action_button_text.dart';
import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/service/firebase/fb_service.dart';
import 'package:apartment_app/src/pages/service/model/service_model.dart';
import 'package:apartment_app/src/widgets/appbars/my_app_bar.dart';
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
                SizedBox(height: 10,),
                _detail("Loại dịch vụ", widget.service.type.toString()),
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
