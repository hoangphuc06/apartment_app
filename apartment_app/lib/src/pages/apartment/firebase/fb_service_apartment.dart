import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceApartmentFB {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("service_apartment");

  Future<void> add(String idRoom,String idService) async {
    String id = (new DateTime.now().microsecondsSinceEpoch).toString();
    return FirebaseFirestore.instance.collection("service_apartment").doc(id).set({
      "idRoom" : idRoom,
      "idService" : idService,
    }
    ).then((value) => print("completed"))
        .catchError((error)=>print("fail"));
  }
 
  Future<void> delete(String id) async{
    return FirebaseFirestore.instance.collection("service_apartment").doc(id).delete();
  }
}