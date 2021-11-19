import 'package:apartment_app/src/pages/notification/model/notification_info.dart';
import 'package:apartment_app/src/widgets/buttons/roundedButton.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    Key? key,
    required this.notify,
   required this.func
  }) : super(key: key);

  final NotificationInfo notify;
//  final  DeletedFunc;
//  final  ModifyFunc;
  final func;
  @override
  Widget build(BuildContext context) {
    //String timeformt=  notify.date.toString();

    // NotificationInfo temp= new NotificationInfo(id: id,icon:path,body: body,title:title);
return GestureDetector(
  onTap: func,
  child: Container(
    decoration: BoxDecoration(
        color: Colors.blueGrey.withOpacity(0.2),
        borderRadius: BorderRadius.all(Radius.circular(10))
    ),
    padding: EdgeInsets.all(16),
    margin: EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Thông báo', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
              Spacer(),
              Text(notify.title.toString() , style: TextStyle(fontSize: 15),),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Icon(Icons.wysiwyg),
              SizedBox(width: 5,),
              Text("Nội dung", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold ),),
              Spacer(),
              Text(notify.body.toString() , style: TextStyle(fontSize: 15),),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Icon(Icons.calendar_today_rounded ),
              SizedBox(width: 5,),
              Text("Ngày:", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold ),),
              Spacer(),
              Text(notify.date.toString(), style: TextStyle(fontSize: 15),),
            ],
          ),
        ],
      ),
    ),
  );


  }
}
