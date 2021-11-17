import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/apartment/firebase/fb_service_apartment.dart';
import 'package:apartment_app/src/pages/service/firebase/fb_service.dart';
import 'package:apartment_app/src/widgets/appbars/my_app_bar.dart';
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
      appBar: myAppBar("Thêm dịch vụ phòng"),
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
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey.withOpacity(0.2),
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              padding: EdgeInsets.all(16),
                              margin: EdgeInsets.only(bottom: 8),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.local_laundry_service_outlined),
                                      SizedBox(width: 5,),
                                      Text(x["name"], style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                      Spacer(),
                                      Text(x["charge"]+" VNĐ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                    ],
                                  )
                                ],
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
