import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:apartment_app/src/widgets/title/title_info_not_null.dart';
import 'package:flutter/material.dart';

import '../../add_icon_page.dart';
import '../model/notification_info.dart';

class NotificationDetailPage extends StatefulWidget {
  NotificationInfo? info;
   NotificationDetailPage({this.info,Key? key}) : super(key: key);

  @override
  _NotificationDetailState createState() {
    _NotificationDetailState temp= new _NotificationDetailState();
    if(info!=null) {
      temp.info = this.info!;
      temp.filltemplate();
    }
    return temp;
  }
}
class _NotificationDetailState extends State<NotificationDetailPage> {
  TextEditingController _TitleController= new TextEditingController();
  TextEditingController _NoteController= new TextEditingController();
  String pathAsset = 'assets/notification_icon/megaphone.png';
  final _formkey = GlobalKey<FormState>();
   NotificationInfo info= new NotificationInfo();
   void filltemplate(){
     this._TitleController.text=info.title.toString();
     this._NoteController.text= info.body.toString();
     pathAsset=info.icon.toString();

   }
  void getMes  (String msg) {

    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: Text(msg))
    );
  }
  bool check(){

     if (_TitleController.text.isEmpty) {
      getMes('Chưa thêm tiêu đề ');
      return false;
    } else if (_NoteController.text.isEmpty) {
      getMes('Chưa thêm nội dung');
      return false;
    }
    return true;
  }
  void setIcon() async {
    Route route = MaterialPageRoute(builder: (context) => IconList(path: 'assets/notification_icon/',));
    final Result = await Navigator.push(this.context, route);
    print(Result.toString());
    if(Result==null) return;
    setState(() {
      this.pathAsset = Result;
    });
  }

  _bodyTextField() => TextFormField(
    minLines: 5,
    maxLines: 6,
    style: MyStyle().style_text_tff(),
    controller:  this._NoteController,
    decoration: InputDecoration(
      hintText: 'Nội dung của thông báo',
      hintStyle: MyStyle().style_text_tff(),
    ),
    keyboardType: TextInputType.name,
    validator: (val) {
      if (val!.isEmpty) {
        return "Tiêu đề không hợp lệ";
      }
      return null;
    },
  );
  _titleTextField() => TextFormField(
    style: MyStyle().style_text_tff(),
    controller:  this._TitleController,
    decoration: InputDecoration(
      hintText: 'Tiêu đề',
    ),
    keyboardType: TextInputType.name,
    validator: (val) {
      if (val!.isEmpty) {
        return "Nội dung không hợp lệ";
      }
      return null;
    },
  );
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(title: Text('Thông báo'),),
        body: SingleChildScrollView(padding: EdgeInsets.all(18),

                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          TitleInfoNotNull(text: "Tiêu đề"),
                          _titleTextField(),
                          SizedBox(height: 30,),
                          TitleInfoNotNull(text: "Nội dung"),
                          _bodyTextField(),
                          SizedBox(height: 30,),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SizedBox(
                              height: 60,
                              child: RaisedButton(
                                color: Colors.grey.shade50,
                                onPressed: setIcon,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TitleInfoNotNull(text: 'Ảnh đại diện'),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                            onTap: setIcon,
                                            child:ImageIcon(new AssetImage(pathAsset),size:32)
                                        )

                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30,),
                          MainButton(name: 'Xác nhận', onpressed: () {

                            this.info.icon=this.pathAsset;
                            this.info.body= this._NoteController.text;
                            this.info.title=this._TitleController.text;

                            if(_formkey.currentState!.validate())
                            {
                              Navigator.pop(context,this.info);
                            }
                          }),
                          // RaisedButton(
                          //   onPressed:() {
                          //
                          //     this.info.icon=this.pathAsset;
                          //     this.info.body= this._NoteController.text;
                          //     this.info.title=this._TitleController.text;
                          //
                          //     if(this.check())
                          //     {
                          //       Navigator.pop(context,this.info);
                          //     }
                          //   },
                          //   padding: EdgeInsets.fromLTRB(0, 24, 0, 24),
                          //   color: Colors.green,
                          //   child: Text(
                          //     'Xac Nhan',
                          //     style: TextStyle(
                          //         fontSize: 22,
                          //         fontWeight: FontWeight.bold,
                          //         color: Colors.white),
                          //   ),
                          //   shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          // )

                        ],

                      ),
                    ),

        ),
    );
    throw UnimplementedError();
  }
}