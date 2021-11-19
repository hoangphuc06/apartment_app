import 'package:cloud_firestore/cloud_firestore.dart';

class NewsFB
{
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("news");
}