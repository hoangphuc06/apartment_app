import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/fire_base/fb_floor.dart';
import 'package:apartment_app/src/pages/category_apartment/model/category_apartment_model.dart';
import 'package:apartment_app/src/pages/category_apartment/view/category_apartment_page.dart';
import 'package:apartment_app/src/pages/floor_info_page.dart';
import 'package:apartment_app/src/pages/service/view/manage_service_page.dart';
import 'package:apartment_app/src/pages/tab_pages/bill_tab/bill_tab.dart';
import 'package:apartment_app/src/pages/tab_pages/contract_tab.dart';
import 'package:apartment_app/src/widgets/appbars/my_app_bar.dart';
import 'package:apartment_app/src/widgets/cards/floor_card.dart';
import 'package:apartment_app/src/widgets/navbar/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FloorFB floorFB = new FloorFB();

  late int a;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
                background: Stack(children: [
              Image(
                width: double.infinity,
                height: 350,
                fit: BoxFit.cover,
                image: AssetImage('assets/images/4.jpg'),
              ),
              Container(
                decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 1.5)),
                width: double.infinity,
                height: 350,
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Dream Building",
                      style: GoogleFonts.aBeeZee(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "SĐT: 0336281849",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Đ/c: KP6, Linh Trung, Thủ Đức, TP.HCM",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ]))),
        SliverList(
            delegate: SliverChildListDelegate([
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: _title("Danh sách tầng"),
          ),
          Container(
            margin: EdgeInsets.all(16),
            height: 100,
            child: StreamBuilder(
                stream: floorFB.collectionReference.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text("No Data"),
                    );
                  } else {
                    a = snapshot.data!.docs.length;
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, i) {
                          QueryDocumentSnapshot x = snapshot.data!.docs[i];
                          return FloorCard(
                            name: x["id"],
                            numOfApm: x["numOfApm"],
                            funtion: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FloorInfoPage(floorid: x["id"])));
                            },
                          );
                        });
                  }
                }),
          ),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "Thêm vào một tầng mới",
                style: TextStyle(fontWeight: FontWeight.w500, color: myGreen),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: _title("Quản lý"),
          ),
          Container(
            margin: EdgeInsets.all(16),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _lableButton(size, Icons.assignment_rounded, "Hợp đồng", () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ContractTab()));
                }),
                _lableButton(size, Icons.description, "Hóa đơn", () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BillTab()));
                }),
                _lableButton(size, Icons.wifi, "Dịch vụ", () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ServicePage()));
                }),
                _lableButton(size, Icons.apartment, "Loại căn hộ", () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CategoryApartmentPage()));
                }),
                _lableButton(size, Icons.mail, "Thông báo", () {}),
                _lableButton(size, Icons.build, "Sửa chữa", () {}),
              ],
            ),
          ),
        ]))
      ]),
    );
  }

  _title(String text) => Text(
        text,
        style: TextStyle(
            color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.bold),
      );

  _lableButton(Size size, IconData icon, String text, funtion) =>
      GestureDetector(
        onTap: funtion,
        child: Container(
          width: (size.width - 52) / 3,
          height: (size.width - 52) / 4,
          decoration: BoxDecoration(
              color: Colors.blueGrey.withOpacity(0.2),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.black,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                text,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      );
}
