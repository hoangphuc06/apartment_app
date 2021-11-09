import 'package:cloud_firestore/cloud_firestore.dart';
class ServiceFB{
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference collectionReference = FirebaseFirestore.instance.collection("ServiceInfo");
  Future<void> add(  String name, String note,String charge,String type) async {
    String id = (new DateTime.now().millisecondsSinceEpoch).toString();
    return FirebaseFirestore.instance.collection("ServiceInfo").doc(id).set({
      'name': name,
      'charge':charge,
      'type':type,
      'note':note,
      'id':id,
    })
        .then((value) => print("completed"))
        .catchError((error)=>print("fail"));
  }

  Future<void> update(String id,  String name, String note,String charge,String type) async {
    return FirebaseFirestore.instance.collection("ServiceInfo").doc(id).update({
      'name': name,
      'note':note,
      'type':type,
      'charge':charge
    })
        .then((value) => print("completed"))
        .catchError((error)=>print("fail"));
  }

  Future<void> delete(String id) async {
    return FirebaseFirestore.instance.collection("ServiceInfo").doc(id).delete();
  }

}



