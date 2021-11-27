import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/fire_base/fb_floor_info.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_owner.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_rentedRoom.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_renter.dart';

import 'package:apartment_app/src/pages/contract/view/add_person.dart';
import 'package:apartment_app/src/pages/dweller/firebase/fb_dweller.dart';
import 'package:apartment_app/src/pages/dweller/model/dweller_model.dart';
import 'package:apartment_app/src/widgets/appbars/my_app_bar.dart';
import 'package:apartment_app/src/widgets/cards/floor_info_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SelectOwner extends StatefulWidget {
  const SelectOwner({Key? key}) : super(key: key);

  @override
  _SelectOwnerState createState() => _SelectOwnerState();
}

class _SelectOwnerState extends State<SelectOwner> {
  DwellersFB dwellersFB = new DwellersFB();
  OwnerFB ownerFB = new OwnerFB();
  String name = '';
  String phoneNumber = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar("Đại diện cho thuê"),
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
                    stream: ownerFB.collectionReference.snapshots(),
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

                              return GestureDetector(
                                onTap: () {
                                  Navigator.pop(context, x["id"]);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey.withOpacity(0.2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  padding: EdgeInsets.all(16),
                                  margin: EdgeInsets.only(bottom: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.person),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            x["name"],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Spacer(),
                                          Text(
                                            x["gender"] == "0" ? "Nam" : "Nữ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: x["gender"] == "0"
                                                  ? myRed
                                                  : myYellow,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: myGreen,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPerson(flag: '1',)));
        },
      ),
    );
  }

  String getName(String id) {
    String name = '';
    dwellersFB.collectionReference
        .doc(id)
        .get()
        .then((value) => {name = value['name']});
    return name;
  }
}
