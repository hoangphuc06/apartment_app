import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_renter.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:apartment_app/src/widgets/title/title_info_not_null.dart';
import 'package:flutter/material.dart';

class AddRenter extends StatefulWidget {
  const AddRenter({Key? key}) : super(key: key);

  @override
  _AddRenterState createState() => _AddRenterState();
}

class _AddRenterState extends State<AddRenter> {

  final _formkey = GlobalKey<FormState>();
  final TextEditingController _nameRenter = TextEditingController();
  final TextEditingController _phoneNumberRenter = TextEditingController();
  final TextEditingController _identificationRenter = TextEditingController();

  RenterFB renterFB =new RenterFB();

  @override
  Widget build(BuildContext context) {
     final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: myGreen,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Thêm người thuê",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
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
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "THÔNG TIN",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      //Họ tên
                      TitleInfoNotNull(text: "Họ và tên"),
                      _textformField(_nameRenter,"Lê Hoàng Phúc...","họ và tên"),

                      // Ngày sinh
                      SizedBox(
                        height: 20,
                      ),
                      TitleInfoNotNull(text: "Số điện thoại"),
                      _textformField(_phoneNumberRenter,"09466385229...","só điện thoại"),

                      // Giới tính
                      SizedBox(
                        height: 20,
                      ),
                      TitleInfoNotNull(text: "CMND/CCCD"),
                       _textformField(_identificationRenter,"241811545...","CMND/CCCD"),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
                SizedBox(
                height: height * 0.05,
              ),
              //tạo hợp đồng
              Container(
                padding: EdgeInsets.only(right: 20, left: 20),
                child: MainButton(name: "Thêm", onpressed: _onClick),
              ),
              SizedBox(
                height: height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
  _textformField(TextEditingController controller, String hint, String text) =>
    TextFormField(
      style: MyStyle().style_text_tff(),
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
      ),
      keyboardType: TextInputType.name,
      validator: (val) {
        if (val!.isEmpty) {
          return "Vui lòng nhập " + text;
        }
        return null;
      },
    );
void _onClick() {
    if (_formkey.currentState!.validate()) {
      _addRenter();
    }
  }

  void _addRenter() {
    renterFB
        .add(
            _nameRenter.text,
            _phoneNumberRenter.text,
            _identificationRenter.text
            )
        .then((value) => {
             _nameRenter.clear(),
            _phoneNumberRenter.clear(),
            _identificationRenter.clear(),
              Navigator.pop(context),
            });
  }

}

