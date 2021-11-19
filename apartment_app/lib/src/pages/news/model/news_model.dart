
import 'package:cloud_firestore/cloud_firestore.dart';

class News
{
  String? title;
  String? description;
  String? image;
  String? timestamp;

  News({
    this.title,
    this.description,
    this.image,
    this.timestamp
  });

  factory News.fromDocument(DocumentSnapshot doc) {
    return News(
      title: doc["title"],
      description: doc["description"],
      image: doc["image"],
      timestamp: doc["timestamp"],
    );
  }
}