import 'package:apartment_app/src/pages/dweller_pages/fire_base/fb_dweller.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';

class EditDwellerPage extends StatefulWidget {
  final String id;
  //const EditDwellerPage({Key? key}) : super(key: key);
  EditDwellerPage(this.id);

  @override
  _EditDwellerPageState createState() => _EditDwellerPageState();
}

class _EditDwellerPageState extends State<EditDwellerPage> {
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
  void initState() {
    // TODO: implement initState
    super.initState();
    initInfo();
  }

  void initInfo() {
    setState(() {
      dwellersFB.collectionReference.doc(widget.id).get().then((value) => {
        _nameController.text = value["name"],
        _birthdayController.text = value["birthday"],
        _genderController.text = value["gender"],
        _cmndController.text = value["cmnd"],
        _phoneNumberController.text = value["phoneNumber"],
        _emailController.text = value["email"],
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Sửa thành viên", ),
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
                //controller: _genderController,
                type: SelectFormFieldType.dropdown, // or can be dialog
                initialValue: '1',
                icon: Icon(Icons.male),
                labelText: 'Giới tính',
                items: _items,
                onChanged: (val) => _genderController.text = val,
                onSaved: (val) => _genderController.text = val.toString(),
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
              ),
              SizedBox(height: 30,),
              MainButton(
                  name: "Sửa",
                  onpressed: updateDweller
              )
            ],
          ),
        ),
      ),
    );
  }

  void updateDweller() {
    String name = _nameController.text.trim();
    String birthday = _birthdayController.text.trim();
    String gender = _genderController.text.trim();
    String cmnd = _cmndController.text.trim();
    String phoneNumber = _phoneNumberController.text.trim();
    String email = _emailController.text.trim();

    dwellersFB.update(widget.id,"1", name, birthday, gender, cmnd, phoneNumber, email)
        .then((value) => {
      Navigator.pop(context),
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
}

