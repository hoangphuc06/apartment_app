import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/apartment/firebase/fb_service_apartment.dart';
import 'package:apartment_app/src/pages/apartment/view/selectService.dart';
import 'package:apartment_app/src/pages/service/model/service_model.dart';
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
    listIdService.add('s');
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            _title("Danh sách dịch vụ"),
            SizedBox(height: 10,),
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
                                                Text(y["name"], style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                                Spacer(),
                                                Text(y["charge"]+" VNĐ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                              ],
                                            )
                                          ],
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
   _title(String text) => Text(
     text,
     style: TextStyle(
         color: Colors.black.withOpacity(0.5),
         fontWeight: FontWeight.bold
     ),
   );
}
