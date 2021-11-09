import 'package:cloud_firestore/cloud_firestore.dart';

class FloorFB {
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("floor");
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> add(String floorid,String numofapm) async {
    //String id = (new DateTime.now().microsecondsSinceEpoch).toString();
    return FirebaseFirestore.instance.collection("floor").doc(floorid).set({
      "id" : floorid,
      "numOfApm" : numofapm
    }
    ).then((value) => print("completed"))
        .catchError((error)=>print("fail"));
  }
  Future<void> update(String floorid,String numofapm) async{
    return FirebaseFirestore.instance.collection("floor").doc(floorid).update({
      "numOfApm" : numofapm
    }
    ).then((value) => print("completed"))
        .catchError((error)=>print("fail"));
  }

  Future<void> delete(String id) async{
    return FirebaseFirestore.instance.collection("floorinfo").doc(id).delete();
  }
}