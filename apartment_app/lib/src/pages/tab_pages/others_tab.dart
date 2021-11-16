import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/model/card.dart';
import 'package:apartment_app/src/widgets/appbars/my_app_bar.dart';
import 'package:apartment_app/src/widgets/cards/otherListItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:apartment_app/src/fire_base/fb_optionsmanager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OthersTab extends StatefulWidget {
  const OthersTab({Key? key}) : super(key: key);

  @override
  _OthersTabState createState() => _OthersTabState();
}

class _OthersTabState extends State<OthersTab> {
  OptionsManagerFB optionsManagerFB = new OptionsManagerFB();

  List<CardManager> card = [
    CardManager(
        title: "Thông tin chung cư",
        icon: Icons.info_outline,
        nextPage: "introduction_page"),
    CardManager(
        title: "Dịch vụ", icon: Icons.credit_card, nextPage: "service_page"),
    CardManager(
        title: "Loại căn hộ",
        icon: Icons.apartment,
        nextPage: "category_apartment_page"),
    CardManager(
        title: "Đổi mật khẩu",
        icon: Icons.credit_card,
        nextPage: "update_password_page"),
    CardManager(
        title: "Đăng xuất", icon: Icons.credit_card, nextPage: "login_page"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
        appBar: myAppBar("Khác"),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title("Phần mềm"),

              SizedBox(height: 10,),

              _tab_detail("Hỗ trợ", (){
                print("2");
              }),

              SizedBox(height: 10,),

              _tab_detail("Điều khoản sử dụng dịch vụ", (){
                print("2");
              }),

              SizedBox(height: 10,),

              _tab_detail("Chính sách quyền riêng tư", (){
                print("2");
              }),

              SizedBox(height: 10,),

              _tab_detail("Ý kiến phản hồi", (){
                print("2");
              }),

              SizedBox(height: 30,),

              _title("Tài khoản"),

              SizedBox(height: 10,),

              _tab_detail("Đổi mật khẩu", (){
                print("2");
              }),

              SizedBox(height: 10,),

              _tab_logout("Đăng xuất", (){
                _logout();
              }),
            ],
          ),
        )
    );
  }

  _logout() {
    Navigator.pushReplacementNamed(context, "login_page");
    FirebaseAuth.instance.signOut();
  }

  _title(String text) => Text(
    text,
    style: TextStyle(
        color: Colors.black.withOpacity(0.5),
        fontWeight: FontWeight.bold
    ),
  );

  _tab_detail(String name, Function funtion) => GestureDetector(
    onTap: (){
      funtion();
    },
    child: Container(
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
          Icon(Icons.arrow_forward_ios_rounded, size: 15,)
        ],
      ),
    ),
  );

  _tab_logout(String name, Function funtion) => GestureDetector(
    onTap: (){
      funtion();
    },
    child: Container(
      padding: EdgeInsets.all(8),
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: myGreen.withOpacity(0.2)
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
          Icon(Icons.arrow_forward_ios_rounded, size: 15,)
        ],
      ),
    ),
  );
}
