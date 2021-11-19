import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/Bill/firebase/fb_billinfo.dart';
import 'package:apartment_app/src/pages/Bill/view/bill_detail_page.dart';
import 'package:apartment_app/src/pages/Bill/view/selectRoomService.dart';
import 'package:apartment_app/src/pages/contract/view/selectRoom.dart';
import 'package:apartment_app/src/widgets/cards/bill_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BillPaid extends StatefulWidget {
  const BillPaid({Key? key}) : super(key: key);

  @override
  _BillPaidState createState() => _BillPaidState();
}

class _BillPaidState extends State<BillPaid> {
  bool isPaid = false;
  BillInfoFB billInfoFB = new BillInfoFB();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.1),
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: _title("Danh sách hóa đơn"),
          ),
          Container(
            margin: EdgeInsets.all(16),
            child: StreamBuilder(
                stream: billInfoFB.collectionReference
                    .where('status', isEqualTo: 'Đã thanh toán')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: emptyTab(),
                    );
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, i) {
                          QueryDocumentSnapshot x = snapshot.data!.docs[i];
                          return BillCard(
                              id: x["idBillInfo"],
                              idRoom: x["idRoom"],
                              funtion: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BillDetailPage(
                                              flag: false,
                                              id: x['idBillInfo'],
                                            )));
                              });
                        });
                  }
                }),
          ),
        ])));
  }
}

Widget emptyTab() {
  return Center(
      child: Text(
    "Dữ liệu trống",
    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
  ));
}

_title(String text) => Text(
      text,
      style: TextStyle(
          color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.bold),
    );
