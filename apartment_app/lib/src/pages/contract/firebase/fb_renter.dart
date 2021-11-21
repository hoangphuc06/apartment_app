import 'package:cloud_firestore/cloud_firestore.dart';

class RenterFB {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("renter");

  Future<void> add(
      String idApartment,
      String name,
      String birthday,
      String gender,
      String cmnd,
      String homeTown,
      String job,
      String phoneNumber,
      String email,
      bool expired) async {
    String id = (new DateTime.now().millisecondsSinceEpoch).toString();

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
          "expired": expired,
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
      String email) async {
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
