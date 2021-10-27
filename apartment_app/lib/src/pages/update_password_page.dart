import 'package:apartment_app/src/blocs/auth_bloc.dart';
import 'package:apartment_app/src/widgets/dialog/msg_dilog.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:apartment_app/src/fire_base/fire_base_auth.dart';

class UpdatePassWordPage extends StatefulWidget {
  const UpdatePassWordPage({Key? key}) : super(key: key);
  @override
  UpdatePassWordState createState() => UpdatePassWordState();
}

class UpdatePassWordState extends State<UpdatePassWordPage> {
  AuthBloc authBloc = new AuthBloc();
  static String ?email ;
  String? email2;
  TextEditingController curpass = new TextEditingController();
  TextEditingController newpass1 = new TextEditingController();
  TextEditingController newpass2 = new TextEditingController();
  void getMes  (String msg) {

    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: Text(msg))
    );
  }
  @override
  Widget build(BuildContext context) {

    print('########EMail${UpdatePassWordState.email}');

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Đổi Mật Khẩu '),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
              child: Text(
                'Mật khẩu',
                style: TextStyle(fontSize: 18),
              ),
            ),


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Vui lòng nhập mật khẩu";
                    }
                    if (val.length < 6) {
                      return "Mật khẩu phải không nhỏ hơn 6 kí tự";
                    }

                    return null;
                  },
                controller: this.curpass,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 20, color: Colors.grey),
                  obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Mật khẩu',

                  hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 20),
                ),
            ),
              ),
           Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
              child: Text(
                'Mật khẩu Mới',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Vui lòng nhập mật khẩu";
                  }
                  if (val.length < 6) {
                    return "Mật khẩu phải không nhỏ hơn 6 kí tự";
                  }
                  return null;
                },
                obscureText: true,
                controller: this.newpass1,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 20, color: Colors.grey),
                decoration: InputDecoration(
                  hintText: 'Mật khẩu Mới',
                  hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
              child: Text(
                'Nhập lại mật khẩu',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (val) {

                  if (val!=this.newpass2.text) {
                    return "Mật khẩu khong chung";
                  }
                  return null;
                },
                controller: this.newpass2,
                obscureText: true,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 20, color: Colors.grey),
                decoration: InputDecoration(
                  hintText: 'Nhập lại mật khẩu',
                  hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 20),
                ),
              ),
            ),
            RaisedButton(
              onPressed:() async {
                if(this.newpass1.text.isEmpty||this.newpass1.text.length<6){
                  this.newpass1.text='';
                  MsgDialog.showMsgDialog(context, "Mật khẩu mới không hợp lệ ",'');
                  return;
                }

                if(this.newpass2.text!=this.newpass1.text){
                  MsgDialog.showMsgDialog(context, "Mật khẩu khong chung ",'');
                  this.newpass2.text='';
                  return;
                }

                authBloc.signIn(
                    UpdatePassWordState.email.toString(),
                    this.curpass.text,
                        () {
                      if(this.authBloc.updatePassWord(this.newpass2.text)) {

                        MsgDialog.showMsgDialog(context, "Đã thay đổi mật khẩu",'');
                      }

                    },
                        (msg) {
                      MsgDialog.showMsgDialog(context, "Sai mật khẩu", '');
                      this.curpass.text='';
                      return;
                    });



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

  }
}
