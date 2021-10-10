import 'package:apartment_app/src/fire_base/fb_floor.dart';
import 'package:apartment_app/src/pages/list_apartment_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class ApartmentPage extends StatefulWidget {
  const ApartmentPage({Key? key}) : super(key: key);

  @override
  _ApartmentPageState createState() => _ApartmentPageState();
}

class _ApartmentPageState extends State<ApartmentPage> {

  //ApartmentFB apartmentFB = new ApartmentFB();
  FloorFB floorFB = new FloorFB();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Chung cu",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Expanded(
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
                          color: Colors.white70,
                          elevation: 1,
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ListApartmentPage(),
                                  ));
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
      ),
    );
  }
}
