import 'package:animated_float_action_button/animated_floating_action_button.dart';
import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/notification/model/notification_info.dart';
import 'package:apartment_app/src/pages/notification/firebase/fb_notification.dart';
import 'package:apartment_app/src/pages/service/view/add_service_page.dart';
import 'package:apartment_app/src/widgets/appbars/my_app_bar.dart';
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
  _detail(String name, String detail) => Container(
    padding: EdgeInsets.all(8),
    height: 50,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.blueGrey.withOpacity(0.2)
    ),
    child: Row(
      children: [
        Text(
          name,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
        ),
        Spacer(),
        Text(
          detail,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500
          ),
        ),
      ],
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar(widget.notify.title.toString(),),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Text("Thông tin báo", style: TextStyle( fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    _detail("Tên thông báo :", widget.notify.title.toString()),
                    SizedBox(height: 10,),
                    _detail("Nội dung:", widget.notify.body.toString()),
                    SizedBox(height: 10,),
                    _detail("Ngày", widget.notify.date.toString()),
                    SizedBox(height: 10,),
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

  _detailInfo(IconData icons, String title, String value) =>
      Container(
        decoration: BoxDecoration(
            color: Colors.blueGrey.withOpacity(0.2),
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 8),
        child:  Row(
          children: [
            Icon(icons),
            SizedBox(width: 5,),
            Text(title, style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
            Spacer(),
            Text(value, style: TextStyle(fontSize: 15),),
          ],
        ),

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
