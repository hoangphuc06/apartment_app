import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class BillServiceFB {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("bill_service");

  Future<void> add(String id,String idBillinfo, String idService) async {
    return FirebaseFirestore.instance
        .collection("bill_service")
        .doc(id)
        .set({
          'id':id,
          "idBillinfo": idBillinfo,
          "idService": idService,
        })
        .then((value) => print("completed"))
        .catchError((error) => print("fail"));
  }

  Future<void> delete(String id) async {
    return FirebaseFirestore.instance
        .collection("bill_service")
        .doc(id)
        .delete();
  }
}
