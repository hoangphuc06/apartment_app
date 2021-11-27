import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/fire_base/fb_floor_info.dart';
import 'package:apartment_app/src/pages/Bill/view/close_bill.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_contract.dart';
import 'package:apartment_app/src/widgets/cards/floor_info_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SelectRoomService extends StatefulWidget {
  // const SelectRoomService({Key? key}) : super(key: key);
  final List<String> listIdRoom1;
  final List<String> listIdRoom2;
  SelectRoomService({required this.listIdRoom1, required this.listIdRoom2});
  @override
  _SelectRoomServiceState createState() => _SelectRoomServiceState();
}

class _SelectRoomServiceState extends State<SelectRoomService> {
  FloorInfoFB floorInfoFB = new FloorInfoFB();
  ContractFB contractFB = new ContractFB();
  List<String> listContract = <String>[];
  Future<void> loadData() async {
    ContractFB contractFB = new ContractFB();
    listContract.add('h');
    Stream<QuerySnapshot> query = contractFB.collectionReference
        .where('liquidation', isEqualTo: false)
        .snapshots();
    await query.forEach((x) {
      x.docs.asMap().forEach((key, value) {
        var t = x.docs[key];
        listContract.add(t['id']);
      });
    });
  }

  @override
  void initState() {
    loadData();
    widget.listIdRoom1
        .removeWhere((element) => widget.listIdRoom2.contains(element));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: myGreen,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Chọn phòng",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: StreamBuilder(
                    stream: floorInfoFB.collectionReference
                        .where('id', whereNotIn: this.widget.listIdRoom1)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: Text("Dữ liệu trống"),
                        );
                      } else {
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, i) {
                              QueryDocumentSnapshot x = snapshot.data!.docs[i];
                              if (x['status'] != 'Trống') {
                                return FloorInfoCard(
                                  id: x["id"],
                                  status: x["status"],
                                  funtion: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CloseBill(
                                                  listContract: listContract,
                                                  liquidation: '0',
                                                  id: x["id"],
                                                  flag: '0',
                                                )));
                                  },
                                );
                              } else {
                                return Container();
                              }
                            });
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
