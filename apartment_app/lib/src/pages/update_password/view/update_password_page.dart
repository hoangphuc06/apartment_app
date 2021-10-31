import 'package:apartment_app/src/blocs/auth_bloc.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/dialog/msg_dilog.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:apartment_app/src/widgets/title/title_info_not_null.dart';
import 'package:apartment_app/src/fire_base/fire_base_auth.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';

class UpdatePassWordPage extends StatefulWidget {
  const UpdatePassWordPage({Key? key}) : super(key: key);
  @override
  UpdatePassWordState createState() => UpdatePassWordState();
}

class UpdatePassWordState extends State<UpdatePassWordPage> {
  AuthBloc authBloc = new AuthBloc();
  final _formkey = GlobalKey<FormState>();
  static String ?email ;
  String? email2;
  TextEditingController curpass = new TextEditingController();
  TextEditingController newpass1 = new TextEditingController();
  TextEditingController newpass2 = new TextEditingController();
  void getMes  (String msg) {

    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: Text(msg))
    );
  }
  _passTextField() => TextFormField(
    style: MyStyle().style_text_tff(),
    controller: curpass,
    obscureText: true,
    decoration: InputDecoration(
      hintText: "Mật khẩu",
    ),
    keyboardType: TextInputType.name,
    validator: (val) {
      if (val!.isEmpty) {
        return "Vui lòng nhập mật khẩu";
      }
      if (val.length < 6) {
        return "Mật khẩu phải không nhỏ hơn 6 kí tự";
      }

      return null;
    },
  );
  _newTextField() => TextFormField(
    style: MyStyle().style_text_tff(),
    controller: newpass1,
    obscureText: true,
    decoration: InputDecoration(
      hintText: 'Mật khẩu Mới',
    ),
    keyboardType: TextInputType.name,
    validator: (val) {
      if (val!.isEmpty) {
        return "Vui lòng nhập mật khẩu";
      }
      if (val.length < 6) {
        return "Mật khẩu phải không nhỏ hơn 6 kí tự";
      }

      return null;
    },
  );
  _new2TextField() => TextFormField(
    style: MyStyle().style_text_tff(),
    controller: newpass2,
    obscureText: true,
    decoration: InputDecoration(
      hintText: 'Nhập lại mật khẩu',
    ),
    keyboardType: TextInputType.name,
    validator: (val) {
      if (val!=this.newpass2.text) {
        return "Mật khẩu khong chung";
      }
      return null;
    },
  );
  @override
  Widget build(BuildContext context) {

    print('########EMail${UpdatePassWordState.email}');

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Đổi Mật Khẩu '),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        child: Column(
          children: [
            TitleInfoNotNull(text: "Mật khẩu"),

            _passTextField(),
            SizedBox(height: 30,),
            TitleInfoNotNull(text: "Mật khẩu Mới"),

            _newTextField(),
            SizedBox(height: 30,),
            TitleInfoNotNull(text: "Nhập lại mật khẩu"),

            _new2TextField(),
            SizedBox(height: 30,),
            MainButton(name:' Xac nhan', onpressed: ()async{
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
                      this.curpass.text='';
                      this.newpass1.text='';
                      this.newpass2.text='';
                      MsgDialog.showMsgDialog(context, "Đã thay đổi mật khẩu",'');
                    }

                  },
                      (msg) {
                    MsgDialog.showMsgDialog(context, "Sai mật khẩu", '');
                    this.curpass.text='';
                    return;
                  });



            }),

       /*     RaisedButton(
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
            )*/

          ],
        ),
      ),
    );

  }
}
