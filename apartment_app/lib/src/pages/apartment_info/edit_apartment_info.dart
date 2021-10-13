import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:flutter/material.dart';
import 'package:apartment_app/src/fire_base/fb_apartment_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
class EditApartmentInfo extends StatefulWidget {
  const EditApartmentInfo({ Key? key }) : super(key: key);

  @override
  _EditApartmentInfoState createState() => _EditApartmentInfoState();
}

class _EditApartmentInfoState extends State<EditApartmentInfo> {
  
  final formKey = GlobalKey<FormState>();
  ApartmentInfoFB apartmentInfoFB = new ApartmentInfoFB();

  final TextEditingController _NbPhone1Controller = TextEditingController();
  final TextEditingController _NbPhone2Controller = TextEditingController();
  final TextEditingController _AddressController = TextEditingController();
  final TextEditingController _HeadController = TextEditingController();
  final TextEditingController _LinkController = TextEditingController();


  void _editInfo() {
    apartmentInfoFB.update("0",_AddressController.text, _HeadController.text, _LinkController.text,_NbPhone1Controller.text,_NbPhone2Controller.text).then((value) => {
       Navigator.pop(context),
    }).catchError((error)=>{
      print("Lỗi á !"),
    });;
  }

  void binding(QueryDocumentSnapshot x) {
    _NbPhone1Controller.text = x["phoneNumber1"];
    _NbPhone2Controller.text = x["phoneNumber2"];
    _AddressController.text = x["address"];
    _HeadController.text = x["headquarters"];
    _LinkController.text = x["linkPage"];
  }

  @override
  Widget build(BuildContext context) {

    final double height= MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text("Chỉnh sửa thông tin"),
        ),
      body: 
       Container(
        margin: EdgeInsets.all(25),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child:StreamBuilder(
              stream: apartmentInfoFB.collectionReference.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                if (!snapshot.hasData) {
                  return Center(child: Text("No Data"),);
                }
                else{
                  QueryDocumentSnapshot x = snapshot.data!.docs[0];
                  binding(x);
                  return   
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Hotline 1",
                          
                        ),
                        controller: _NbPhone1Controller,
                        keyboardType: TextInputType.number,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Vui lòng nhập hotline 1";;
                          }
                          else{
                            return null;
                          }
                        },
                      ),
                      SizedBox(height:height *0.03,),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Hotline 2",

                        ),
                        controller: _NbPhone2Controller,
                        keyboardType: TextInputType.number,
                        validator: (value){
                          if(value!.isEmpty ){
                            return "Vui lòng nhập hotline 2";;
                          }
                          else{
                            return null;
                          }
                        },
                      ),
                      SizedBox(height:height *0.03,),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Liên kết trang web",

                        ),
                        controller: _LinkController,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Vui lòng nhập liên kết";
                          }
                          else{
                            return null;
                          }
                        },
                      ),
                      SizedBox(height:height *0.03,),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Trụ sở",

                        ),
                        controller: _HeadController,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Vui lòng nhập trụ sở";
                          }
                          else{
                            return null;
                          }
                        },
                      ),
                      SizedBox(height:height *0.03,),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Địa chỉ ",

                        ),
                        controller: _AddressController,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Vui lòng nhập địa chỉ";
                          }
                          else{
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: height*0.06,),
                      MainButton(
                        name: 'Xác nhận',
                        onpressed: _onLoginClick,
                      ),
                    ],
                  );
                }
              }
              
          
          ),
          ),
        ),
      ), 
    );
  }

  void _onLoginClick() {
    if(formKey.currentState!.validate()){
      _editInfo();
    }
  }
}


     