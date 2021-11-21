import 'package:cloud_firestore/cloud_firestore.dart';

class DwellersFB {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("dweller");

  Future<void> add(
      String id,
      String idApartment,
      String name,
      String birthday,
      String gender,
      String cmnd,
      String homeTown,
      String job,
      String phoneNumber,
      String email,
      String note) async {
    return collectionReference
        .doc(id)
        .set({
          "id": id,
          "idApartment": idApartment,
          "name": name,
          "birthday": birthday,
          "gender": gender,
          "cmnd": cmnd,
          "homeTown": homeTown,
          "job": job,
          "phoneNumber": phoneNumber,
          "email": email,
          "note": note
        })
        .then((value) => print("completed"))
        .catchError((error) => print("fail"));
  }

  Future<void> update(
      String id,
      String idApartment,
      String name,
      String birthday,
      String gender,
      String cmnd,
      String homeTown,
      String job,
      String phoneNumber,
      String email,
      String note) async {
    return collectionReference
        .doc(id)
        .update({
          "id": id,
          "idApartment": idApartment,
          "name": name,
          "birthday": birthday,
          "gender": gender,
          "cmnd": cmnd,
          "homeTown": homeTown,
          "job": job,
          "phoneNumber": phoneNumber,
          "email": email,
          "note": note
        })
        .then((value) => print("completed"))
        .catchError((error) => print("fail"));
  }

  Future<void> updateIdApartment(String id, String idApartment) async {
    return collectionReference
        .doc(id)
        .update({
          "idApartment": idApartment,
        })
        .then((value) => print("completed"))
        .catchError((error) => print("fail"));
  }
}
