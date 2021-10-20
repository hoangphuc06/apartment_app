import 'package:apartment_app/src/pages/introduction/firebase/fb_introduction.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditIntroductionPage extends StatefulWidget {
  const EditIntroductionPage({Key? key}) : super(key: key);

  @override
  _EditIntroductionPageState createState() => _EditIntroductionPageState();
}

class _EditIntroductionPageState extends State<EditIntroductionPage> {

  final formKey = GlobalKey<FormState>();

  IntroductionFB introductionFB = new IntroductionFB();

  final TextEditingController _NbPhone1Controller = TextEditingController();
  final TextEditingController _NbPhone2Controller = TextEditingController();
  final TextEditingController _AddressController = TextEditingController();
  final TextEditingController _HeadController = TextEditingController();
  final TextEditingController _LinkController = TextEditingController();


  void _editInfo() {
    introductionFB.update("1",_AddressController.text, _HeadController.text, _LinkController.text,_NbPhone1Controller.text,_NbPhone2Controller.text).then((value) => {
      Navigator.pop(context),
    }).catchError((error)=>{
      print("Lỗi á !"),
    });;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    binding();
  }

  void binding() {
    setState((){
      introductionFB.collectionReference.doc('1').get().then((value) => {
        _NbPhone1Controller.text = value["phoneNumber1"],
        _NbPhone2Controller.text = value["phoneNumber2"],
        _AddressController.text = value["address"],
        _HeadController.text = value["headquarters"],
        _LinkController.text = value["linkPage"],
      }
      );
    }
    );
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
                stream: introductionFB.collectionReference.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if (!snapshot.hasData) {
                    return Center(child: Text("No Data"),);
                  }
                  else{
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
