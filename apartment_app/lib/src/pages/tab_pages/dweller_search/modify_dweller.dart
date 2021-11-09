import 'package:apartment_app/src/pages/dweller/firebase/fb_dweller.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:apartment_app/src/widgets/title/title_info_not_null.dart';
import 'package:apartment_app/src/widgets/title/title_info_null.dart';
import 'package:flutter/material.dart';
import 'package:apartment_app/src/pages/notification/firebase/fb_notification.dart';
import 'package:intl/intl.dart';

import 'model/dweller_info.dart';
class ModifyDwellerPage extends StatefulWidget {
  late DwellerModel info;
  ModifyDwellerPage({required this.info,Key? key}) : super(key: key);

  @override
  _ModifyDwellerPageState createState() {
    _ModifyDwellerPageState temp= new _ModifyDwellerPageState();
    temp.info=this.info;
    temp.filltemplate();
    return temp;
    DateTime selectedDate = DateTime.now();
  }
}
class _ModifyDwellerPageState extends State<ModifyDwellerPage> {
  TextEditingController _NameController= new TextEditingController();
  TextEditingController _CMNDController= new TextEditingController();
  TextEditingController _HomeTownController= new TextEditingController();
  TextEditingController _EmailController= new TextEditingController();
  TextEditingController _PhoneController= new TextEditingController();
  TextEditingController _JobController= new TextEditingController();
  TextEditingController _dayController= new TextEditingController();

