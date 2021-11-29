import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_owner.dart';
import 'package:apartment_app/src/fire_base/fb_account.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_renter.dart';

import 'package:apartment_app/src/pages/dweller/firebase/fb_dweller.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/appbars/my_app_bar.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:apartment_app/src/widgets/dialog/msg_dilog.dart';
import 'package:apartment_app/src/widgets/title/title_info_not_null.dart';
import 'package:apartment_app/src/widgets/title/title_info_null.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';

class AddPerson extends StatefulWidget {
  // const AddPerson({Key? key}) : super(key: key);
  final String flag;
  AddPerson({required this.flag});
  @override
  _AddPersonState createState() => _AddPersonState();
}

class _AddPersonState extends State<AddPerson> {
  final _formkey = GlobalKey<FormState>();
  String id = (new DateTime.now().millisecondsSinceEpoch).toString();
  late FirebaseAuth _firebaseAuth;

  DwellersFB dwellersFB = new DwellersFB();
  RenterFB renterFB = new RenterFB();
  OwnerFB ownerFB = new OwnerFB();
  DateTime selectedDate = DateTime.now();
  AccountFB accountFB = new AccountFB();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _cmndController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _homeTownController = TextEditingController();
  //final TextEditingController _roleController = TextEditingController();

  final List<Map<String, dynamic>> _items = [
    {
      'value': '0',
      'label': 'Nam',
    },
    {
      'value': '1',
      'label': 'Nữ',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: widget.flag=='0'?myAppBar("Thêm người thuê"):myAppBar("Thêm đại diện cho thuê"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title("Thông tin chi tiết"),
              SizedBox(
                height: 10,
              ),

              //Họ tên
              TitleInfoNotNull(text: "Tên thành viên"),
              SizedBox(
                height: 10,
              ),
              _nameTextField(),

              // Ngày sinh
              SizedBox(
                height: 10,
              ),
              TitleInfoNotNull(text: "Ngày sinh"),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: MyStyle().padding_container_tff(),
                decoration: MyStyle().style_decoration_container(),
                child: GestureDetector(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: AbsorbPointer(child: _birthdayTextField()),
                ),
              ),

              // Giới tính
              SizedBox(
                height: 10,
              ),
              TitleInfoNotNull(text: "Giới tính"),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: MyStyle().padding_container_tff(),
                decoration: MyStyle().style_decoration_container(),
                child: SelectFormField(
                  decoration: MyStyle().style_decoration_tff("Chọn giới tính"),
                  type: SelectFormFieldType.dropdown, // or can be dialog
                  items: _items,
                  onChanged: (val) => _genderController.text = val,
                  onSaved: (val) => _genderController.text = val!,
                  validator: (val) => val == "" ? 'Vui lòng chọn giới tính' : null,
                ),
              ),

              //CMND/CCCD
              SizedBox(
                height: 10,
              ),
              TitleInfoNull(text: "CMND/CCCD"),
              SizedBox(
                height: 10,
              ),
              _cmndTextField(),

              //Quê quán
              SizedBox(
                height: 10,
              ),
              TitleInfoNotNull(text: "Quê quán"),
              SizedBox(
                height: 10,
              ),
              _homeTownTextField(),

              //Nghề nghiệp
              SizedBox(
                height: 10,
              ),
              TitleInfoNotNull(text: "Nghề nghiệp"),
              SizedBox(
                height: 10,
              ),
              _jobTextField(),

              SizedBox(
                height: 30,
              ),
              _title("Liên hệ"),
              SizedBox(
                height: 10,
              ),
              //Họ tên
              TitleInfoNull(text: "Số điện thoại"),
              SizedBox(
                height: 10,
              ),
              _phoneNumberTextField(),

              // Ngày sinh
              SizedBox(
                height: 10,
              ),
              TitleInfoNull(text: "Email"),
              SizedBox(
                height: 10,
              ),
              _emailTextField(),

              SizedBox(
                height: 30,
              ),

              MainButton(
                name: "Thêm",
                onpressed: _AddPerson,
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _AddPerson() {
    if (_formkey.currentState!.validate()) {
      String name = _nameController.text.trim();
      String birthday = _birthdayController.text.trim();
      String gender = _genderController.text.trim();
      String cmnd = _cmndController.text.trim();
      String homeTown = _homeTownController.text.trim();
      String job = _jobController.text.trim();
      String phoneNumber = _phoneNumberController.text.trim();
      String email = _emailController.text.trim();
      if (widget.flag == '0') {
        renterFB
            .add("", name, birthday, gender, cmnd, homeTown, job, phoneNumber,
                email, false,id)
            .then((value) => {
                  Navigator.pop(context),
                });
      } else {
        ownerFB
            .add(
                name, birthday, gender, cmnd, homeTown, job, phoneNumber, email)
            .then((value) => {
                  Navigator.pop(context),
                });
      }

      // renterFB
      //     .add("", name, birthday, gender, cmnd, homeTown, job, phoneNumber,
      //         email, false,id)
      //     .then((value) => {
      //           createAccount(),
      //           //MsgDialog.showMsgDialog(context, "Tạo tài khoản", "tài khoản $_emailController"),
      //           Navigator.pop(context),
      //         });
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        var date =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        _birthdayController.text = date;
      });
  }

  _nameTextField() => Container(
        padding: MyStyle().padding_container_tff(),
        decoration: MyStyle().style_decoration_container(),
        child: TextFormField(
          style: MyStyle().style_text_tff(),
          decoration: MyStyle().style_decoration_tff("Nhập tên"),
          controller: _nameController,
          keyboardType: TextInputType.name,
          validator: (val) {
            if (val!.isEmpty) {
              return "Vui lòng nhập tên";
            }
            return null;
          },
        ),
      );

  _birthdayTextField() => TextFormField(
        style: MyStyle().style_text_tff(),
        controller: _birthdayController,
        decoration: InputDecoration(
            hintText: "Nhập ngày sinh...", border: InputBorder.none),
        keyboardType: TextInputType.datetime,
        validator: (val) {
          if (val!.isEmpty) {
            return "Vui lòng nhập ngày sinh";
          }
          return null;
        },
      );

  _cmndTextField() => Container(
        padding: MyStyle().padding_container_tff(),
        decoration: MyStyle().style_decoration_container(),
        child: TextFormField(
          decoration: MyStyle().style_decoration_tff("Nhập CMND/CCCD"),
          style: MyStyle().style_text_tff(),
          controller: _cmndController,
          keyboardType: TextInputType.text,
          validator: (val) {
            if (val!.isEmpty) {
              return "Vui lòng số CMND hoặc CCCD";
            }
            return null;
          },
        ),
      );

  _phoneNumberTextField() => Container(
        padding: MyStyle().padding_container_tff(),
        decoration: MyStyle().style_decoration_container(),
        child: TextFormField(
          decoration: MyStyle().style_decoration_tff("Nhập số điện thoại"),
          style: MyStyle().style_text_tff(),
          controller: _phoneNumberController,
          keyboardType: TextInputType.number,
          validator: (val) {
            if (val!.isEmpty) {
              return "Vui lòng nhập số điện thoại";
            }
            return null;
          },
        ),
      );

  _emailTextField() => Container(
        padding: MyStyle().padding_container_tff(),
        decoration: MyStyle().style_decoration_container(),
        child: TextFormField(
          decoration: MyStyle().style_decoration_tff("Nhập email"),
          style: MyStyle().style_text_tff(),
          controller: _emailController,
          keyboardType: TextInputType.text,
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
          },
        ),
      );

