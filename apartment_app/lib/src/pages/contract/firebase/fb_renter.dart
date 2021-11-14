
import 'package:cloud_firestore/cloud_firestore.dart';

class RenterFB {

  CollectionReference collectionReference = FirebaseFirestore.instance.collection("renter");

  Future<void> add(String idRenter,String name,String gender,String phoneNumber) async {

    String id = (new DateTime.now().millisecondsSinceEpoch).toString();

    return collectionReference.doc(id).set({
      "id": id,
      "idRenter": idRenter,
      "name":name,
      "gender":gender,
      "phoneNumber":phoneNumber,
      
    })
        .then((value) => print("completed"))
        .catchError((error)=>print("fail"));
  }

  

}