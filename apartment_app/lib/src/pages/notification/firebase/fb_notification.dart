import 'package:cloud_firestore/cloud_firestore.dart';
class NotificationFB{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("notification");
  Future<void> add( String title, String body,Timestamp date) async {
    String id = (new DateTime.now().millisecondsSinceEpoch).toString();
    return FirebaseFirestore.instance.collection("notification").doc(id).set({
      'body':body,
      'date':date,
      'id':id,
      'title':title
    })
        .then((value) => print("completed"))
        .catchError((error)=>print("fail"));
  }

  Future<void> update(String id,String title, String body,Timestamp date) async {
    return FirebaseFirestore.instance.collection("notification").doc(id).update({
      "title": title,
      'body':body,
      'date':date,
    })
        .then((value) => print("completed"))
        .catchError((error)=>print("fail"));
  }

  Future<void> delete(String id) async {
    return FirebaseFirestore.instance.collection("notification").doc(id).delete();
  }

}



