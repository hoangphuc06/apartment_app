import 'package:apartment_app/src/colors/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:apartment_app/src/fire_base/fb_floor_info.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:apartment_app/src/widgets/title/title_info_not_null.dart';
import 'package:apartment_app/src/widgets/title/title_info_null.dart';
import 'package:flutter/material.dart';

class AddApartmentPage extends StatefulWidget {
  String floorid;
  AddApartmentPage(this.floorid);

  @override
  _AddApartmentPageState createState() => _AddApartmentPageState();
}

class _AddApartmentPageState extends State<AddApartmentPage> {

  final _formkey = GlobalKey<FormState>();

  Object? selectedCurrency;

  FloorInfoFB floorInfoFB = new FloorInfoFB();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _numDwellerController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _floorController.text ='Tầng ' +  widget.floorid;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: myGreen,
        elevation: 0,
        centerTitle: true,
        title:  Text(
          "Thêm căn hộ",
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

                      // Tên căn hộ
                      SizedBox(height: 20,),
                      TitleInfoNotNull(text: "Tên  căn hộ"),
                      _nameTextField(),

                      // Tầng
                      SizedBox(height: 20,),
                      TitleInfoNotNull(text: "Tầng "),
                      _floorTextField(),

                      //Loại phòng
                      SizedBox(height: 20,),
                      TitleInfoNotNull(text: "Loại phòng"),
                      Container(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection('category_apartment').snapshots(),
                          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if(!snapshot.hasData){
                              return Center(child: Text("No Data"),);
                            }
                            else{
                              List<DropdownMenuItem> currentItem=[];
                              for(int i=0; i<snapshot.data!.docs.length; i++)
                              {
                                DocumentSnapshot snap= snapshot.data!.docs[i];
                                currentItem.add(
                                  DropdownMenuItem(child: Text(
                                    snap['name'],
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16),),
                                    value: "${snap.id.toString()}",
                                  ),
                                );
                              }
                              return
                                  Container(
                                    child: DropdownButtonFormField<Object?>(
                                      items: currentItem,
                                      onChanged: (currencyValue){
                                        setState(() {
                                          selectedCurrency = currencyValue;
                                          _categoryController.text = '$currencyValue';
                                        });
                                      },
                                      style: const TextStyle(color: Colors.deepPurple),
                                      value: selectedCurrency,
                                      // underline: Container(
                                      //   height: 2,
                                      //   color: myGreen,
                                      // ),
                                      validator: (value) => value == null ? 'vui lòng chọn loại căn hộ' : null,
                                      isExpanded: false,
                                      hint: new Text('Chọn loại phòng                                ',
                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16),
                                      ),
                                    ),
                                  );
                            }
                          },
                        ),
                      ),

                      //Ghi chú
                      SizedBox(height: 20,),
                      TitleInfoNull(text: "Ghi chú"),
                      SizedBox(height: 10,),
                      _noteTextField(),

                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
              // Nút bấm
              SizedBox(height: 10,),
              MainButton(
                name: "Thêm",
                onpressed: _addRoom,
              ),
              SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }

  void _addRoom() {
    if (_formkey.currentState!.validate()) {
      floorInfoFB.add(
          widget.floorid,
          _nameController.text,
          _categoryController.text,
          '0',
          'Trống',
          _noteController.text,
          )
          .then((value) => {
        Navigator.pop(context),
      });
    }
  }

  _nameTextField() => TextFormField(
    style: MyStyle().style_text_tff(),
    controller: _nameController,
    decoration: InputDecoration(
      hintText: "101, 102,...",
    ),
    keyboardType: TextInputType.number,
    validator: (val) {
      if (val!.isEmpty) {
        return "Vui lòng nhập tên";
      }
      return null;
    },
  );

  _floorTextField() => TextFormField(
    style: MyStyle().style_text_tff(),
    controller: _floorController,
    enabled: false,
    keyboardType: TextInputType.text,
  );

  _noteTextField() => TextFormField(
    style: MyStyle().style_text_tff(),
    maxLines: 5,
    minLines: 2,
    controller: _noteController,
    decoration: InputDecoration(
      hintText: "ghi chú...",
      border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),)
    ),
    keyboardType: TextInputType.text,
  );

}
