import 'package:apartment_app/src/fire_base/fb_floor.dart';
import 'package:apartment_app/src/fire_base/fb_floor_info.dart';
import 'package:apartment_app/src/pages/floor_info_page.dart';
import 'package:apartment_app/src/widgets/cards/floor_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FloorTab extends StatefulWidget {
  const FloorTab({Key? key}) : super(key: key);

  @override
  _FloorTabState createState() => _FloorTabState();
}

class _FloorTabState extends State<FloorTab> {

  FloorFB floorFB = new FloorFB();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.grey.withOpacity(0.1),
      body: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Danh sách tầng",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: SingleChildScrollView(
                child: StreamBuilder(
                    stream: floorFB.collectionReference.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: Text("No Data"),);
                      }
                      else {
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context,i) {
                              QueryDocumentSnapshot x = snapshot.data!.docs[i];
                              return FloorCard(
                                name: x["id"],
                                numOfApm: x["numOfApm"],
                                funtion: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => FloorInfoPage(floorid: x["id"])));
                                },
                              );
                            }
                        );
                      }
                    }
                ),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {  },
      //   label: Text("Thêm tầng"),
      // ),
    );
  }
}
