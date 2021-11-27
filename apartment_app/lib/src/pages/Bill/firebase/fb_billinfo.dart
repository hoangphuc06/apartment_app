import 'package:cloud_firestore/cloud_firestore.dart';

class BillInfoFB {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("billinfo");

  Future<void> add(
      String id,
      String idRoom,
      String billDate,
      String monthBill,
      String yearBill,
      String paymentTerm,
      String deposit,
      String discount,
      String fine,
      String note,
      String roomCharge,
      String serviceFee,
      String status,
      String startE,
      String endE,
      String chargeE,
      String totalE,
      String startW,
      String endW,
      String chargeW,
      String totalW,
      String total,
      String startBill,
      String endBill,
      String idContract) async {
    return FirebaseFirestore.instance
        .collection("billinfo")
        .doc(id)
        .set({
          "idBillInfo": id,
          "idRoom": idRoom,
          "billDate": billDate,
          "monthBill": monthBill,
          "yearBill": yearBill,
          "paymentTerm": paymentTerm,
          "deposit": deposit,
          "discount": discount,
          "fine": fine,
          "note": note,
          "roomCharge": roomCharge,
          "serviceFee": serviceFee,
          "status": status,
          "startE": startE,
          'endE': endE,
          'chargeE': chargeE,
          'totalE': totalE,
          'startW': startW,
          'endW': endW,
          'chargeW': chargeW,
          'totalW': totalW,
          "total": total,
          "startBill": startBill,
          "endBill": endBill,
          "idContract": idContract,
        })
        .then((value) => print("completed"))
        .catchError((error) => print("fail"));
  }

  Future<void> updateStatus(String id, String status) async {
    return FirebaseFirestore.instance
        .collection("billinfo")
        .doc(id)
        .update({
          "status": status,
        })
        .then((value) => print("completed"))
        .catchError((error) => print("fail"));
  }

   Future<void> updateDeposit(String id, String deposit, String total) async {
    return FirebaseFirestore.instance
        .collection("billinfo")
        .doc(id)
        .update({
          "deposit": deposit,
          "total":total,
        })
        .then((value) => print("completed"))
        .catchError((error) => print("fail"));
  }

  Future<void> delete(String id) async {
    return FirebaseFirestore.instance.collection("billinfo").doc(id).delete();
  }
}
