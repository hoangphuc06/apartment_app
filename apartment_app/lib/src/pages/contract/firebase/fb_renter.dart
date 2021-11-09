
import 'package:cloud_firestore/cloud_firestore.dart';

class RenterFB {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("renter");

  Future<void> add(
      String name,
      String phoneNumber,
      String CMND_CCCD,
      ) async {
    String id = (new DateTime.now().millisecondsSinceEpoch).toString();
    return FirebaseFirestore.instance
        .collection("renter")
        .doc(id)
        .set({
          "id": id,
          "name": name,
          "phoneNumber": phoneNumber,
          "CMND/CCCD": CMND_CCCD,       
        })
        .then((value) => print("completed"))
        .catchError((error) => print("fail"));
  }

  Future<void> update(
    String id,
    String name,
      String phoneNumber,
      String CMND_CCCD,
  ) async {
    return FirebaseFirestore.instance
        .collection("renter")
        .doc(id)
        .update({
          "name": name,
          "phoneNumber": phoneNumber,
          "CMND/CCCD": CMND_CCCD,    
        })
        .then((value) => print("completed"))
        .catchError((error) => print("fail"));
  }

}
