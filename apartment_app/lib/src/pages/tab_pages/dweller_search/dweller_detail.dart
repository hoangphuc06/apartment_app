import 'package:animated_float_action_button/animated_floating_action_button.dart';
import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/dweller/firebase/fb_dweller.dart';
import 'package:apartment_app/src/pages/dweller/model/dweller_model.dart';
import 'package:flutter/material.dart';

import 'model/dweller_info.dart';
import 'modify_dweller.dart';


class DwellerDetailPage extends StatefulWidget {
  late Dweller dweller;
  DwellerDetailPage({Key? key,
    required this.dweller}) : super(key: key);
  @override
  _DwellerDetailPageState createState() => _DwellerDetailPageState();
}

class _DwellerDetailPageState extends State<DwellerDetailPage> {
  final GlobalKey<AnimatedFloatingActionButtonState> fabKey = GlobalKey();
  DwellersFB fb = new DwellersFB();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: myGreen,
        elevation: 0,
        centerTitle: true,
        title:  Text('Thông tin',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
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
                    Text("Thông tin", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.people , "Họ và tên", widget.dweller.name.toString()),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.credit_card, "Số CMND", widget.dweller.cmnd.toString()),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.calendar_today, "Ngày sinh", widget.dweller.birthday.toString() ),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.people_alt_outlined, "Giới tính", widget.dweller.gender.toString()=='0'?'Nam':'Nữ' ),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.home, "Quê quán", widget.dweller.homeTown.toString() ),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.wysiwyg, "Nghề nghiệp", widget.dweller.job.toString() ),
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
                    SizedBox(height: 10,),
                    Text("Liên hệ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.email, "Email", widget.dweller.email.toString() ),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.phone, "Số điện thoại", widget.dweller.phoneNumber.toString() ),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.home, "Số căn hộ", widget.dweller.idApartment.toString() ),
                    SizedBox(height: 20,),
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



  Widget edit() {
    return FloatActionButtonText(
      onPressed: ()async{
        fabKey.currentState!.animate();
        dynamic Result=  await  Navigator.push(context, MaterialPageRoute(builder: (context) => ModifyDwellerPage(info: this.widget.dweller,)));
        if(Result.runtimeType==DwellerModel)
        {
          setState(() {
            this.widget.dweller=Result;
          });
        }
      },
      icon: Icons.mode_edit,
      text: "Sửa",
      textLeft: -80,
    );
  }
}
