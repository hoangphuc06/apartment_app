

import 'package:animated_float_action_button/animated_floating_action_button.dart';
import 'package:apartment_app/src/pages/service/model/service_info.dart';
import 'package:apartment_app/src/pages/service/model/service_model.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/title/title_info_null.dart';
import 'package:apartment_app/src/widgets/title/title_info_not_null.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:flutter/material.dart';
import 'package:apartment_app/src/pages/service/firebase/fb_service.dart';

import '../../add_icon_page.dart';

class AddServicPage extends StatefulWidget {
  ServiceModel? sv;
  AddServicPage({this.sv ,Key? key}): super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createStatee
    print('create state');
    if(sv==null) {
      return StateAddPage();
    }
    var temp= StateAddPage();
    temp.sv=sv;
    print(this.sv!=null? this.sv?.name.toString():'sth wrong');
    if(this.sv!=null) temp.filltemplate(this.sv);
    return temp;

  }
}

class StateAddPage extends State<AddServicPage> {
  String type = 'Lũy tiền theo chỉ số đồng hồ';
  TextEditingController chargeController= new TextEditingController();
  TextEditingController nameController= new TextEditingController();
  TextEditingController noteController= new TextEditingController();
  final GlobalKey<AnimatedFloatingActionButtonState> fabKey = GlobalKey();
  ServiceModel ?sv;
  String buttonText='Thêm Dịch Vụ';
  List<String>  chargeType=['Lũy tiền theo chỉ số đồng hồ', 'Dich vụ có chỉ số đầu cuối','Người ','Phòng','Số lần sử dụng','Khác'];
  final _formkey = GlobalKey<FormState>();
  late ServiceModel info;
  ServiceModel? get service=>sv;
  ServiceFB fb = new ServiceFB();

  //---------------------------------------------------
  void filltemplate(ServiceModel? service){
    this.buttonText='Thay doi thong tin';
    this.nameController.text=service!.name.toString();
    this.chargeController.text=service.charge.toString();
    type= service.type.toString();
    noteController.text= service.detail.toString();
  }
  void delete() {
    if(sv==null) return;
    this.fb.delete(sv!.id.toString());
    Navigator.pop(context);
  }
  void addButtonPressed(){
    if(_formkey.currentState!.validate()){
      this.info= new ServiceModel(
          name :this.nameController.text,
          charge: this.chargeController.text,
          type: type,
          detail: noteController.text
      );
      if(this.buttonText!='Thêm Dịch Vụ')
      this.fb.update(widget.sv!.id.toString(), this.nameController.text, this.noteController.text, this.chargeController.text, type);
      Navigator.pop(context,this.info);
    }
    else {
      setState(() {
      });
    }
  }


  StateAddPage({this.sv}){

    print(this.sv?.name != null?this.sv?.name.toString():'');
  }
  _nameTextField() => TextFormField(

    style: MyStyle().style_text_tff(),
    controller: this.nameController,
    decoration: InputDecoration(
      hintText:  'Diện,Nước,Thang máy,bảo vệ,..',
    ),
    keyboardType: TextInputType.name,
    validator: (val) {
      if (val!.isEmpty) {
        return "Vui lòng nhập tên";
      }

      return null;
    },
  );
  _dropDownList()=> DropdownButtonFormField(
    value: type,
    iconSize: 36 ,
    onChanged: (String? temp){
      setState(() {
        this.type=temp.toString();
      });
    },
    items:this.chargeType.map(( type) {
      return DropdownMenuItem<String>(
        value: type,
        child: Text(type,style: MyStyle().style_text_tff(),),
      );
    }).toList(),

  );
  _chargeTextField() => TextFormField(
    style: MyStyle().style_text_tff(),
    controller: this.chargeController,
    decoration: InputDecoration(
      hintText:  'O VND',
    ),
    keyboardType: TextInputType.number,
  );
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text(buttonText, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Card(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TitleInfoNotNull(text: "Tên dịch vụ"),
                      _nameTextField(),
                      SizedBox(height: 30,),

                      TitleInfoNotNull(text: "Thu phí dựa trên"),
                      _dropDownList(),
                      SizedBox(height: 30,),
                      TitleInfoNull(text:  'Phi dịch vụ'),
                      _chargeTextField(),
                      SizedBox(height: 30,),
                    ],
                  ),
                ),
              ),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TitleInfoNull(text: 'Ghi chú'),
                      TextField(
                        style: MyStyle().style_text_tff(),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1,color: Colors.grey.shade300),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                          hintText: 'Nhập ghi chú',
                        ),
                        minLines: 5,
                        maxLines: 8,
                        controller: this.noteController,
                        keyboardType: TextInputType.multiline,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 30,),
              MainButton(name:buttonText, onpressed: this.addButtonPressed ),
            ],
          ),
        ),
      ),
    );
    throw UnimplementedError();
  }
}
