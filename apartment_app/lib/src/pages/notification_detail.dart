import 'package:flutter/material.dart';

import 'add_icon_page.dart';
import 'notification_info.dart';

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
  String pathAsset = 'assets/images/notification_icon/megaphone.png';
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
    Route route = MaterialPageRoute(builder: (context) => IconList(path: 'assets/images/notification_icon/',));
    final Result = await Navigator.push(this.context, route);
    print(Result.toString());
    if(Result==null) return;
    setState(() {
      this.pathAsset = Result;
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(title: Text('Thong bao'),),
        body: Padding(padding: EdgeInsets.all(18),
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                          child: Text(
                            'Tieu de',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        TextField(
                          controller: this._TitleController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                          decoration: InputDecoration(
                            hintText: 'Tieu de',
                            hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                          child: Text(
                            'Noi dung',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        TextField(
                          minLines: 6,
                          maxLines: 8,
                          controller: this._NoteController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                          decoration: InputDecoration(
                            hintText: 'Noi dung',
                            hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SizedBox(
                            height: 60,
                            child: RaisedButton(
                              color: Colors.grey.shade50,
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Text(
                                    'Anh dai dien',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                          onTap: setIcon,
                                          child:ImageIcon(new AssetImage(pathAsset),size:35)
                                      )

                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        RaisedButton(
                          onPressed:() {

                            this.info.icon=this.pathAsset;
                            this.info.body= this._NoteController.text;
                            this.info.title=this._TitleController.text;

                            if(this.check())
                            {
                              Navigator.pop(context,this.info);
                            }
                          },
                          padding: EdgeInsets.fromLTRB(0, 24, 0, 24),
                          color: Colors.green,
                          child: Text(
                            'Xac Nhan',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        )
                      ],

                    ),

        ),
    );
    throw UnimplementedError();
  }
}