
import 'package:cloud_firestore/cloud_firestore.dart';

class Fix {
  String? title;
  String? detail;
  String? timestamp;
  String? image;
  String? idRoom;
  String? status;

  Fix({this.title, this.detail, this.timestamp, this.image,this.idRoom,this.status});

  factory Fix.fromDocument(DocumentSnapshot doc) {
    return Fix(
        title: doc["title"],
        detail: doc["detail"],
        timestamp: doc["timestamp"],
        image: doc["image"],
        idRoom: doc["idRoom"],
        status: doc["status"]
    );
  }
}