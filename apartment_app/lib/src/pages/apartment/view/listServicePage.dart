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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance.collection("service_apartment").where('idRoom', isEqualTo: widget.id).snapshots(),
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
                            stream: FirebaseFirestore.instance.collection("ServiceInfo").where('id', isEqualTo: x["idService"]).snapshots(),
                            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return Center(child: Text("No Data"));
                              } else
                              return ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, i) {
                                  QueryDocumentSnapshot y = snapshot.data!.docs[i];
                                  return ListTile(
                                    title: Text(y["name"]),
                                  );
                                }
                              );
                            }
                          ),
                        );
                      },
                    );
                  }
                }
            ),
          ],
        ),
      ),
    );
  }
}