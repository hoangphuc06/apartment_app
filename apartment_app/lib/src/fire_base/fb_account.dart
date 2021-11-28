import 'package:cloud_firestore/cloud_firestore.dart';

class AccountFB{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("account");

  Future<void> add(String id,String uid,String email) async {
    return FirebaseFirestore.instance.collection("account").doc(uid).set({
      "idUser" : id,
      "uid" : uid,
      "email" : email
    }
    ).then((value) => print("completed"))
        .catchError((error)=>print("fail"));
  }
  // Future<void> update(String id,String floorid,String name,String categoryid,String numDweller,String status, String note) async{
  //   return FirebaseFirestore.instance.collection("floorinfo").doc(id).update({
  //     "name" : name,
  //     "floorid" : floorid,
  //     "categoryid" : categoryid,
  //     "numOfDweller" : numDweller,
  //     "status" : status,
  //     "note" : note,
  //   }
  //   ).then((value) => print("completed"))
  //       .catchError((error)=>print("fail"));
  // }
}