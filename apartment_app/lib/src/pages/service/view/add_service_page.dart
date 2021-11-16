

import 'package:animated_float_action_button/animated_floating_action_button.dart';
import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/service/model/service_info.dart';
import 'package:apartment_app/src/pages/service/model/service_model.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/appbars/my_app_bar.dart';
import 'package:apartment_app/src/widgets/title/title_info_null.dart';
import 'package:apartment_app/src/widgets/title/title_info_not_null.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:flutter/material.dart';
import 'package:apartment_app/src/pages/service/firebase/fb_service.dart';

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
  String buttonText='Thêm dịch vụ';
  List<String>  chargeType=['Lũy tiền theo chỉ số đồng hồ', 'Dich vụ có chỉ số đầu cuối','Người ','Phòng','Số lần sử dụng','Khác'];
  final _formkey = GlobalKey<FormState>();
  late ServiceModel info;
  ServiceModel? get service=>sv;
  ServiceFB fb = new ServiceFB();

  //---------------------------------------------------
  void filltemplate(ServiceModel? service){
    this.buttonText='Thay đổi thông tin';
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
      if(this.buttonText!='Thêm dịch vụ')
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
  _nameTextField() => Container(
    padding: MyStyle().padding_container_tff(),
    decoration: MyStyle().style_decoration_container(),
    child: TextFormField(
      style: MyStyle().style_text_tff(),
      controller: this.nameController,
      decoration: MyStyle().style_decoration_tff("Nhập tên dịch vụ"),
      keyboardType: TextInputType.name,
      validator: (val) {
        if (val!.isEmpty) {
          return "Vui lòng nhập tên";
        }

        return null;
      },
    ),
  );
  _dropDownList()=> Container(
    padding: MyStyle().padding_container_tff(),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.blueGrey.withOpacity(0.2)
    ),
    child: DropdownButtonFormField(
      decoration: InputDecoration(
          border: InputBorder.none
      ),
      value: type,
      //iconSize: 36 ,
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

    ),
  );
  _chargeTextField() => Container(
    padding: MyStyle().padding_container_tff(),
    decoration: MyStyle().style_decoration_container(),
    child: TextFormField(
      style: MyStyle().style_text_tff(),
      controller: this.chargeController,
      decoration: MyStyle().style_decoration_tff("Nhập phí dịch vụ"),
      keyboardType: TextInputType.number,
    ),
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
      backgroundColor: Colors.white,
      appBar: myAppBar(buttonText),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _title("Thông tin chi tiết"),
                      SizedBox(height: 10,),

                      TitleInfoNotNull(text: "Tên dịch vụ"),
                      SizedBox(height: 10,),
                      _nameTextField(),
                      SizedBox(height: 10,),

                      TitleInfoNotNull(text: "Thu phí dựa trên"),
                      SizedBox(height: 10,),
                      _dropDownList(),
                      SizedBox(height: 10,),
                      TitleInfoNotNull(text:  "Phí dịch vụ"),
                      SizedBox(height: 10,),
                      _chargeTextField(),
                      SizedBox(height: 30,),
                      _title("Khác"),
                      SizedBox(height: 10,),
                      TitleInfoNull(text: "Ghi chú"),
                      SizedBox(height: 10,),
                      _note(),
                      SizedBox(height: 30,),
                      MainButton(name:buttonText, onpressed: this.addButtonPressed ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
    throw UnimplementedError();
  }
  _title(String text) => Text(
    text,
    style: TextStyle(
        color: Colors.black.withOpacity(0.5),
        fontWeight: FontWeight.bold
    ),
  );
  _note() => Container(
    width: double.infinity,
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.blueGrey.withOpacity(0.2),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: this.nameController,
          maxLines: 10,
          minLines: 3,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Nhập ghi chú"
          ),
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400
          ),
        ),
        SizedBox(height: 10,),
      ],
    ),
  );
}
