import 'package:cloud_firestore/cloud_firestore.dart';

class ContractFB {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("contract");

  Future<void> add(
      String host,
      String room,
      String startDay,
      String expirationDate,
      String billingStartDate,
      String roomPaymentPeriod,
      String roomCharge,
      String deposit,
      String renter,
      String rulesA,
      String rulesB,
      String rulesC,
      String type,
      bool liquidation,
      bool isVisible) async {
    String id = (new DateTime.now().millisecondsSinceEpoch).toString();
    return FirebaseFirestore.instance
        .collection("contract")
        .doc(id)
        .set({
          "id": id,
          "host": host,
          "room": room,
          "startDay": startDay,
          "expirationDate": expirationDate,
          "billingStartDate": billingStartDate,
          "roomPaymentPeriod": roomPaymentPeriod,
          "roomCharge": roomCharge,
          "deposit": deposit,
          "renter": renter,
          "rulesA": rulesA,
          "rulesB": rulesB,
          "rulesC": rulesC,
          "type": type,
          "liquidation": liquidation,
          "isVisible": isVisible
        })
        .then((value) => print("completed"))
        .catchError((error) => print("fail"));
  }

  Future<void> update(
    String id,
    String host,
    String room,
    String startDay,
    String expirationDate,
    String billingStartDate,
    String roomPaymentPeriod,
    String roomCharge,
    String deposit,
    String renter,
    String rulesA,
    String rulesB,
    String rulesC,
  ) async {
    return FirebaseFirestore.instance
        .collection("contract")
        .doc(id)
        .update({
          "host": host,
          "room": room,
          "startDay": startDay,
          "expirationDate": expirationDate,
          "billingStartDate": billingStartDate,
          "roomPaymentPeriod": roomPaymentPeriod,
          "roomCharge": roomCharge,
          "deposit": deposit,
          "renter": renter,
          "rulesA": rulesA,
          "rulesB": rulesB,
          "rulesC": rulesC,
        })
        .then((value) => print("completed"))
        .catchError((error) => print("fail"));
  }

  Future<void> delete(String id) async {
    return FirebaseFirestore.instance
        .collection("contract")
        .doc(id)
        .update({"isVisible": false})
        .then((value) => print("completed"))
        .catchError((error) => print("fail"));
  }
}
