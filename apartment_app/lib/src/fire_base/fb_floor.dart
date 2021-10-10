import 'package:cloud_firestore/cloud_firestore.dart';

class FloorFB {
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("floor");
}