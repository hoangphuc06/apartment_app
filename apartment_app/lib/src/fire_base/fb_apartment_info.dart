import 'package:cloud_firestore/cloud_firestore.dart';


class ApartmentInfoFB {

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference collectionReference = FirebaseFirestore.instance.collection("apartmentInfo");

  Future<void> add(String address, String headquarters, String linkPage, String phoneNumber1,String phoneNumber2) async {
    String id = (new DateTime.now().millisecondsSinceEpoch).toString();
    return FirebaseFirestore.instance.collection("ApartmentInfo").doc(id).set({
      "address": address,
      "headquarters": headquarters,
      "linkPage": linkPage,
      "phoneNumber1": phoneNumber1,
      "phoneNumber2": phoneNumber2,
    })
        .then((value) => print("completed"))
        .catchError((error)=>print("fail"));
  }

  Future<void> update(String id,String address, String headquarters, String linkPage, String phoneNumber1,String phoneNumber2) async {
    return FirebaseFirestore.instance.collection("apartmentInfo").doc(id).update({
      "address": address,
      "headquarters": headquarters,
      "linkPage": linkPage,
      "phoneNumber1": phoneNumber1,
      "phoneNumber2": phoneNumber2,
    })
        .then((value) => print("completed"))
        .catchError((error)=>print("fail"));
  }

  Future<void> delete(String id) async {
    return FirebaseFirestore.instance.collection("apartmentInfo").doc(id).delete();
  }

}