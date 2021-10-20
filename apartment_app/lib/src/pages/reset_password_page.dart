import 'package:apartment_app/src/blocs/auth_bloc.dart';
import 'package:apartment_app/src/fire_base/fire_base_auth.dart';
import 'package:flutter/material.dart';

class ResetPassWord extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ResetPassWordState();

    throw UnimplementedError();
  }
}

class _ResetPassWordState extends State<ResetPassWord> {
  TextEditingController mail = new TextEditingController();
  FirAuth _firAuth = new FirAuth();
  late String msg;
  void sentMsg() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg,style: TextStyle(fontSize: 18),),
    ));
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Quen Mat Khau'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(17.0),
        child: Column(
          children: [
            Text(
                'Nhập email để lấy lại mật khẩu ,mail xác nhận thay đổi mật khẩu sẽ được gửi vào mail của bạn',
              style: TextStyle(fontSize: 23),),
           SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                style: TextStyle(fontSize: 20),
                controller: mail,
                decoration: InputDecoration(
                    icon: Icon(Icons.mail), hintText: 'Nhap Email'),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: double.infinity,
                height:50,
                child: RaisedButton(
                  onPressed: () async{
                    this.msg='';
                    if (this.mail.text.isEmpty) {

                      this.msg = 'Vui long nhập Email';
                      this.sentMsg();
                     return;
                    }
                    else if (!RegExp(
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                        .hasMatch(this.mail.text)) {
                      this.msg='Định dạng email không đúng';
                      this.sentMsg();
                     return;
                    } else {
                   await   this._firAuth.resetPassWord(this.mail.text);
                      this.msg='Đã gửi mail thay đổi mật ';
                      this.sentMsg();
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Xac Nhan',style: TextStyle(fontSize: 25,color: Colors.black87),),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  color: Colors.amber,
                ),
              ),
            )
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }
}
