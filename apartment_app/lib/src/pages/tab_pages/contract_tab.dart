import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_contract.dart';
import 'package:apartment_app/src/pages/contract/view/add_contract_page.dart';
import 'package:apartment_app/src/pages/contract/view/contract_details_page.dart';
import 'package:apartment_app/src/widgets/cards/contract_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ContractTab extends StatefulWidget {
  const ContractTab({Key? key}) : super(key: key);

  @override
  _ContractTabState createState() => _ContractTabState();
}

class _ContractTabState extends State<ContractTab> {
  @override
  Widget build(BuildContext context) {
    ContractFB contractFB = new ContractFB();

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.1),
      body: Container(
          padding: EdgeInsets.all(8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Danh sách hợp đồng",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: StreamBuilder(
                    stream: contractFB.collectionReference
                        .where('isVisible', isEqualTo: true)
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
                                            builder: (context) =>
                                                ContractDetails(id: x["id"])));
                                  });
                            });
                      }
                    }),
              ),
            ),
          ])),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: myGreen,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddContractPage(id:'',)));
        },
      ),
    );
  }
}
