import 'package:cloud_firestore/cloud_firestore.dart';

class NewsFB
{
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("news");
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> add(String URL,String description, String title) async {
    String id = (new DateTime.now().millisecondsSinceEpoch).toString();
    return FirebaseFirestore.instance.collection("news").doc(id).set({
      "timestamp": id,
      "image": URL,
      "description": description,
      "title": title,
    })
        .then((value) => print("completed"))
        .catchError((error)=>print("fail"));
  }
  Future<void> edit(String id,String URL,String description, String title) async {
    return FirebaseFirestore.instance.collection("news").doc(id).update({
      "image": URL,
      "description": description,
      "title": title,
    })
        .then((value) => print("completed"))
        .catchError((error)=>print("fail"));
  }
}