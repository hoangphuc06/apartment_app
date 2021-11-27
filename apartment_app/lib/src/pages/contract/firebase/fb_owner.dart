import 'package:cloud_firestore/cloud_firestore.dart';

class OwnerFB {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("owner");

  Future<void> add(
    String name,
    String birthday,
    String gender,
    String cmnd,
    String homeTown,
    String job,
    String phoneNumber,
    String email,
  ) async {
    String id = (new DateTime.now().millisecondsSinceEpoch).toString();

    return collectionReference
        .doc(id)
        .set({
          "id": id,
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

  Future<void> update(
      String id,
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
