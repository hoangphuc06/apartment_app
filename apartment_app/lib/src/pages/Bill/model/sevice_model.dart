import 'package:cloud_firestore/cloud_firestore.dart';

class Sevice {
  String? id;
  String? name;
  String? charge;

  Sevice({
    this.id,
    this.name,
    this.charge,
  });

  factory Sevice.fromDocument(DocumentSnapshot doc) {
    return Sevice(
      id: doc["id"],
      name: doc['name'],
      charge: doc['area'],
    );
  }

}