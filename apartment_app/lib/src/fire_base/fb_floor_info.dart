import 'package:cloud_firestore/cloud_firestore.dart';

class FloorInfoFB{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("floorinfo");

  Future<void> add(String floorid,String name,String status) async {
  String id = (new DateTime.now().microsecondsSinceEpoch).toString();
  return FirebaseFirestore.instance.collection("floorinfo").doc(id).set({
    "id" : id,
    "name" : name,
    "floorid" : floorid,
    "status" : status,
    }
  ).then((value) => print("completed"))
      .catchError((error)=>print("fail"));
  }
  Future<void> update(String id,String floorid,String name,String status) async{
    return FirebaseFirestore.instance.collection("floorinfo").doc(id).update({
      "name" : name,
      "floorid" : floorid,
      "status" : status,
    }
    ).then((value) => print("completed"))
        .catchError((error)=>print("fail"));
  }
  Future<void> delete(String id) async{
    return FirebaseFirestore.instance.collection("floorinfo").doc(id).delete();
  }
}