  _jobTextField() => Container(
        padding: MyStyle().padding_container_tff(),
        decoration: MyStyle().style_decoration_container(),
        child: TextFormField(
          decoration: MyStyle().style_decoration_tff("Nhập nghề nghiệp"),
          style: MyStyle().style_text_tff(),
          controller: _jobController,
          keyboardType: TextInputType.text,
          validator: (val) {
            if (val!.isEmpty) {
              return "Vui lòng nhập nghề nghiệp";
            }
            return null;
          },
        ),
      );

  _homeTownTextField() => Container(
        padding: MyStyle().padding_container_tff(),
        decoration: MyStyle().style_decoration_container(),
        child: TextFormField(
          decoration: MyStyle().style_decoration_tff("Nhập quê quán"),
          style: MyStyle().style_text_tff(),
          controller: _homeTownController,
          keyboardType: TextInputType.name,
          validator: (val) {
            if (val!.isEmpty) {
              return "Vui lòng nhập quê quán";
            }
            return null;
          },
        ),
      );
  _noteTextField() => Container(
        padding: MyStyle().padding_container_tff(),
        decoration: MyStyle().style_decoration_container(),
        child: TextFormField(
          decoration: MyStyle().style_decoration_tff("Nhập ghi chú"),
          style: MyStyle().style_text_tff(),
          //controller: _noteController,
          keyboardType: TextInputType.name,
          minLines: 3,
          maxLines: 10,
        ),
      );

  _title(String text) => Text(
        text,
        style: TextStyle(
            color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.bold),
      );
  Future createAccount() async{
    //var user = _firebaseAuth.createUserWithEmailAndPassword(email: _emailController.text, password: "123456");
    try {
      UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: "123456"
      );
      String uid = user.user!.uid;
      print(uid);
      await accountFB.add(id, uid, _emailController.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
