import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/model/card.dart';
import 'package:apartment_app/src/widgets/cards/otherListItem.dart';
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
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        orientation: Orientation.portrait);
    return Scaffold(
       backgroundColor: Colors.grey.withOpacity(0.1),
        appBar: AppBar(
          backgroundColor: myGreen,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Khác",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ),
        body: SingleChildScrollView(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: card.length,
                itemBuilder: (context, i) {
                  return OtherListItem(
                      text: card[i].title!,
                      icon: card[i].icon!,
                      function: () {
                        Navigator.pushNamed(context, card[i].nextPage!);
                      });
                })));
  }
}
