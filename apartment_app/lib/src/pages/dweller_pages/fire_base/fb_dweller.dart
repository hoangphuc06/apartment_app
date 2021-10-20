
import 'package:cloud_firestore/cloud_firestore.dart';

class DwellersFB {

  CollectionReference collectionReference = FirebaseFirestore.instance.collection("dweller");

  Future<void> add(String idApartment, String name, String birthday, String gender, String cmnd, String phoneNumber, String email) async {

    String id = (new DateTime.now().millisecondsSinceEpoch).toString();

    return collectionReference.doc(id).set({
      "id": id,
      "idApartment": idApartment,
      "name": name,
      "birthday": birthday,
      "gender": gender,
      "cmnd": cmnd,
      "phoneNumber": phoneNumber,
      "email": email,
    })
        .then((value) => print("completed"))
        .catchError((error)=>print("fail"));
  }

  Future<void> update(String id, String idApartment, String name, String birthday, String gender, String cmnd, String phoneNumber, String email) async {

    return collectionReference.doc(id).update({
      "id": id,
      "idApartment": idApartment,
      "name": name,
      "birthday": birthday,
      "gender": gender,
      "cmnd": cmnd,
      "phoneNumber": phoneNumber,
      "email": email,
    })
        .then((value) => print("completed"))
        .catchError((error)=>print("fail"));
  }
}