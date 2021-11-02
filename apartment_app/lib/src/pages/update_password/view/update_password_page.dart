import 'package:apartment_app/src/blocs/auth_bloc.dart';
import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/dialog/loading_dialog.dart';
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

  Future <void >changePassWord() async{
    if(_formkey.currentState!.validate()) {
      LoadingDialog.showLoadingDialog(context, "Loading...");
      authBloc.signIn(
          UpdatePassWordState.email.toString(),
          this.curpass.text,
          () {
            if (this.authBloc.updatePassWord(this.newpass2.text)) {
              LoadingDialog.hideLoadingDialog(context);
              MsgDialog.showMsgDialog(
                  context, "Đã thay đổi mật khẩu", '');
            }
          },
          (msg) {
            LoadingDialog.hideLoadingDialog(context);
            MsgDialog.showMsgDialog(context, "Sai mật khẩu", '');
            return;
          });
    }



  }

  _passTextField() => TextFormField(
    style: MyStyle().style_text_tff(),
    controller: curpass,

    obscureText: true,
    decoration: InputDecoration(
      hintText: "Nhập mật khẩu hiện tại",
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
      hintText: 'Nhập mật khẩu mới',
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
      hintText: 'Nhập lại mật khẩu mới',
    ),
    keyboardType: TextInputType.name,
    validator: (val) {
      if (val!.isEmpty) {
        return "Vui lòng nhập mật khẩu";
      }
      if (this.newpass1.text!=this.newpass2.text) {
        return "Mật khẩu mới không trùng khớp";
      }
      return null;
    },
  );

  @override
  Widget build(BuildContext context) {

    print('########EMail${UpdatePassWordState.email}');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: myGreen,
        elevation: 0,
        centerTitle: true,
        title:  Text(
          "Đổi mật khẩu",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
      ),
      backgroundColor: Colors.white.withOpacity(0.9),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Card(
                elevation: 2,
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),

                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                image: AssetImage('assets/images/update_pass.jpg')
                            )
                        ),
                      ),

                      //Tiêu đề
                      SizedBox(height: 20,),
                      Text(
                        "Vui lòng cung cấp chính xác mật khẩu hiện tại và mật khẩu mới của bạn để chúng tôi hỗ trợ một cách tốt nhất!",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                      ),

                      SizedBox(height: 20,),
                      TitleInfoNotNull(text: "Mật khẩu hiện tại"),
                      _passTextField(),

                      SizedBox(height: 20,),
                      TitleInfoNotNull(text: "Mật khẩu mới"),
                      _newTextField(),

                      SizedBox(height: 20,),
                      TitleInfoNotNull(text: "Nhập lại mật khẩu mới"),
                      _new2TextField(),

                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
              // Nút bấm
              SizedBox(height: 10,),
              MainButton(name:' Xác nhận', onpressed:() async {await this.changePassWord();}),
              SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );

  }
}
