import 'package:cloud_firestore/cloud_firestore.dart';


class OptionsManagerFB {

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference collectionReference = FirebaseFirestore.instance.collection("optionsmanager");

  Future<void> add(String icon, String title, String ontap) async {
    String id = (new DateTime.now().millisecondsSinceEpoch).toString();
    return FirebaseFirestore.instance.collection("optionsmanager").doc(id).set({
      "icon": icon,
      "title": title,
      "ontap": ontap,
    })
        .then((value) => print("completed"))
        .catchError((error)=>print("fail"));
  }

  Future<void> update(String id, String icon, String title, String ontap) async {
    return FirebaseFirestore.instance.collection("optionsmanager").doc(id).update({
      "icon": icon,
      "title": title,
      "ontap": ontap,
    })
        .then((value) => print("completed"))
        .catchError((error)=>print("fail"));
  }

  Future<void> delete(String id) async {
    return FirebaseFirestore.instance.collection("optionsmanager").doc(id).delete();
  }

}