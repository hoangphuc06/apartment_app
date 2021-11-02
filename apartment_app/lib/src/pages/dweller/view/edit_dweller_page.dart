

import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/dweller/firebase/fb_dweller.dart';
import 'package:apartment_app/src/pages/dweller/model/dweller_model.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:apartment_app/src/widgets/title/title_info_not_null.dart';
import 'package:apartment_app/src/widgets/title/title_info_null.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';

class EditDwellerPage extends StatefulWidget {
  final Dweller dweller;
  //const EditDwellerPage({Key? key}) : super(key: key);
  EditDwellerPage(this.dweller);

  @override
  _EditDwellerPageState createState() => _EditDwellerPageState();
}

class _EditDwellerPageState extends State<EditDwellerPage> {
  final _formkey = GlobalKey<FormState>();

  DwellersFB dwellersFB =new DwellersFB();

  DateTime selectedDate = DateTime.now();


  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _cmndController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _homeTownController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();


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

  final List<Map<String, dynamic>> _itemsRole = [
    {
      'value': '1',
      'label': 'Chủ hộ',
    },
    {
      'value': '2',
      'label': 'Người thân chủ hộ',
    },
    {
      'value': '3',
      'label': 'Người thuê lại',
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initInfo();
  }

  void initInfo() {
    _nameController.text = this.widget.dweller.name.toString();
    _birthdayController.text = this.widget.dweller.birthday.toString();
    _genderController.text = this.widget.dweller.gender.toString();
    _cmndController.text = this.widget.dweller.cmnd.toString();
    _homeTownController.text = this.widget.dweller.homeTown.toString();
    _jobController.text = this.widget.dweller.job.toString();
    _roleController.text = this.widget.dweller.role.toString();
    _phoneNumberController.text = this.widget.dweller.phoneNumber.toString();
    _emailController.text = this.widget.dweller.email.toString();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: myGreen,
        elevation: 0,
        centerTitle: true,
        title:  Text(
          "Sửa thông tin thành viên",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
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
                      SizedBox(height: 10,),
                      Text("THÔNG TIN CHI TIẾT", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                      SizedBox(height: 20,),

                      //Họ tên
                      TitleInfoNotNull(text: "Tên thành viên"),
                      _nameTextField(),

                      // Ngày sinh
                      SizedBox(height: 20,),
                      TitleInfoNotNull(text: "Ngày sinh"),
                      GestureDetector(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: AbsorbPointer(
                            child: _birthdayTextField()
                        ),
                      ),

                      // Giới tính
                      SizedBox(height: 20,),
                      TitleInfoNotNull(text: "Giới tính"),
                      SelectFormField(
                        initialValue: this.widget.dweller.gender,
                        hintText: "Nhập giới tính",
                        type: SelectFormFieldType.dropdown, // or can be dialog
                        items: _items,
                        onChanged: (val) => _genderController.text = val,
                        onSaved: (val) => _genderController.text = val!,
                      ),

                      //CMND/CCCD
                      SizedBox(height: 20,),
                      TitleInfoNull(text: "CMND/CCCD"),
                      _cmndTextField(),

                      //Quê quán
                      SizedBox(height: 20,),
                      TitleInfoNotNull(text: "Quê quán"),
                      _homeTownTextField(),

                      //Nghề nghiệp
                      SizedBox(height: 20,),
                      TitleInfoNotNull(text: "Nghề nghiệp"),
                      _jobTextField(),

                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 2,
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Text("CƯ TRÚ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                      SizedBox(height: 20,),

                      //Vai trò
                      TitleInfoNotNull(text: "Vai trò"),
                      SelectFormField(
                        initialValue: this.widget.dweller.role,
                        hintText: "Nhập vai trò",
                        type: SelectFormFieldType.dropdown, // or can be dialog
                        items: _itemsRole,
                        onChanged: (val) => _roleController.text = val,
                        onSaved: (val) => _roleController.text = val!,
                      ),

                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 2,
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Text("LIÊN HỆ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                      SizedBox(height: 20,),

                      //Họ tên
                      TitleInfoNull(text: "Số điện thoại"),
                      _phoneNumberTextField(),

                      // Ngày sinh
                      SizedBox(height: 20,),
                      TitleInfoNull(text: "Email"),
                      _emailTextField(),

                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
              //Nút nhấn
              SizedBox(height: 10,),
              MainButton(
                name: "Sửa",
                onpressed: _updateDweller,
              ),
              SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }

  void _updateDweller() {
    String name = _nameController.text.trim();
    String birthday = _birthdayController.text.trim();
    String gender = _genderController.text.trim();
    String cmnd = _cmndController.text.trim();
    String homeTown = _homeTownController.text.trim();
    String job = _jobController.text.trim();
    String role = _roleController.text.trim();
    String phoneNumber = _phoneNumberController.text.trim();
    String email = _emailController.text.trim();

    dwellersFB.update(widget.dweller.id.toString(),widget.dweller.idApartment.toString(), name, birthday, gender, cmnd, homeTown, job, role, phoneNumber, email)
      .then((value) => {
        Navigator.pop(context,Dweller(
          id: widget.dweller.id.toString(),
          idApartment: widget.dweller.idApartment.toString(),
          name: name,
          birthday: birthday,
          gender: gender,
          cmnd: cmnd,
          homeTown: homeTown,
          job: job,
          role: role,
          phoneNumber: phoneNumber,
          email: email,
        )),
    });
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

  _nameTextField() => TextFormField(
    style: MyStyle().style_text_tff(),
    controller: _nameController,
    decoration: InputDecoration(
      hintText: "Nhập tên...",
    ),
    keyboardType: TextInputType.name,
    validator: (val) {
      if (val!.isEmpty) {
        return "Vui lòng nhập tên";
      }
      return null;
    },
  );

  _birthdayTextField() => TextFormField(
    style: MyStyle().style_text_tff(),
    controller: _birthdayController,
    decoration: InputDecoration(
      hintText: "Nhập ngày sinh...",
    ),
    keyboardType: TextInputType.datetime,
    validator: (val) {
      if (val!.isEmpty) {
        return "Vui lòng nhập ngày sinh";
      }
      return null;
    },
  );

  _cmndTextField() => TextFormField(
    style: MyStyle().style_text_tff(),
    controller: _cmndController,
    decoration: InputDecoration(
      hintText: "Nhập CMND/CCCD...",
    ),
    keyboardType: TextInputType.text,
  );

  _phoneNumberTextField() => TextFormField(
    style: MyStyle().style_text_tff(),
    controller: _phoneNumberController,
    decoration: InputDecoration(
      hintText: "Nhập số điện thoại...",
    ),
    keyboardType: TextInputType.text,
  );

  _emailTextField() => TextFormField(
    style: MyStyle().style_text_tff(),
    controller: _cmndController,
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

  _jobTextField() => TextFormField(
    style: MyStyle().style_text_tff(),
    controller: _jobController,
    decoration: InputDecoration(
      hintText: "Nhập nghề nghiệp...",
    ),
    keyboardType: TextInputType.text,
    validator: (val) {
      if (val!.isEmpty) {
        return "Vui lòng nhập nghề nghiệp";
      }
      return null;
    },
  );

  _homeTownTextField() => TextFormField(
    style: MyStyle().style_text_tff(),
    controller: _homeTownController,
    decoration: InputDecoration(
      hintText: "Nhập quê quán...",
    ),
    keyboardType: TextInputType.name,
    validator: (val) {
      if (val!.isEmpty) {
        return "Vui lòng nhập quê quán";
      }
      return null;
    },
  );
}

