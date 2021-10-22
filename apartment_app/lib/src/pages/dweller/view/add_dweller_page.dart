import 'package:apartment_app/src/pages/dweller/firebase/fb_dweller.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
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
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Họ tên",
                  icon: Icon(Icons.person)
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Vui lòng nhập họ và tên";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: () {
                  _selectDate(context);
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _birthdayController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                        labelText: "Ngày sinh",
                        icon: Icon(Icons.cake)
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              SelectFormField(
                type: SelectFormFieldType.dropdown, // or can be dialog
                initialValue: '0',
                icon: Icon(Icons.male),
                labelText: 'Giới tính',
                items: _items,
                onChanged: (val) => _genderController.text = val,
                onSaved: (val) => _genderController.text = val!,
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _cmndController,
                decoration: InputDecoration(
                    labelText: "CMND/CCCD",
                    icon: Icon(Icons.credit_card_sharp)
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                    labelText: "Số điện thoại",
                    icon: Icon(Icons.phone)
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    labelText: "Email",
                    icon: Icon(Icons.email)
                ),
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
}


