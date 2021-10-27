import 'package:apartment_app/src/fire_base/fb_notification.dart';
import 'package:apartment_app/src/pages/notification_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    Route route = MaterialPageRoute(builder: (context) => NotificationDetailPage(info:  note,));
    NotificationInfo Result = await Navigator.push(this.context, route);
    if (Result != null) {
      this.fb.update(note.id.toString(), Result.title.toString(), Result.body.toString(), Timestamp.fromDate(DateTime.now()) , Result.icon.toString());

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
                    onPressed: ()async {
                      Navigator.pop(context);
                      await  this.modifi(note);

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
        appBar: AppBar(title: Text('Thông báo')),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Route route = MaterialPageRoute(
                builder: (context) => NotificationDetailPage());
            final Result = await Navigator.push(this.context, route);
              if(Result!=null){
                NotificationInfo temp= Result;
                this.fb.add(temp.title.toString(), temp.body.toString(), Timestamp.fromDate(DateTime.now()), temp.icon.toString());
              }
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
                        return notiCard( x['title'], x['body'], x['date'].toDate(), x['icon'],x['id']);
                      });
                }
              }),
        ));
  }

    Widget notiCard(String title, String body, DateTime time, String path,String id) {
    print(title);
    print(body);
    print(path);
  String timeformt=  DateFormat('yyyy-MM-dd – kk:mm').format(time);
    print(id);
    print('===============');
    if (path==null||path.isEmpty){
      path='assets/images/notification_icon/megaphone.png';
    }
    NotificationInfo temp= new NotificationInfo(id: id,icon:path,body: body,title:title);
    return GestureDetector(
      onLongPress: (){
        this.modifiService(temp);
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: ImageIcon(
                        new AssetImage(
                           path ),
                        size: 35),
                  ),
                  Text(title, style: TextStyle(fontSize: 25)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                body,
                style: TextStyle(fontSize: 23),
              ),
            ),
            Text(timeformt, style: TextStyle(fontSize: 18))
          ],
        ),
      ),
    );
  }
}
