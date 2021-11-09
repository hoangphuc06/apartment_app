import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/notification/firebase/fb_notification.dart';
import 'package:apartment_app/src/pages/notification/model/notification_info.dart';
import 'package:apartment_app/src/widgets/buttons/roundedButton.dart';
import 'package:apartment_app/src/widgets/cards/notification_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'add_notification.dart';
import 'notification_detail.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<NotificationPage> {
  NotificationFB fb = new NotificationFB();
  void delete(NotificationInfo note) {
    this.fb.delete(note.id.toString());
    setState(() {});
  }
  Future<void> modifi(NotificationInfo note) async {
    Route route = MaterialPageRoute(
        builder: (context) => NotificationDetail(notify: note,));
    NotificationInfo Result = await Navigator.push(this.context, route);
    DateTime tempDate = new DateFormat('dd-MM-yyyy hh:mm a').parse(
        note.date.toString());
    if (Result != null) {
      this.fb.update(
          note.id.toString(), Result.title.toString(), Result.body.toString(),
          Timestamp.fromDate(tempDate));
    }
    setState(() {});
  }

  void modifiService(NotificationInfo note) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        builder: (BuildContext conText) {
          return Container(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  RaisedButton(
                    onPressed: () {
                      this.delete(note);
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text('Xoa'),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      await this.modifi(note);
                    },
                    child: Center(
                      child: Text('Thay doi'),

                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: myGreen,
          elevation: 0,
          centerTitle: true,
          title:  Text(
            "Thông báo",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Route route = MaterialPageRoute(
                builder: (context) => AddNotificationPage());
            await Navigator.push(this.context, route);
            // if (Result != null) {
            //   NotificationInfo temp = Result;
            //   this.fb.add(temp.title.toString(), temp.body.toString(),
            //       Timestamp.fromDate(DateTime.now()));
            // }
            setState(() {
            });
          },
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: StreamBuilder(
              stream: fb.collectionReference.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Text("No Data"),
                  );
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, i) {
                        QueryDocumentSnapshot x = snapshot.data!.docs[i];
                        String date = DateFormat('dd-MM-yyyy hh:mm a').format(
                            x['date'].toDate());
                        //    NotificationInfo temp= new NotificationInfo(id: x['id'],icon:x['icon'],body: x['body'],title: x['title'],date: date);
                        //   return notificationCard( x['title'], x['body'], x['date'].toDate(), x['icon'],x['id']);
                        NotificationInfo temp = NotificationInfo.fromDocument(
                            x);
                        return NotificationCard(notify: temp,
                            func: () async {
                              await this.modifi(temp);
                            }
                        );
                      });
                }
              }),
        ));
  }
}