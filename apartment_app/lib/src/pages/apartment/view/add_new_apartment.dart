import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/widgets/appbars/my_app_bar.dart';
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

  int dem = 0;

  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  getName() async {
    await FirebaseFirestore.instance.collection('floorinfo').where("floorid",isEqualTo: this.widget.floorid).get().then((value) => {
      dem = value.size,
      print("vi tri 1:" + dem.toString()),
    });

    print("vi tri 2:" + dem.toString());
    return (int.parse(this.widget.floorid)*100 + dem + 1);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getName();
  }

  @override
  Widget build(BuildContext context) {
    print("trong ham main" + getName().toString());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar("Thêm căn hộ"),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _title("Thông tin chi tiết"),

                SizedBox(height: 10,),
                TitleInfoNotNull(text: "Tên căn hộ"),
                SizedBox(height: 10,),
                _nameTextFormField(),

                SizedBox(height: 10,),
                TitleInfoNotNull(text: "Tầng"),
                SizedBox(height: 10,),
                _floorTextFormField(),

                SizedBox(height: 10,),
                TitleInfoNotNull(text: "Loại căn hộ"),
                SizedBox(height: 10,),
                StreamBuilder<QuerySnapshot>(
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
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,),),
                            value: "${snap.id.toString()}",
                          ),
                        );
                      }
                      return
                        Container(
                          padding: MyStyle().padding_container_tff(),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.grey.withOpacity(0.1)
                          ),
                          child: DropdownButtonFormField<Object?>(
                            decoration: InputDecoration(
                              border: InputBorder.none
                            ),
                            items: currentItem,
                            onChanged: (currencyValue){
                              setState(() {
                                selectedCurrency = currencyValue;
                                _categoryController.text = '$currencyValue';
                              });
                            },
                            style: const TextStyle(color: Colors.deepPurple),
                            value: selectedCurrency,
                            validator: (value) => value == null ? 'Vui lòng chọn loại căn hộ' : null,
                            isExpanded: false,
                            hint: new Text('Chọn loại căn hộ                                ',
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                            ),
                          ),
                        );
                    }
                  },
                ),

                SizedBox(height: 30,),
                _title("Khác"),
                SizedBox(height: 10,),
                TitleInfoNull(text: "Ghi chú"),
                SizedBox(height: 10,),
                _note(),


                SizedBox(height: 30,),
                MainButton(
                  name: "Thêm",
                  onpressed: _addRoom,
                ),
                SizedBox(height: 50,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addRoom() {
    if (_formkey.currentState!.validate()) {
      floorInfoFB.add(
        widget.floorid,
        getName().toString(),
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


  _title(String text) => Text(
    text,
    style: TextStyle(
        color: Colors.black.withOpacity(0.5),
        fontWeight: FontWeight.bold
    ),
  );

  _nameTextFormField() => Container(
    padding: MyStyle().padding_container_tff(),
    decoration: MyStyle().style_decoration_container(),
    child: TextFormField(
      decoration: MyStyle().style_decoration_tff(""),
      style: MyStyle().style_text_tff(),
      initialValue: (int.parse(this.widget.floorid)*100 + dem + 1).toString(),
      readOnly: true,
    ),
  );

  _floorTextFormField() => Container(
    padding: MyStyle().padding_container_tff(),
    decoration: MyStyle().style_decoration_container(),
    child: TextFormField(
      decoration: MyStyle().style_decoration_tff(""),
      style: MyStyle().style_text_tff(),
      initialValue: this.widget.floorid,
      readOnly: true,
    ),
  );

  _note() => Container(
    width: double.infinity,
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.grey.withOpacity(0.1),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _noteController,
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
