import 'package:apartment_app/src/model/card.dart';
import 'package:flutter/material.dart';
import 'package:apartment_app/src/fire_base/fb_optionsmanager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

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
        title: "Đổi mật khẩu",
        icon: Icons.credit_card,
        nextPage: "update_password_page"),
    CardManager(
        title: "Đăng xuất", icon: Icons.credit_card, nextPage: "login_page"),
      
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Khác",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ),
        body: SingleChildScrollView(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: card.length,
                itemBuilder: (context, i) {
                  return InkWell(
                    splashColor: Colors.amber,
                    onTap: () =>
                        {Navigator.pushNamed(context, card[i].nextPage!)},
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.grey))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(
                                    card[i].icon,
                                    color: Colors.grey,
                                    size: 30,
                                  ),
                                ),
                                Text(
                                  card[i].title!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  );
                })));
  }
}
