import 'package:cloud_firestore/cloud_firestore.dart';

class FixFB
{
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("fix");
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> add(String URL,String detail, String title) async {
    String id = (new DateTime.now().millisecondsSinceEpoch).toString();
    return FirebaseFirestore.instance.collection("fix").doc(id).set({
      "timestamp": id,
      "image": URL,
      "detail": detail,
      "title": title,
    })
        .then((value) => print("completed"))
        .catchError((error)=>print("fail"));
  }
  Future<void> updatestatus(String id,String status) async {
    return await FirebaseFirestore.instance.collection("fix").doc(id).update({
      "status": status,
    })
        .then((value) => print("completed"))
        .catchError((error)=>print("fail"));
  }
}