import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:apartment_app/src/fire_base/fb_floor_info.dart';
import 'package:apartment_app/src/pages/Bill/view/add_new_bill_page.dart';
import 'package:apartment_app/src/pages/Bill/firebase/fb_list_bill_info.dart';

class ListBillInfoPage extends StatefulWidget {
  String id;
  ListBillInfoPage(this.id);

  @override
  _ListBillInfoPageState createState() => _ListBillInfoPageState();
}

class _ListBillInfoPageState extends State<ListBillInfoPage> {

  ApartmentBillInfo apartmentBillInfo = new ApartmentBillInfo();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                child: Text("Danh sách hóa đơn", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),),
              ),
              Container(
                child: SingleChildScrollView(
                  child: StreamBuilder(
                    stream: apartmentBillInfo.collectionReference.where('roomid', isEqualTo: widget.id).snapshots(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: Text("No Data"),);
                        }
                        else{
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context,i){
                              QueryDocumentSnapshot x = snapshot.data!.docs[i];
                              return Card(
                                color: Colors.white70,
                                elevation: 1,
                                child: ListTile(
                                  onTap: () {

                                  },
                                  title: Text(x['billid'], style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                  subtitle: Text(x['billdate'], style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                ),
                              );
                            }


                          );
                        }
                      }
                  ),
                ),
              )
            ],
          ),
        ),

      floatingActionButton: FloatingActionButton.extended(
        tooltip: 'add',
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => BillInfoPage(widget.id)));
        },
        label: Text("Thêm hóa đơn", style: TextStyle(color: Colors.black),),
      ),
    );
  }
}