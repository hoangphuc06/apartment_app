import 'package:apartment_app/src/model/categoty_apartment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class CategoryApartmentFB {

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference collectionReference = FirebaseFirestore.instance.collection("category_apartment");

  Future<void> add(String name, String area) async {
    String id = (new DateTime.now().millisecondsSinceEpoch).toString();
    return FirebaseFirestore.instance.collection("category_apartment").doc(id).set({
      "id": id,
      "name": name,
      "area": area,
    })
        .then((value) => print("completed"))
        .catchError((error)=>print("fail"));
  }

  Future<void> update(String id, String name, String area) async {
    return FirebaseFirestore.instance.collection("category_apartment").doc(id).update({
      "name": name,
      "area": area,
    })
        .then((value) => print("completed"))
        .catchError((error)=>print("fail"));
  }

  Future<void> delete(String id) async {
    return FirebaseFirestore.instance.collection("category_apartment").doc(id).delete();
  }

}