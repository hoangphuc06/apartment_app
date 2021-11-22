import 'package:cloud_firestore/cloud_firestore.dart';

class RentedRoomFB {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("rentedRoom");

  Future<void> add(
    String idRenter,
    String idRoom,
    bool expired,
  ) async {
    String id = (new DateTime.now().millisecondsSinceEpoch).toString();
    return FirebaseFirestore.instance
        .collection("rentedRoom")
        .doc(id)
        .set({
          "id": id,
          "idRenter": idRenter,
          "idRoom": idRoom,
          "expired": expired,
        })
        .then((value) => print("completed"))
        .catchError((error) => print("fail"));
  }

  Future<void> update(
    String id,
    String idRenter,
    String idRoom,
    bool expired,
  ) async {
    return FirebaseFirestore.instance
        .collection("rentedRoom")
        .doc(id)
        .update({
          "idRenter": idRenter,
          "idRoom": idRoom,
          "expired": expired,
        })
        .then((value) => print("completed"))
        .catchError((error) => print("fail"));
  }

  Future<void> updateIdRenter(
    String id,
    String idRenter,
  ) async {
    return FirebaseFirestore.instance
        .collection("rentedRoom")
        .doc(id)
        .update({
          "idRenter": idRenter,
        })
        .then((value) => print("completed"))
        .catchError((error) => print("fail"));
  }

  Future<void> updateIdRoom(
    String id,
    String idRoom,
  ) async {
    return FirebaseFirestore.instance
        .collection("rentedRoom")
        .doc(id)
        .update({
          "idRoom": idRoom,
        })
        .then((value) => print("completed"))
        .catchError((error) => print("fail"));
  }

  Future<void> liquidation(
    String id,
  ) async {
    return FirebaseFirestore.instance
        .collection("rentedRoom")
        .doc(id)
        .update({"expired": true})
        .then((value) => print("completed"))
        .catchError((error) => print("fail"));
  }
}
