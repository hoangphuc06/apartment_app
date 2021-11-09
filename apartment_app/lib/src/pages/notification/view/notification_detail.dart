import 'package:animated_float_action_button/animated_floating_action_button.dart';
import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/notification/model/notification_info.dart';
import 'package:apartment_app/src/pages/notification/firebase/fb_notification.dart';
import 'package:apartment_app/src/pages/service/view/add_service_page.dart';
import 'package:flutter/material.dart';
import 'add_notification.dart';
class NotificationDetail extends StatefulWidget {
  late NotificationInfo notify;
  NotificationDetail({Key? key,
    required this.notify}) : super(key: key);
  @override
  _NotificationDetailState createState() => _NotificationDetailState();
}

class _NotificationDetailState extends State<NotificationDetail> {
  final GlobalKey<AnimatedFloatingActionButtonState> fabKey = GlobalKey();
  NotificationFB fb = new NotificationFB();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: myGreen,
        elevation: 0,
        centerTitle: true,
        title:  Text(
          widget.notify.title.toString(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Card(
              elevation: 2,
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Text("Thông tin báo", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.wysiwyg , "Nội dung:", widget.notify.body.toString()),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.calendar_today, "Ngày", widget.notify.date.toString()),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
      floatingActionButton: AnimatedFloatingActionButton(
          key: fabKey,
          fabButtons: <Widget>[
            edit(),
            delete(),
          ],
          colorStartAnimation: myGreen,
          colorEndAnimation: myGreen,
          animatedIconData: AnimatedIcons.menu_close //To principal button
      ),
    );
  }

  _detailInfo(IconData icons, String title, String value) => Row(
    children: [
      Icon(icons),
      SizedBox(width: 5,),
      Text(title, style: TextStyle(fontSize: 15),),
      Spacer(),
      Text(value, style: TextStyle(fontSize: 15),),
    ],
  );



  Widget edit() {
    return FloatActionButtonText(
      onPressed: ()async{
        fabKey.currentState!.animate();

        dynamic Result=  await  Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotificationPage(info:this.widget.notify)));
        if(Result.runtimeType==NotificationInfo)
        {
          setState(() {
            this.widget.notify=Result;
          });
        }
      },
      icon: Icons.mode_edit,
      text: "Sửa",
      textLeft: -80,
    );
  }
  Widget delete() {
    return FloatActionButtonText(
      onPressed: (){
        fabKey.currentState!.animate();
        this.fb.delete(widget.notify.id.toString());
        Navigator.pop(context);
      },
      icon: Icons.delete,
      textLeft: -80,
      text: "Xóa",
    );
  }
}
