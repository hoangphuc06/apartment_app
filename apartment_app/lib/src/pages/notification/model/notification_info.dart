import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
class NotificationInfo{
   String ?id;
   String? title;
   String? body;
   String? date;
  NotificationInfo({this.id,this.title, this.body,this.date});

   factory NotificationInfo.fromDocument(DocumentSnapshot doc) {
     String temp= DateFormat('dd-MM-yyyy hh:mm a').format( doc['date'].toDate());
     return NotificationInfo(
       id: doc["id"],
       title: doc['title'],
       body: doc['body'],
       date: temp,

     );
   }
}


