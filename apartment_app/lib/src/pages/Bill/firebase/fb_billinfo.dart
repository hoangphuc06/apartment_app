import 'package:cloud_firestore/cloud_firestore.dart';

class BillInfoFB {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("billinfo");

  Future<void> add(
      String idRoom,
      String billDate,
      String deposit,
      String discount,
      String fine,
      String note,
      String roomCharge,
      String serviceFee,
      String status,
      String total,
      String startBill,
      String endBill) async {
    String id = (new DateTime.now().microsecondsSinceEpoch).toString();
    return FirebaseFirestore.instance
        .collection("billinfo")
        .doc(id)
        .set({
          "idBillInfo": id,
          "idRoom": idRoom,
          "billDate": billDate,
          "deposit": deposit,
          "discount": discount,
          "fine": fine,
          "note": note,
          "roomCharge": roomCharge,
          "serviceFee": serviceFee,
          "status": status,
          "total": total,
          "startBill": startBill,
          "endBill": endBill,
        })
        .then((value) => print("completed"))
        .catchError((error) => print("fail"));
  }

  // Future<void> update(String id,String roomid,String billinfodate,String status) async{
  //   return FirebaseFirestore.instance.collection("billinfoinfo").doc(id).update({
  //     "billinfoid" : id,
  //     "billinfodate" : billinfodate,
  //     "roomid" : roomid,
  //     "status" : status,
  //   }
  //   ).then((value) => print("completed"))
  //       .catchError((error)=>print("fail"));
  // }
  Future<void> delete(String id) async {
    return FirebaseFirestore.instance.collection("billinfo").doc(id).delete();
  }
}
