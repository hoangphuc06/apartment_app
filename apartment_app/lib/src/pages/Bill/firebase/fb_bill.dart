import 'package:cloud_firestore/cloud_firestore.dart';

class BillFB {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("bill");

  Future<void> add(String idBillinfo,String idRoom,String month,String year) async {
    String id = (new DateTime.now().microsecondsSinceEpoch).toString();
    return FirebaseFirestore.instance.collection("bill").doc(id).set({
      "id" : id,
      "idBillinfo" : idBillinfo,
      "idRoom" : idRoom,
      "month" : month,
      "year" : year,
    }
    ).then((value) => print("completed"))
        .catchError((error)=>print("fail"));
  }
  // Future<void> update(String id,String roomid,String billdate,String status) async{
  //   return FirebaseFirestore.instance.collection("billinfo").doc(id).update({
  //     "billid" : id,
  //     "billdate" : billdate,
  //     "roomid" : roomid,
  //     "status" : status,
  //   }
  //   ).then((value) => print("completed"))
  //       .catchError((error)=>print("fail"));
  // }
  Future<void> delete(String id) async{
    return FirebaseFirestore.instance.collection("bill").doc(id).delete();
  }
}