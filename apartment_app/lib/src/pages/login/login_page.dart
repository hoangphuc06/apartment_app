import 'dart:ui';

import 'package:apartment_app/src/blocs/auth_bloc.dart';
import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/fire_base/fire_base_auth.dart';

import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/pages/update_password/update_password_page.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:apartment_app/src/widgets/dialog/loading_dialog.dart';
import 'package:apartment_app/src/widgets/dialog/msg_dilog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  AuthBloc authBloc = new AuthBloc();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/welcome.png')
                )
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
              child: Container(
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ),
          Form(
            key: _formkey,
            child: Container(
              margin: EdgeInsets.only(left: 40, right: 40),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Xin ch??o!",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 40.0
                      ),
                    ),
                    Text(
                      "Vui l??ng ????ng nh???p ????? ti???p t???c",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 15.0
                      ),
                    ),

                    SizedBox(height: 30,),
                    _title(Icons.email, "Email"),
                    _emailTextField(),

                    SizedBox(height: 30,),
                    _title(Icons.lock, "M???t kh???u"),
                    _passwordTextField(),

                    SizedBox(height: 30,),
                    MainButton(
                      name: "????ng nh???p",
                      onpressed: _onLoginClick,
                    ),

                    SizedBox(height: 30,),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, "reset_password_page");
                      },
                      child: Text(
                        "Qu??n m???t kh???u?",
                        style: MyStyle().style_text_lg_hint(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buttonLogin() => FlatButton(
    onPressed: () {  },
    child: Container(

    ),
  );

  void _onLoginClick() {
    String email = _emailController.text;
    String pass = _passController.text;

    if(_formkey.currentState!.validate()) {
      LoadingDialog.showLoadingDialog(context, "Loading...");

      if (email!="ad.apartment.m12@gmail.com"){
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, "????ng nh???p th???t b???i", "Vui l??ng s??? d???ng ????ng t??i kho???n qu???n l??!");
        return;
      }

      authBloc.signIn(
          email,
          pass,
          () {
            UpdatePassWordState.email=email;
                LoadingDialog.hideLoadingDialog(context);
                Navigator.pushReplacementNamed(context, "tab_page");
            },
          (msg) {
                    LoadingDialog.hideLoadingDialog(context);
                    MsgDialog.showMsgDialog(context, "????ng nh???p th???t b???i", msg);
              });
    }


    //var auth = AuthBloc();

  }

  _emailTextField() => TextFormField(
    style: MyStyle().style_text_lg_hint(),
    controller: _emailController,
    //cursorColor: myGreen,
    decoration: InputDecoration(
      hintText: "Nh???p email...",
      hintStyle: MyStyle().style_text_lg_hint(),
    ),
    keyboardType: TextInputType.emailAddress,
    validator: (val) {
      if (val!.isEmpty) {
        return "Vui l??ng nh???p email";
      }
      return null;
    },
  );

  _passwordTextField() => TextFormField(
    obscureText: true,
    style: MyStyle().style_text_lg_hint(),
    controller: _passController,
    decoration: InputDecoration(
      hintText: "Nh???p m???t kh???u...",
      hintStyle: MyStyle().style_text_lg_hint(),
    ),
    keyboardType: TextInputType.emailAddress,
    validator: (val) {
      if (val!.isEmpty) {
        return "Vui l??ng nh???p m???t kh???u";
      }
      return null;
    },
  );

  _title(IconData icon, String text) => Container(
    child: Row(
      children: [
        Icon(icon, color: Colors.white,),
        SizedBox(width: 10,),
        Text(text, style: MyStyle().style_text_lg(),)
      ],
    ),
  );
}

