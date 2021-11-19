import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/appbars/my_app_bar.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:apartment_app/src/widgets/title/title_info_not_null.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:apartment_app/src/pages/notification/firebase/fb_notification.dart';
import 'package:intl/intl.dart';
import '../model/notification_info.dart';

class AddNotificationPage extends StatefulWidget {
  NotificationInfo? info;

  AddNotificationPage({this.info, Key? key}) : super(key: key);

  @override
  _AddNotificationState createState() {
    _AddNotificationState temp = new _AddNotificationState();
    if (info != null) {
      temp.info = this.info!;
      temp.filltemplate();
    }

    return temp;
  }
}

class _AddNotificationState extends State<AddNotificationPage> {
  TextEditingController _TitleController = new TextEditingController();
  TextEditingController _NoteController = new TextEditingController();
  final _formkey = GlobalKey<FormState>();
  NotificationInfo info = new NotificationInfo();
  NotificationFB fb = new NotificationFB();

  void filltemplate() {
    this._TitleController.text = info.title.toString();
    this._NoteController.text = info.body.toString();
  }

  _bodyTextField() =>  Container(
      padding: MyStyle().padding_container_tff(),
      decoration: MyStyle().style_decoration_container(),
     child: TextFormField(
        minLines: 5,
        maxLines: 6,
        style: MyStyle().style_text_tff(),
        controller: this._NoteController,
        decoration: MyStyle().style_decoration_tff('Nội dung của thông báo'),

        keyboardType: TextInputType.name,
        validator: (val) {
          if (val!.isEmpty) {
            return "Nội dung không hợp lệ";
          }
          return null;
        },
      )
  );

  _titleTextField() => Container(
        padding: MyStyle().padding_container_tff(),
        decoration: MyStyle().style_decoration_container(),
        child: TextFormField(
          style: MyStyle().style_text_tff(),
          controller: this._TitleController,
          decoration:  MyStyle().style_decoration_tff('Tiêu đề'),
          keyboardType: TextInputType.name,
          validator: (val) {
            if (val!.isEmpty) {
              return "Tiêu đề không hợp lệ";
            }
            return null;
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar("Thông báo"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(18),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TitleInfoNotNull(text: "Tiêu đề"),
              _titleTextField(),
              SizedBox(
                height: 30,
              ),
              TitleInfoNotNull(text: "Nội dung"),
              _bodyTextField(),
              SizedBox(
                height: 30,
              ),
              MainButton(
                  name: 'Xác nhận',
                  onpressed: () {
                    this.info.body = this._NoteController.text;
                    this.info.title = this._TitleController.text;
                    if (_formkey.currentState!.validate()) {
                      //  Navigator.pop(context,this.info);
                      if (this.widget.info != null) {
                        DateTime tempDate = new DateFormat('dd-MM-yyyy hh:mm a')
                            .parse(this.widget.info!.date.toString());
                        this.fb.update(
                            this.widget.info!.id.toString(),
                            this._TitleController.text,
                            this._NoteController.text,
                            Timestamp.fromDate(tempDate));
                        Navigator.pop(context, this.info);
                      } else {
                        this.fb.add(
                            this._TitleController.text,
                            this._NoteController.text,
                            Timestamp.fromDate(DateTime.now()));
                        Navigator.pop(context, this.info);
                      }
                    }
                  }),
            ],
          ),
        ),
      ),
    );
    throw UnimplementedError();
  }
}
