
import 'package:cloud_firestore/cloud_firestore.dart';

class RentedRoomFB {

  CollectionReference collectionReference = FirebaseFirestore.instance.collection("rentedRoom");

  Future<void> add(String idRenter, String idRoom) async {

    String id = (new DateTime.now().millisecondsSinceEpoch).toString();

    return collectionReference.doc(id).set({
      "id": id,
      "idRenter": idRenter,
      "idRoom": idRoom,
    })
        .then((value) => print("completed"))
        .catchError((error)=>print("fail"));
  }

  Future<void> update(String id, String idRenter, String idRoom) async {

    return collectionReference.doc(id).update({
      "idRenter": idRenter,
      "idRoom": idRoom,
    })
        .then((value) => print("completed"))
        .catchError((error)=>print("fail"));
  }

  

}