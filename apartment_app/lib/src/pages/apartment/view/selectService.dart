import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/apartment/firebase/fb_service_apartment.dart';
import 'package:apartment_app/src/pages/service/firebase/fb_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SelectServicePage extends StatefulWidget {
  // const SelectServicePage({ Key? key }) : super(key: key);
  final List<String> listIdService;
  final id;
  SelectServicePage({required this.listIdService, required this.id});
  @override
  _SelectServicePageState createState() => _SelectServicePageState();
}

class _SelectServicePageState extends State<SelectServicePage> {
  ServiceApartmentFB serviceApartmentFB = new ServiceApartmentFB();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myGreen,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Thêm dịch vụ cho phòng",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("ServiceInfo")
                    .where('id', whereNotIn: this.widget.listIdService)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: Text("No Data"));
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, i) {
                          QueryDocumentSnapshot x = snapshot.data!.docs[i];

                          return GestureDetector(
                            onTap: () {
                              serviceApartmentFB.add(this.widget.id,x['id'],);
                              Navigator.pop(context);
                            },
                            child: Card(
                              elevation: 2,
                              child: Container(
                                margin: EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      x['name'],
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.attach_money),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Phí dịch vụ",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Spacer(),
                                        Text(
                                          x['charge'] + " VNĐ",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.credit_card),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Đơn vị",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Spacer(),
                                        Text(
                                          x['type'],
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  }
                })
          ],
        ),
      ),
    );
  }
}
