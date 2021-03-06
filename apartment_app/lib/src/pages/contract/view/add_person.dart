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
      'label': 'N???',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: widget.flag=='0'?myAppBar("Th??m ng?????i thu??"):myAppBar("Th??m ?????i di???n cho thu??"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title("Th??ng tin chi ti???t"),
              SizedBox(
                height: 10,
              ),

              //H??? t??n
              TitleInfoNotNull(text: "T??n th??nh vi??n"),
              SizedBox(
                height: 10,
              ),
              _nameTextField(),

              // Ng??y sinh
              SizedBox(
                height: 10,
              ),
              TitleInfoNotNull(text: "Ng??y sinh"),
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

              // Gi???i t??nh
              SizedBox(
                height: 10,
              ),
              TitleInfoNotNull(text: "Gi???i t??nh"),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: MyStyle().padding_container_tff(),
                decoration: MyStyle().style_decoration_container(),
                child: SelectFormField(
                  decoration: MyStyle().style_decoration_tff("Ch???n gi???i t??nh"),
                  type: SelectFormFieldType.dropdown, // or can be dialog
                  items: _items,
                  onChanged: (val) => _genderController.text = val,
                  onSaved: (val) => _genderController.text = val!,
                  validator: (val) => val == "" ? 'Vui l??ng ch???n gi???i t??nh' : null,
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

              //Qu?? qu??n
              SizedBox(
                height: 10,
              ),
              TitleInfoNotNull(text: "Qu?? qu??n"),
              SizedBox(
                height: 10,
              ),
              _homeTownTextField(),

              //Ngh??? nghi???p
              SizedBox(
                height: 10,
              ),
              TitleInfoNotNull(text: "Ngh??? nghi???p"),
              SizedBox(
                height: 10,
              ),
              _jobTextField(),

              SizedBox(
                height: 30,
              ),
              _title("Li??n h???"),
              SizedBox(
                height: 10,
              ),
              //H??? t??n
              TitleInfoNull(text: "S??? ??i???n tho???i"),
              SizedBox(
                height: 10,
              ),
              _phoneNumberTextField(),

              // Ng??y sinh
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
                name: "Th??m",
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
                  createAccount(),
                  Navigator.pop(context),
                });
      } else {
        ownerFB
            .add(
                name, birthday, gender, cmnd, homeTown, job, phoneNumber, email)
            .then((value) => {
                  createAccount(),
                  Navigator.pop(context),
                });
      }

      // renterFB
      //     .add("", name, birthday, gender, cmnd, homeTown, job, phoneNumber,
      //         email, false,id)
      //     .then((value) => {
      //           createAccount(),
      //           //MsgDialog.showMsgDialog(context, "T???o t??i kho???n", "t??i kho???n $_emailController"),
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
          decoration: MyStyle().style_decoration_tff("Nh???p t??n"),
          controller: _nameController,
          keyboardType: TextInputType.name,
          validator: (val) {
            if (val!.isEmpty) {
              return "Vui l??ng nh???p t??n";
            }
            return null;
          },
        ),
      );

  _birthdayTextField() => TextFormField(
        style: MyStyle().style_text_tff(),
        controller: _birthdayController,
        decoration: InputDecoration(
            hintText: "Nh???p ng??y sinh...", border: InputBorder.none),
        keyboardType: TextInputType.datetime,
        validator: (val) {
          if (val!.isEmpty) {
            return "Vui l??ng nh???p ng??y sinh";
          }
          return null;
        },
      );

  _cmndTextField() => Container(
        padding: MyStyle().padding_container_tff(),
        decoration: MyStyle().style_decoration_container(),
        child: TextFormField(
          decoration: MyStyle().style_decoration_tff("Nh???p CMND/CCCD"),
          style: MyStyle().style_text_tff(),
          controller: _cmndController,
          keyboardType: TextInputType.text,
          validator: (val) {
            if (val!.isEmpty) {
              return "Vui l??ng s??? CMND ho???c CCCD";
            }
            return null;
          },
        ),
      );

  _phoneNumberTextField() => Container(
        padding: MyStyle().padding_container_tff(),
        decoration: MyStyle().style_decoration_container(),
        child: TextFormField(
          decoration: MyStyle().style_decoration_tff("Nh???p s??? ??i???n tho???i"),
          style: MyStyle().style_text_tff(),
          controller: _phoneNumberController,
          keyboardType: TextInputType.number,
          validator: (val) {
            if (val!.isEmpty) {
              return "Vui l??ng nh???p s??? ??i???n tho???i";
            }
            return null;
          },
        ),
      );

  _emailTextField() => Container(
        padding: MyStyle().padding_container_tff(),
        decoration: MyStyle().style_decoration_container(),
        child: TextFormField(
          decoration: MyStyle().style_decoration_tff("Nh???p email"),
          style: MyStyle().style_text_tff(),
          controller: _emailController,
          keyboardType: TextInputType.text,
          validator: (val) {
            if (val!.isEmpty) {
              return "Vui l??ng nh???p email";
            }
            var isValidEmail = RegExp(
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                .hasMatch(val);
            if (!isValidEmail) {
              return "?????nh d???ng email kh??ng ????ng";
            }
          },
        ),
      );

  _jobTextField() => Container(
        padding: MyStyle().padding_container_tff(),
        decoration: MyStyle().style_decoration_container(),
        child: TextFormField(
          decoration: MyStyle().style_decoration_tff("Nh???p ngh??? nghi???p"),
          style: MyStyle().style_text_tff(),
          controller: _jobController,
          keyboardType: TextInputType.text,
          validator: (val) {
            if (val!.isEmpty) {
              return "Vui l??ng nh???p ngh??? nghi???p";
            }
            return null;
          },
        ),
      );

  _homeTownTextField() => Container(
        padding: MyStyle().padding_container_tff(),
        decoration: MyStyle().style_decoration_container(),
        child: TextFormField(
          decoration: MyStyle().style_decoration_tff("Nh???p qu?? qu??n"),
          style: MyStyle().style_text_tff(),
          controller: _homeTownController,
          keyboardType: TextInputType.name,
          validator: (val) {
            if (val!.isEmpty) {
              return "Vui l??ng nh???p qu?? qu??n";
            }
            return null;
          },
        ),
      );
  _noteTextField() => Container(
        padding: MyStyle().padding_container_tff(),
        decoration: MyStyle().style_decoration_container(),
        child: TextFormField(
          decoration: MyStyle().style_decoration_tff("Nh???p ghi ch??"),
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
