import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_contract.dart';
import 'package:apartment_app/src/pages/contract/view/add_contract_page.dart';
import 'package:apartment_app/src/pages/contract/view/contract_details_page.dart';
import 'package:apartment_app/src/widgets/appbars/my_app_bar.dart';
import 'package:apartment_app/src/widgets/cards/contract_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ContractNotLiquidation extends StatefulWidget {
  const ContractNotLiquidation({Key? key}) : super(key: key);

  @override
  _ContractNotLiquidationState createState() => _ContractNotLiquidationState();
}

class _ContractNotLiquidationState extends State<ContractNotLiquidation> {
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ContractFB contractFB = new ContractFB();
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: myAppBar(
      //   "Hợp đồng",
      // ),
      body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: _title("Danh sách hợp đồng"),
        ),
        Container(
          margin: EdgeInsets.all(16),
          child: StreamBuilder(
              stream: contractFB.collectionReference
                  .where('isVisible', isEqualTo: true)
                  .where('liquidation', isEqualTo: false)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Text("No Data"),
                  );
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, i) {
                        QueryDocumentSnapshot x = snapshot.data!.docs[i];
                        return ContractCard(
                            id: x["id"],
                            host: x["host"],
                            room: x["room"],
                            startDay: x["startDay"],
                            expirationDate: x["expirationDate"],
                            funtion: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ContractDetails(
                                            listContract: listContract,
                                            id: x["id"],
                                            idRoom: x['room'],
                                            flag: '0',
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
                  builder: (context) => AddContractPage(
                        id: '',
                      )));
        },
      ),
    );
  }

  _title(String text) => Text(
        text,
        style: TextStyle(
            color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.bold),
      );
}
