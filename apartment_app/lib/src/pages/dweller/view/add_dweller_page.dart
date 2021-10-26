import 'package:apartment_app/src/pages/dweller/firebase/fb_dweller.dart';
import 'package:apartment_app/src/style/my_style.dart';
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
      appBar: AppBar(
        title: Text("Thêm thành viên", ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              // Tên loại căn hộ
              TitleInfoNotNull(text: "Tên thành viên"),
              _nameTextField(),

              // Ngày sinh
              SizedBox(height: 30,),
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
              SizedBox(height: 30,),
              TitleInfoNotNull(text: "Giới tính"),
              SelectFormField(
                hintText: "Nhập giới tính",
                type: SelectFormFieldType.dropdown, // or can be dialog
                items: _items,
                onChanged: (val) => _genderController.text = val,
                onSaved: (val) => _genderController.text = val!,
              ),
              //_genderTextField(),

              //CMND/CCCD
              SizedBox(height: 30,),
              TitleInfoNull(text: "CMND/CCCD"),
              _cmndTextField(),

              //SĐT
              SizedBox(height: 30,),
              TitleInfoNull(text: "Số điện thoại"),
              _phoneNumberTextField(),

              //Email
              SizedBox(height: 30,),
              TitleInfoNull(text: "Email"),
              _emailTextField(),

              //Nút nhấn
              SizedBox(height: 30,),
              MainButton(
                  name: "Thêm",
                  onpressed: adDweller
              ),
            ],
          ),
        ),
      ),
    );
  }

  void adDweller() {
    if (_formkey.currentState!.validate()) {
      String name = _nameController.text.trim();
      String birthday = _birthdayController.text.trim();
      String gender = _genderController.text.trim();
      String cmnd = _cmndController.text.trim();
      String phoneNumber = _phoneNumberController.text.trim();
      String email = _emailController.text.trim();

      dwellersFB.add(widget.id_apartment, name, birthday, gender, cmnd, phoneNumber, email)
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

  _genderTextField() => Container(
    child: DropdownButtonFormField<String>(
      value: _genderController.text,
      items: ["Nam", "Nữ"].map((label) => DropdownMenuItem(
        child: Text(label),
        value: label,
      )).toList(),
      hint: Text('Chọn giới tính'),
      onChanged: (value) {
        setState(() {
          _genderController.text = value.toString();
        });
      },
    ),
  );
}


