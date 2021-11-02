import 'package:animated_float_action_button/animated_floating_action_button.dart';
import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/dweller/model/dweller_model.dart';
import 'package:apartment_app/src/pages/dweller/view/edit_dweller_page.dart';
import 'package:flutter/material.dart';

class DetailDwellerPage extends StatefulWidget {
  late  Dweller dweller;
  DetailDwellerPage({Key? key,
  required this.dweller}) : super(key: key);

  @override
  _DetailDwellerPageState createState() => _DetailDwellerPageState();
}

class _DetailDwellerPageState extends State<DetailDwellerPage> {

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
          "Hồ sơ",
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
                    _detailInfo(Icons.person, "Họ tên", widget.dweller.name.toString()),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.wc, "Giới tính", widget.dweller.gender.toString()=="0"? "Nam" : "Nữ"),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.cake, "Ngày sinh", widget.dweller.birthday.toString()),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.credit_card_rounded, "CMND", widget.dweller.cmnd.toString()==""?"Trống":widget.dweller.cmnd.toString()),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.location_on, "Quê quán", widget.dweller.homeTown.toString()),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.build, "Nghề nghiệp", widget.dweller.job.toString()),
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
                    Text("Cư trú", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.home, "Căn hộ", widget.dweller.idApartment.toString()),
                    SizedBox(height: 20,),
                    _detailInfo(
                      Icons.person_pin,
                      "Vai trò",
                        widget.dweller.role.toString()=="1"?"Chủ hộ" : widget.dweller.role.toString()=="2"?"Người thân chủ hộ" : "Người thuê lại"
                    ),
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
                    Text("Liên hệ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.phone, "Số điện thoại", widget.dweller.phoneNumber.toString()==""?"Trống":widget.dweller.phoneNumber.toString()),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.email, "Email", widget.dweller.email.toString()==""?"Trống":widget.dweller.email.toString()),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: AnimatedFloatingActionButton(
      //     key: fabKey,
      //     fabButtons: <Widget>[
      //       edit(),
      //       delete(),
      //     ],
      //     colorStartAnimation: myGreen,
      //     colorEndAnimation: myGreen,
      //     animatedIconData: AnimatedIcons.menu_close //To principal button
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _gotoPage();
        },
        child: Icon(Icons.menu, color: Colors.white,),
        backgroundColor: myGreen,
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
    final Dweller d = await Navigator.push(context, MaterialPageRoute(builder: (context) => EditDwellerPage(this.widget.dweller)));
    if (d!=null) {
      setState(() {
        this.widget.dweller = d;
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
}
