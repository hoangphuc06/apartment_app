import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/dweller/firebase/fb_dweller.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/appbars/my_app_bar.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:apartment_app/src/widgets/title/title_info_not_null.dart';
import 'package:apartment_app/src/widgets/title/title_info_null.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';

class AddDwellerPage extends StatefulWidget {
  final String id_apartment;
  //const AddDwellerPage({Key? key}) : super(key: key);
  AddDwellerPage(this.id_apartment);

  @override
  _AddDwellerPageState createState() => _AddDwellerPageState();
}

class _AddDwellerPageState extends State<AddDwellerPage> {

  final _formkey = GlobalKey<FormState>();

  DwellersFB dwellersFB = new DwellersFB();

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar('Thêm thành viên'),
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
                    _title("Thông tin chi tiết"),
                    SizedBox(height: 10,),

                    //Họ tên
                    TitleInfoNotNull(text: "Tên thành viên"),
                    SizedBox(height: 10,),
                    _nameTextField(),

                    // Ngày sinh
                    SizedBox(height: 10,),
                    TitleInfoNotNull(text: "Ngày sinh"),
                    SizedBox(height: 10,),
                    GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: AbsorbPointer(
                          child: _birthdayTextField()
                      ),
                    ),

                    // Giới tính
                    SizedBox(height: 10,),
                    TitleInfoNotNull(text: "Giới tính"),
                    SizedBox(height: 10,),
                    Container(
                      padding: MyStyle().padding_container_tff(),
                      decoration: MyStyle().style_decoration_container(),
                      child: SelectFormField(
                        decoration: MyStyle().style_decoration_tff("Nhập giới tính"),
                        type: SelectFormFieldType.dropdown, // or can be dialog
                        items: _items,
                        onChanged: (val) => _genderController.text = val,
                        onSaved: (val) => _genderController.text = val!,
                      ),
                    ),

                    //CMND/CCCD
                    SizedBox(height: 10,),
                    TitleInfoNull(text: "CMND/CCCD"),
                    SizedBox(height: 10,),
                    _cmndTextField(),

                    //Quê quán
                    SizedBox(height: 10,),
                    TitleInfoNotNull(text: "Quê quán"),
                    SizedBox(height: 10,),
                    _homeTownTextField(),

                    //Nghề nghiệp
                    SizedBox(height: 10,),
                    TitleInfoNotNull(text: "Nghề nghiệp"),
                    SizedBox(height: 10,),
                    _jobTextField(),

                    SizedBox(height: 30,),
                    _title("Cư trú"),
                    SizedBox(height: 10,),
                    TitleInfoNotNull(text: "Vai trò"),
                    SizedBox(height: 10,),
                    Container(
                      padding: MyStyle().padding_container_tff(),
                      decoration: MyStyle().style_decoration_container(),
                      child: SelectFormField(
                        decoration: MyStyle().style_decoration_tff("Nhập vai trò"),
                        hintText: "Nhập vai trò",
                        type: SelectFormFieldType.dropdown, // or can be dialog
                        items: _itemsRole,
                        onChanged: (val) => _roleController.text = val,
                        onSaved: (val) => _roleController.text = val!,
                      ),
                    ),

                    SizedBox(height: 30,),
                    _title("Liên hệ"),
                    SizedBox(height: 10,),
                    TitleInfoNull(text: "Số điện thoại"),
                    SizedBox(height: 10,),
                    _phoneNumberTextField(),
                    SizedBox(height: 10,),
                    TitleInfoNull(text: "Email"),
                    SizedBox(height: 10,),
                    _emailTextField(),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: MainButton(
                  name: "Thêm",
                  onpressed: _addDweller,
                ),
              ),
              SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }

  void _addDweller() {
    if (_formkey.currentState!.validate()) {
      String name = _nameController.text.trim();
      String birthday = _birthdayController.text.trim();
      String gender = _genderController.text.trim();
      String cmnd = _cmndController.text.trim();
      String homeTown = _homeTownController.text.trim();
      String job = _jobController.text.trim();
      String role = _roleController.text.trim();
      String phoneNumber = _phoneNumberController.text.trim();
      String email = _emailController.text.trim();

      dwellersFB.add(widget.id_apartment, name, birthday, gender, cmnd, homeTown, job, role, phoneNumber, email)
          .then((value) => {
        Navigator.pop(context),
      });
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

  _birthdayTextField() => Container(
    padding: MyStyle().padding_container_tff(),
    decoration: MyStyle().style_decoration_container(),
    child: TextFormField(
      decoration: MyStyle().style_decoration_tff("Nhập ngày sinh"),
      style: MyStyle().style_text_tff(),
      controller: _birthdayController,
      keyboardType: TextInputType.datetime,
      validator: (val) {
        if (val!.isEmpty) {
          return "Vui lòng nhập ngày sinh";
        }
        return null;
      },
    ),
  );

  _cmndTextField() => Container(
    padding: MyStyle().padding_container_tff(),
    decoration: MyStyle().style_decoration_container(),
    child: TextFormField(
      decoration: MyStyle().style_decoration_tff("Nhập email"),
      style: MyStyle().style_text_tff(),
      controller: _cmndController,
      keyboardType: TextInputType.text,
    ),
  );

  _phoneNumberTextField() => Container(
    padding: MyStyle().padding_container_tff(),
    decoration: MyStyle().style_decoration_container(),
    child: TextFormField(
      decoration: MyStyle().style_decoration_tff("Nhập số điện thoại"),
      style: MyStyle().style_text_tff(),
      controller: _phoneNumberController,
      keyboardType: TextInputType.text,
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
          return null;
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

  _title(String text) => Text(
    text,
    style: TextStyle(
        color: Colors.black.withOpacity(0.5),
        fontWeight: FontWeight.bold
    ),
  );
}




