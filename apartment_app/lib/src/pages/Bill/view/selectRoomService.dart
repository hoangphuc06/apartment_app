import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/fire_base/fb_floor_info.dart';
import 'package:apartment_app/src/pages/Bill/view/add_new_bill_page.dart';
import 'package:apartment_app/src/widgets/cards/floor_info_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SelectRoomService extends StatefulWidget {
  // const SelectRoomService({Key? key}) : super(key: key);
  final String status;
  SelectRoomService({required this.status});
  @override
  _SelectRoomServiceState createState() => _SelectRoomServiceState();
}

class _SelectRoomServiceState extends State<SelectRoomService> {
  FloorInfoFB floorInfoFB = new FloorInfoFB();

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
                    stream: floorInfoFB.collectionReference.where('status',isEqualTo: this.widget.status).snapshots(),
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
                              return FloorInfoCard(
                                id: x["id"],
                                status: x["status"],
                                funtion: () {
                                 Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddBillPage(id: x["id"])));
                                },
                              );
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
