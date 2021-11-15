import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/apartment/firebase/fb_service_apartment.dart';
import 'package:apartment_app/src/pages/apartment/view/selectService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListServicePage extends StatefulWidget {
  // const ListServicePage({ Key? key }) : super(key: key);
  final String id;
  ListServicePage({required this.id});
  @override
  _ListServicePageState createState() => _ListServicePageState();
}

class _ListServicePageState extends State<ListServicePage> {
   List<String> listIdService = <String>[];

  Future<void> loadData() async {
    ServiceApartmentFB serviceApartmentFB = new ServiceApartmentFB();
    Stream<QuerySnapshot> query = serviceApartmentFB.collectionReference
        .where('idRoom', isEqualTo: widget.id)
        .snapshots();
    await query.forEach((x) {
      x.docs.asMap().forEach((key, value) {
        var t = x.docs[key];
        listIdService.add(t['idService'].toString());
         print(listIdService[0]);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // listIdService.add('1636025589162');
     this.loadData();
    //  createListCard();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("service_apartment")
                    .where('idRoom', isEqualTo: widget.id)
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
                        return Container(
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("ServiceInfo")
                                  .where('id', isEqualTo: x["idService"])
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(child: Text(""));
                                } else {
                                  QueryDocumentSnapshot y =
                                      snapshot.data!.docs[0];
                                  return GestureDetector(
                                    onTap: (){},
                                    child: Card(
                                      elevation: 2,
                                      child: Container(
                                        margin: EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              y['name'],
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
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                                Spacer(),
                                                Text(
                                                  y['charge'] + " VNĐ",
                                                  style:
                                                      TextStyle(fontSize: 15),
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
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                                Spacer(),
                                                Text(
                                                  y['type'],
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              }),
                        );
                      },
                    );
                  }
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => SelectServicePage(listIdService: listIdService,id: this.widget.id,)));
        },
        backgroundColor: myGreen,
      ),
    );
  }
}
