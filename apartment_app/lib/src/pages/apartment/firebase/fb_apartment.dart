import 'package:cloud_firestore/cloud_firestore.dart';

class ApartmentFB {
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("apartment");
}