  String gender='';
  late DwellerModel info;
  String? birthday='';
  int radioValue = 0;
  final _formkey = GlobalKey<FormState>();
  DwellersFB fb = new DwellersFB();
  DateTime selectedDate = DateTime.now();
  void filltemplate(){
   this._CMNDController.text=this.info.cmnd.toString();
    this._NameController.text=this.info.name.toString();
    this._HomeTownController.text=this.info.hometown.toString();
    this._EmailController.text=this.info.email.toString();
    this._PhoneController.text=this.info.phone.toString();
    this._JobController.text=this.info.job.toString();
    this.gender=this.info.gender.toString();
    this.radioValue= int.parse(this.gender);
    this.birthday=this.info.birthday.toString();
    this._dayController.text=this.info.birthday.toString();
  }
  _selectDate(
      BuildContext context, TextEditingController _startDayController) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2019, 8),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        var date =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        _startDayController.text = date;
        selectedDate = DateTime.now();
      });
  }
  _textformFieldwithIcon(TextEditingController controller, String hint,
      String text, double height, IconData icon) =>
      TextFormField(
        style: MyStyle().style_text_tff(),
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          suffixIcon: Padding(
            padding: EdgeInsetsDirectional.all(0),
            child: Icon(icon),
          ),
        ),
        keyboardType: TextInputType.datetime,
        validator: (value) {
          if (value!.isEmpty) {
            return "Vui lòng nhập " + text;
          } else {
            return null;
          }
        },
      );
  _nameTextField() => TextFormField(
    style: MyStyle().style_text_tff(),
    controller:  _NameController,
    decoration: InputDecoration(
      hintText: 'Ho va ten',
      hintStyle: MyStyle().style_text_tff(),
    ),
    keyboardType: TextInputType.name,
    validator: (val) {
      if (val!.isEmpty) {
        return "ten không hợp lệ";
      }
      return null;
    },
  );
  _PhoneTextField() => TextFormField(

    style: MyStyle().style_text_tff(),
    controller:  _PhoneController,
    decoration: InputDecoration(
      hintText: 'Ho va ten',
      hintStyle: MyStyle().style_text_tff(),
    ),
    keyboardType: TextInputType.name,
  );
  _EmailTextField() => TextFormField(

    style: MyStyle().style_text_tff(),
    controller:  _EmailController,
    decoration: InputDecoration(
      hintText: 'admin@gmail.com',
      hintStyle: MyStyle().style_text_tff(),
    ),
    keyboardType: TextInputType.name,
    validator: (val) {
      if (val!.isEmpty) {
        return "ten không hợp lệ";
      }
      return null;
    },
  );
  _JobTextField() => TextFormField(

    style: MyStyle().style_text_tff(),
    controller:  _JobController,
    decoration: InputDecoration(
      hintText: 'Công việc',
      hintStyle: MyStyle().style_text_tff(),
    ),
    keyboardType: TextInputType.name,

  );
  _homeTownTextField() => TextFormField(
    style: MyStyle().style_text_tff(),
    controller:  _HomeTownController,
    decoration: InputDecoration(
      hintText: 'Quê quán',
      hintStyle: MyStyle().style_text_tff(),
    ),
    keyboardType: TextInputType.name,

  );
  _CMNDTextField() => TextFormField(
    style: MyStyle().style_text_tff(),
    controller:  _CMNDController,
    decoration: InputDecoration(
      hintText: 'Số CMND',
      hintStyle: MyStyle().style_text_tff(),
    ),
    keyboardType: TextInputType.name,
    validator: (val) {
      if (val!.isEmpty) {
        return "số CMND không hợp lệ";
      }
      return null;
    },
  );
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Thông báo'),),
      body: SingleChildScrollView(padding: EdgeInsets.all(18),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TitleInfoNotNull(text: "Họ và tên"),
             _nameTextField(),
              SizedBox(height: 30,),
              Row(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TitleInfoNotNull(text: "Giới tính"),
                  Expanded(
                    child: ListTile(
                      title: Text('Nam'),
                      leading: Radio(
                        value: 0,
                        groupValue: this.radioValue,
                        onChanged: (value) {
                          setState(() {
                            this.radioValue = 0;
                          });
                        },
                        activeColor: Colors.green,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text('Nữ'),
                      leading: Radio(
                        value: 1,
                        groupValue: this.radioValue,
                        onChanged: (value) {
                          setState(() {
                            this.radioValue=1;

                          });
                        },
                        activeColor: Colors.green,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 30,),
              TitleInfoNotNull(text: "Số CMND"),
              _CMNDTextField(),
              SizedBox(height: 30,),
              TitleInfoNotNull(text: "Ngay sinh"),
              GestureDetector(
                  onTap: () => _selectDate(
                      context, _dayController),
                  child: AbsorbPointer(
                    child: _textformFieldwithIcon(
                        _dayController,
                        "20/04/2021...",
                        "Ngay sinh",
                        20,
                        Icons.calendar_today_outlined),
                  )),
              SizedBox(height: 30,),
              TitleInfoNull(text: "Quê quán"),
              _homeTownTextField(),
              SizedBox(height: 30,),
              TitleInfoNull(text: "Nghề nghiệp"),
              _JobTextField(),
              SizedBox(height: 30,),
              TitleInfoNull(text: "Email"),
              _EmailTextField(),
              SizedBox(height: 30,),
              TitleInfoNull(text: "Số điện thoại"),
              _PhoneTextField(),
              SizedBox(height: 30,),

              MainButton(name: 'Xác nhận', onpressed: () {
                this.gender=this.radioValue.toString();
                if(_formkey.currentState!.validate()) {
                  this.fb.update(
                      this.widget.info!.id.toString(),
                      this.widget.info!.idApartment.toString(),
                      this._NameController.text,
                      this._dayController.text,
                      this.gender,
                      this._CMNDController.text,
                      this._PhoneController.text,
                      this._EmailController.text);
                  this.info.name= this._NameController.text;
                  this.info.birthday=  this._dayController.text;
                  this.info.gender=this.gender;
                  this.info.cmnd= this._CMNDController.text;
                  this.info.phone=this._PhoneController.text;
                  this.info.email=this._EmailController.text;
                  this.info.hometown=this._HomeTownController.text;
                  Navigator.pop(context, this.info);

                }
                // this.info.body= this._NoteController.text;
                // this.info.title=this._TitleController.text;
                // if(_formkey.currentState!.validate())
                // {
                //   //  Navigator.pop(context,this.info);
                //   if(this.widget.info!=null) {
                //     DateTime tempDate = new DateFormat('dd-MM-yyyy hh:mm a').parse(this.widget.info!.date.toString());
                //     this.fb.update(this.widget.info!.id.toString(),
                //         this._TitleController.text,
                //         this._NoteController.text,
                //         Timestamp.fromDate(tempDate));
                //     Navigator.pop(context, this.info);
                //   }
                //   else{
                //     this.fb.add(this._TitleController.text,this._NoteController.text,Timestamp.fromDate(DateTime.now()));
                //     Navigator.pop(context, this.info);
                //   }
                //
                // }

              }),
            ],
          ),
        ),
      ),
    );
    throw UnimplementedError();
  }
}