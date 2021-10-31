import 'package:apartment_app/src/blocs/auth_bloc.dart';
import 'package:apartment_app/src/fire_base/fire_base_auth.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/title/title_info_null.dart';
import 'package:flutter/material.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
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
  final _formkey = GlobalKey<FormState>();
  void sentMsg() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg,style: TextStyle(fontSize: 18),),
    ));
  }
  void sentEmailToResetPassWord() async{

        await   this._firAuth.resetPassWord(this.mail.text).then((value) => {
        Navigator.pop(context),
        });


      }

  _emailTextField() => TextFormField(
    style: MyStyle().style_text_tff(),
    controller: mail,
    decoration: InputDecoration(
      hintText: "Nhập email...",
    ),
    keyboardType: TextInputType.text,
    validator: (val) {
      if (val!.isEmpty) {
        return null;
      }
      var isValidEmail = RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(val);
      if (!isValidEmail) {
        return "Định dạng email không đúng";
      }
    },
  );
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Quên mật khẩu'),
      ),
      body: Container(
        margin:  EdgeInsets.only(left: 16,right: 16),
        child: Form(
          key: this._formkey,
          child: Column(
            children: [
              /*Text(
                  'Nhập email để lấy lại mật khẩu ,mail xác nhận thay đổi mật khẩu sẽ được gửi vào mail của bạn',
                  style:  TextStyle(
                    color: Colors.black54,
                    fontSize: 21,
                    fontWeight: FontWeight.w400,
                  )
              ),

               */

              TitleInfoNull(text: 'Email '),
              _emailTextField(),

             /* Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(

                  style: MyStyle().style_text_tff(),
                  controller: mail,
                  decoration: InputDecoration(
                      icon: Icon(Icons.mail), hintText: 'Nhap Email'),
                ),
              ),*/
              SizedBox(height: 30,),
              MainButton(name: 'Xac Nhan', onpressed: () async{

              }),
             /*z Padding(
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
              )*/
            ],
          ),
        ),
      ),
    );
    throw UnimplementedError();
  }
}
