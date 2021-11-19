import 'package:apartment_app/src/widgets/cards/bill_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:apartment_app/src/fire_base/fb_floor_info.dart';
import 'package:apartment_app/src/pages/Bill/view/add_new_bill_page.dart';
import 'package:apartment_app/src/pages/Bill/view/bill_detail_page.dart';
import 'package:apartment_app/src/pages/Bill/firebase/fb_bill.dart';

class ListBillInfoPage extends StatefulWidget {
  String id;
  ListBillInfoPage(this.id);

  @override
  _ListBillInfoPageState createState() => _ListBillInfoPageState();
}

class _ListBillInfoPageState extends State<ListBillInfoPage> {

  BillFB billFB = new BillFB();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  "Danh sách hóa đơn",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              Container(
                child: SingleChildScrollView(
                  child: StreamBuilder(
                    stream: billFB.collectionReference.where('roomid', isEqualTo: widget.id).snapshots(),
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
                              return BillCard(
                                  MonthYear: x['month']+"/"+x['year'],
                                  billdate: x['billdate'],
                                  status: x['status'],
                                  funtion: ()
                                  {
                                    //Navigator.push(context, MaterialPageRoute(builder: (context) => BillDetailPage(x['billid'])));
                                  }
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
          //Navigator.push(context, MaterialPageRoute(builder: (context) => BillInfoPage(widget.id)));
        },
        label: Text("Thêm hóa đơn", style: TextStyle(color: Colors.black),),
      ),
    );
  }
}