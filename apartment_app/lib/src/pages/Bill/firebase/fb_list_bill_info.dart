import 'package:cloud_firestore/cloud_firestore.dart';

class ApartmentBillInfo {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("billinfo");

  Future<void> add(String roomid,String billdate,String month,String year) async {
    String id = (new DateTime.now().microsecondsSinceEpoch).toString();
    return FirebaseFirestore.instance.collection("billinfo").doc(id).set({
      "billid" : id,
      "billdate" : billdate,
      "roomid" : roomid,
      "month" : month,
      "year" : year,
      "status" : 'chưa thanh toán',
    }
    ).then((value) => print("completed"))
        .catchError((error)=>print("fail"));
  }
  Future<void> update(String id,String roomid,String billdate,String status) async{
    return FirebaseFirestore.instance.collection("billinfo").doc(id).update({
      "billid" : id,
      "billdate" : billdate,
      "roomid" : roomid,
      "status" : status,
    }
    ).then((value) => print("completed"))
        .catchError((error)=>print("fail"));
  }
  Future<void> delete(String id) async{
    return FirebaseFirestore.instance.collection("billinfo").doc(id).delete();
  }
}