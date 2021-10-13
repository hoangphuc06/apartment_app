import 'package:apartment_app/src/fire_base/fb_floor.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Danh sách tầng",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Spacer(),
                PopupMenuButton(itemBuilder: (context) => [
                  PopupMenuItem(
                      child: Row(
                        children: [
                          Text("Thêm tầng")
                        ],
                      )
                  )
                ]),
              ],
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
                              return Card(
                                color: Colors.grey,
                                elevation: 1,
                                child: ListTile(
                                  onTap: () {

                                  },
                                  title: Text(x['name'], style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                ),
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