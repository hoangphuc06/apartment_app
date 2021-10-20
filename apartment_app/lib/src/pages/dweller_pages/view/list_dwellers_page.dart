import 'package:apartment_app/src/pages/dweller_pages/fire_base/fb_dweller.dart';
import 'package:apartment_app/src/pages/dweller_pages/view/edit_dweller_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListDwellersPage extends StatefulWidget {
  const ListDwellersPage({Key? key}) : super(key: key);

  @override
  _ListDwellersPageState createState() => _ListDwellersPageState();
}

class _ListDwellersPageState extends State<ListDwellersPage> {

  DwellersFB dwellersFB = new DwellersFB();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Expanded(
          child: SingleChildScrollView(
            child: StreamBuilder(
                stream: dwellersFB.collectionReference.snapshots(),
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
                                Navigator.push(context, MaterialPageRoute(builder: (context) => EditDwellerPage(x["id"])));
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
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, "add_dweller_page");
          },
          label: Text("Thêm thành viên", style: TextStyle(color: Colors.black),)
      ),
    );
  }
}
