import 'package:apartment_app/src/pages/notification/firebase/fb_notification.dart';
import 'package:apartment_app/src/pages/notification/model/notification_info.dart';
import 'package:apartment_app/src/widgets/buttons/roundedButton.dart';
import 'package:apartment_app/src/widgets/cards/notification_card.dart';
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
    DateTime tempDate = new DateFormat('dd-MM-yyyy hh:mm a').parse(note.date.toString());
    if (Result != null) {
      this.fb.update(note.id.toString(), Result.title.toString(), Result.body.toString(), Timestamp.fromDate(tempDate) , Result.icon.toString());

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
                        String date= DateFormat('dd-MM-yyyy hh:mm a').format( x['date'].toDate());
                        NotificationInfo temp= new NotificationInfo(id: x['id'],icon:x['icon'],body: x['body'],title: x['title'],date: date);
                     //   return notificationCard( x['title'], x['body'], x['date'].toDate(), x['icon'],x['id']);
                        return NotificationCard(temp: temp,
                            ModifyFunc: ()async{await  this.modifi(temp);},
                            DeletedFunc: (){this.delete(temp);
                        });
                      });
                }
              }),
        ));
  }
    // Widget notificationCard(String title, String body, DateTime time, String path,String id){
    //   String timeformt=  DateFormat('dd-MM-yyyy hh:mm a').format(time);
    //   if (path==null||path.isEmpty){
    //     path='assets/images/notification_icon/megaphone.png';
    //   }
    //   NotificationInfo temp= new NotificationInfo(id: id,icon:path,body: body,title:title);
    //
    //   return Padding(
    //     padding: const EdgeInsets.all(5.0),
    //     child: Card(
    //      shape:  RoundedRectangleBorder(
    //        borderRadius: BorderRadius.circular(20.0),
    //      ),
    //       //color:Color.fromARGB(255,251, 248, 235),
    //       child: Column(
    //         children: [
    //           Row(
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.all(10),
    //                 child: Container(
    //                   width: 80,
    //                   height: 80,
    //                   padding: EdgeInsets.all(10),
    //                   decoration: BoxDecoration(
    //                  //   color:Colors.grey.shade50 ,
    //                     shape: BoxShape.circle
    //                   ),
    //                   child: ImageIcon(new AssetImage(path ),
    //                    //   color: Colors.green.shade900
    //                      ),
    //                 ),
    //               ),
    //               SizedBox(width: 10),
    //               Column(
    //                // mainAxisAlignment: MainAxisAlignment.start,
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Padding(
    //                     padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
    //                     child: Container(
    //
    //                         decoration:BoxDecoration(
    //                           borderRadius: BorderRadius.circular(3.0),
    //                         ) ,
    //                         child: Text('Thong bao:', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold ,color:Color.fromRGBO(37, 129, 57, 1.0)))),
    //                   ),
    //                   Text(title, style: TextStyle(fontSize: 17)),
    //                 ],
    //               )
    //             ],
    //           ),
    //
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.end,
    //             children: [
    //               RoundedButton(name: 'chi tiet',color: Colors.green, onpressed: ()async{
    //                 await this.modifi(temp);
    //               },),
    //               SizedBox(width: 10,),
    //               RoundedButton(name: 'Xoa',color: Colors.red, onpressed: (){delete(temp);},),
    //               SizedBox(width: 30,),
    //             ],
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.all(6.0),
    //             child: Text(timeformt, style: TextStyle(fontSize: 14,color: Colors.grey)),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    //
    // }
  //   Widget notiCard(String title, String body, DateTime time, String path,String id) {
  //   print(title);
  //   print(body);
  //   print(path);
  // String timeformt=  DateFormat('dd-MM-yyyy hh:mm a').format(time);
  //   print(id);
  //   print('===============');
  //   if (path==null||path.isEmpty){
  //     path='assets/images/notification_icon/megaphone.png';
  //   }
  //   NotificationInfo temp= new NotificationInfo(id: id,icon:path,body: body,title:title);
  //   return GestureDetector(
  //     onLongPress: (){
  //       this.modifiService(temp);
  //     },
  //     child: Card(
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Row(
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
  //                   child: ImageIcon(
  //                       new AssetImage(
  //                          path ),
  //                       size: 25),
  //                 ),
  //                 Text(title, style: TextStyle(fontSize: 16)),
  //               ],
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Text(body, style: TextStyle(fontSize: 18),
  //             ),
  //           ),
  //           SizedBox(height: 10,),
  //           Text(timeformt, style: TextStyle(fontSize: 14))
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
