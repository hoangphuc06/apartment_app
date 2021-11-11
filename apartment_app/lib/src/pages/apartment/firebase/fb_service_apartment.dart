import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceApartmentFB {
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("service_apartment");
  FirebaseFirestore firestore = FirebaseFirestore.instance;
}