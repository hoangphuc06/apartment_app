import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/introduction/firebase/fb_introduction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';

import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  IntroductionFB introductionFB = new IntroductionFB();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: myGreen,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Thông tin chung cư",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: Stack(children: [
        StreamBuilder(
            stream: introductionFB.collectionReference.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Text("No Data"),
                );
              } else {
                QueryDocumentSnapshot x = snapshot.data!.docs[0];
                return Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Card(
                        elevation: 2,
                        child: Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              'assets/images/4.jpg'))),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'DREAM BUILDING',
                                        style: GoogleFonts.alike(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Giải Pháp Quản Lý Chung Cư Thông Minh \nKết Nối Giữa Ban Quản Lý Và Cư Dân Tòa Nhà.',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15.0),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(right: 5),
                                      child: Icon(Icons.tty),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              right: BorderSide(
                                        color: Colors.grey,
                                      ))),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Hotline 24/7",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            x["phoneNumber1"],
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            x["phoneNumber2"],
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            x["linkPage"],
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(right: 5),
                                      child: Icon(Icons.location_on_outlined),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              right: BorderSide(
                                        color: Colors.grey,
                                      ))),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Trụ sở chính",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            x["headquarters"],
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            x["address"],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                );
              }
            }),
      ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        backgroundColor: myGreen,
        onPressed: () {
          Navigator.pushNamed(context, "edit_introduction_page");
        },
      ),
    );
  }
}
//  Container(
//                                   alignment: Alignment.center,
//                                   padding: EdgeInsets.all(15),
//                                   child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           "Xem thêm thông tin sản phẩm",
//                                           textAlign: TextAlign.center,
//                                         ),
//                                         Icon(
//                                           Icons.arrow_drop_down,
//                                           color: Colors.grey,
//                                         ),
//                                       ]),
//                                 ),
                               