import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/Bill/firebase/fb_billinfo.dart';
import 'package:apartment_app/src/pages/Bill/view/bill_detail_page.dart';
import 'package:apartment_app/src/pages/Bill/view/selectRoomService.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_contract.dart';
import 'package:apartment_app/src/pages/contract/view/selectRoom.dart';
import 'package:apartment_app/src/widgets/cards/bill_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UnpaidInvoice extends StatefulWidget {
  const UnpaidInvoice({Key? key}) : super(key: key);

  @override
  _UnpaidInvoiceState createState() => _UnpaidInvoiceState();
}

class _UnpaidInvoiceState extends State<UnpaidInvoice> {
  bool isPaid = false;
  BillInfoFB billInfoFB = new BillInfoFB();
  ContractFB contractFB = new ContractFB();
  List<String> listIdRoom = <String>[];

  Future<void> loadData() async {
    var now = DateTime.now();
    listIdRoom.add('s');
    Stream<QuerySnapshot> query = billInfoFB.collectionReference
        .where('monthBill', isEqualTo: now.toLocal().month.toString())
        .where('yearBill', isEqualTo: now.toLocal().year.toString())
        .snapshots();
    await query.forEach((x) {
      x.docs.asMap().forEach((key, value) {
        var t = x.docs[key];
        listIdRoom.add(t['idRoom']);
      });
    });
  }

  List<String> listIdRoom2 = <String>[];
  Future<void> loadData1() async {
    var now = DateTime.now();
    listIdRoom2.add('a');
    Stream<QuerySnapshot> query = contractFB.collectionReference
        .where('liquidation', isEqualTo: true)
        .snapshots();
    await query.forEach((x) {
      x.docs.asMap().forEach((key, value) {
        var t = x.docs[key];
        listIdRoom2.add(t['room']);
      });
    });
  }

  @override
  void initState() {
    loadData1();
    loadData();
    super.initState();
  }

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
                    .where('status', isEqualTo: 'Chưa thanh toán')
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
                                              flag: true,
                                              id: x['idBillInfo'],
                                            )));
                              });
                        });
                  }
                }),
          ),
        ])),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: myGreen,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SelectRoomService(
                          listIdRoom1: listIdRoom,
                          listIdRoom2: listIdRoom2,
                        )));
          },
        ));
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
