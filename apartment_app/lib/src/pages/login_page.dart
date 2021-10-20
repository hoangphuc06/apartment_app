import 'package:apartment_app/src/blocs/auth_bloc.dart';
import 'package:apartment_app/src/fire_base/fire_base_auth.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:apartment_app/src/widgets/dialog/loading_dialog.dart';
import 'package:apartment_app/src/widgets/dialog/msg_dilog.dart';
import 'package:apartment_app/src/widgets/textfields/email_textfield.dart';
import 'package:apartment_app/src/widgets/textfields/password_textfield.dart';
import 'package:flutter/material.dart';

import '../app.dart';

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
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Stack(
                children: [
                  Image(
                    image: AssetImage('assets/images/welcome.png'),
                    width: double.infinity,
                    height: 350.0,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              Transform.translate(
                offset: Offset(0.0, -20.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "Xin chào!",
                            style: TextStyle(
                                color: Colors.black,
                                //fontWeight: FontWeight.w500,
                                fontSize: 25.0
                            ),
                          ),
                          Text(
                            "Vui lòng đăng nhập để tiếp tục",
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 15.0
                            ),
                          ),
                          SizedBox(height: 20,),
                          TextFormField(
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Vui lòng nhập email";
                              }
                              var isValidEmail = RegExp(
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                  .hasMatch(val);
                              if (!isValidEmail) {
                                return "Định dạng email không đúng";
                              }
                              return null;
                            },
                            controller: _emailController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                hintText: 'Email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )
                            ),
                          ),
                          SizedBox(height: 10,),
                          TextFormField(
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Vui lòng nhập mật khẩu";
                              }
                              if (val.length < 6) {
                                return "Mật khẩu phải không nhỏ hơn 6 kí tự";
                              }
                              return null;
                            },
                            controller: _passController,
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                                hintText: 'Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )
                            ),
                          ),
                          SizedBox(height: 10,),
                          MainButton(
                              name: 'Đăng nhập',
                              onpressed: _onLoginClick,
                          ),
                          SizedBox(height: 20,),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, "reset_password_page");
                            },
                            child: Text(
                              "Quên mật khẩu?",
                              style: TextStyle(fontSize: 15, color: Colors.blueGrey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onLoginClick() {
    String email = _emailController.text;
    String pass = _passController.text;

    if(_formkey.currentState!.validate()) {
      LoadingDialog.showLoadingDialog(context, "Loading...");
      print("Email: ${_emailController.text}"); // Nhìn terminal biết email
      print("Password: ${_passController.text}"); // Nhìn terminal biết mật khẩu
      authBloc.signIn(
          email,
          pass,
          () {
                LoadingDialog.hideLoadingDialog(context);
                Navigator.pushNamed(context, "tab_page");
            },
          (msg) {
                    LoadingDialog.hideLoadingDialog(context);
                    MsgDialog.showMsgDialog(context, "Đăng nhập thất bại", msg);
              });
    }


    //var auth = AuthBloc();

  }
}
