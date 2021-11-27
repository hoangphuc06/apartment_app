import 'package:apartment_app/src/blocs/auth_bloc.dart';
import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/fire_base/fire_base_auth.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/appbars/my_app_bar.dart';
import 'package:apartment_app/src/widgets/title/title_info_not_null.dart';
import 'package:apartment_app/src/widgets/title/title_info_null.dart';
import 'package:flutter/material.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
class ResetPassWord extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ResetPassWordState();
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
        if(this._formkey.currentState!.validate())
        await   this._firAuth.resetPassWord(this.mail.text).then((value) => {
        Navigator.pop(context),
        });


      }

  _emailTextField() => Container(
    padding: MyStyle().padding_container_tff(),
    decoration: MyStyle().style_decoration_container(),
    child: TextFormField(
      decoration: MyStyle().style_decoration_tff("Nhập email"),
      style: MyStyle().style_text_tff(),
      controller: mail,
      keyboardType: TextInputType.text,
      validator: (val) {
        if (val!.isEmpty) {
          return "Vui lòng nhâp email";
        }
        var isValidEmail = RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
            .hasMatch(val);
        if (!isValidEmail) {
          return "Định dạng email không đúng";
        }
        return null;
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: myAppBar("Quên mật khẩu"),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Container(
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
                              image: AssetImage('assets/images/forget.jpg')
                          )
                      ),
                    ),

                    //Tiêu đề
                    SizedBox(height: 20,),
                    Text(
                      "Vui lòng cung cấp chính xác địa chỉ email của bạn để chúng tôi hỗ trợ bạn tốt nhất!",
                      style: TextStyle(),
                    ),

                    // Tên loại căn hộ
                    SizedBox(height: 20,),
                    TitleInfoNotNull(text: 'Email'),
                    SizedBox(height: 10,),
                    _emailTextField(),

                    SizedBox(height: 10,),
                  ],
                ),
              ),
              // Nút bấm
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: MainButton(
                  name: 'Xác Nhận',
                  onpressed: () async{
                    this.sentEmailToResetPassWord();
                }),
              ),
              SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }
}
