
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel {
   String? name;
   //String? type;
   String?charge;
   String? detail;
   String? id;

   ServiceModel({
    this.id,
    this.name,
    this.charge,
    this.detail,

  });

  // Cần viết
  factory ServiceModel.fromDocument(DocumentSnapshot doc) {
    return ServiceModel(
      id: doc["id"],
      name: doc['name'],
      charge: doc['charge'],
      detail: doc['note'],
      /*type: doc['type'],*/
    );
  }
}