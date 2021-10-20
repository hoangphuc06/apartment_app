import 'package:apartment_app/src/model/categoty_apartment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ContractFB {

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference collectionReference = FirebaseFirestore.instance.collection("contract");

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
    String rules
    ) 
    async {
    String id = (new DateTime.now().millisecondsSinceEpoch).toString();
    return FirebaseFirestore.instance.collection("contract").doc(id).set({
      "id": id,
      "host": host,
      "room": room,
      "startDay": startDay,
      "expirationDate": expirationDate,
      "billingStartDate": billingStartDate,
      "roomPaymentPeriod": roomPaymentPeriod,
      "roomCharge" :roomCharge,
      "deposit": deposit,
      "renter": renter,
      "rules": rules,
    })
        .then((value) => print("completed"))
        .catchError((error)=>print("fail"));
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
    String rules,
  ) async {
    return FirebaseFirestore.instance.collection("contract").doc(id).update({
      "host": host,
      "room": room,
      "startDay": startDay,
      "expirationDate": expirationDate,
      "billingStartDate": billingStartDate,
      "roomPaymentPeriod": roomPaymentPeriod,
      "roomCharge" :roomCharge,
      "deposit": deposit,
      "renter": renter,
      "rules": rules,
    })
        .then((value) => print("completed"))
        .catchError((error)=>print("fail"));
  }

  Future<void> delete(String id) async {
    return FirebaseFirestore.instance.collection("contract").doc(id).delete();
  }

}