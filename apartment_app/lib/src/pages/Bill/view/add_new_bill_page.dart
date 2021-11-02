import 'package:apartment_app/src/pages/Bill/firebase/fb_list_bill_info.dart';
import 'package:apartment_app/src/pages/Bill/model/sevice_model.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:apartment_app/src/fire_base/fb_floor_info.dart';
import 'package:select_form_field/select_form_field.dart';

class BillInfoPage extends StatefulWidget {
  String roomid;
  BillInfoPage(this.roomid);

  @override
  _BillInfoPageState createState() => _BillInfoPageState();
}

class _BillInfoPageState extends State<BillInfoPage> {
  ApartmentBillInfo apartmentBillInfo = new ApartmentBillInfo();

  late  String _selectedID;
  List<Sevice> SeviceItem = [];

  Object? selectedCurrency;

  void getCategory(String id)
  {
    final sevicefb = FirebaseFirestore.instance.collection('sevice');

  }

  final _fomkey = GlobalKey<FormState>();

  final TextEditingController _idcontroler = TextEditingController();
  final TextEditingController _roomidcontroler = TextEditingController();
  final TextEditingController _billdatecontroler = TextEditingController();
  final TextEditingController _billmonthcontroler = TextEditingController();
  final TextEditingController _billyearcontroler = TextEditingController();
  final TextEditingController _servicecontroler = TextEditingController();
  final TextEditingController _statuscontroler = TextEditingController();

  DateTime selectedDate = new DateTime.now();

  void _getDate(){
        selectedDate = DateTime.now();
        _billmonthcontroler.text = selectedDate.month.toString();
        _billyearcontroler.text = selectedDate.year.toString();
        String date = selectedDate.day.toString();
        _billdatecontroler.text = selectedDate.day.toString()+"/"+selectedDate.month.toString()+"/"+selectedDate.year.toString();
  }

  void _AddBil(){
    if(_fomkey.currentState!.validate()){
      String billdate = _billdatecontroler.text.trim();

      apartmentBillInfo.add(widget.roomid, billdate,_billmonthcontroler.text.trim(),_billyearcontroler.text.trim()).then((value) => {
        Navigator.pop(context),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _getDate();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Thêm hóa đơn',style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(
        //padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _fomkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.015,),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 0.5),
                    top: BorderSide(width: 0.5),
                  ),
                ),
                padding: EdgeInsets.only(
                    top: 16, bottom: 16, left: 16, right: 16),
                child: Text(
                  "Thông tin hóa đơn",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(height: size.height * 0.03,),
              Container(
                padding: EdgeInsets.only(left: 16.0),
                child: RichText(
                  text:
                  TextSpan(text: 'Ngày lập hóa đơn',style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                      children: [TextSpan(text: '*',style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18))]),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 8.0,right: 16.0),
                    child: TextFormField(
                      enabled: false,
                      controller: _billdatecontroler,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                          icon: Icon(Icons.calendar_today)
                      ),
                    ),
              ),
              SizedBox(height: size.height * 0.03,),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 0.5),
                    top: BorderSide(width: 0.5),
                  ),
                ),
                padding: EdgeInsets.only(
                    top: 16, bottom: 16, left: 16, right: 16),
                child: Text(
                  "Chi tiết hóa đơn",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(height: size.height * 0.03,),
              Container(
                padding: EdgeInsets.only(left: 16.0),
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dịch vụ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('ServiceInfo').snapshots(),
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
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
                            value: "${snap.id.toString()}",
                          ),
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget> [
                        Icon(Icons.shopping_cart,
                            color: const Color(0xFF000000),
                            size: 16.0),
                        SizedBox(width: 50),
                        DropdownButton<Object?>(
                          items: currentItem,
                          onChanged: (currencyValue){
                              setState(() {
                                selectedCurrency = currencyValue;
                              });
                          },
                          style: const TextStyle(color: Colors.deepPurple),
                          value: selectedCurrency,
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          isExpanded: false,
                          hint: new Text('Chọn dịch vụ ',
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),

              SizedBox(height: size.height * 0.03,),
              Container(
                padding: EdgeInsets.only(left: 16.0),
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Số lượng', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(left: 16.0,right: 16.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                  )
              ),

              SizedBox(height: size.height * 0.03,),
              Container(
                padding: EdgeInsets.only(left: 16.0),
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Đơn giá', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(left: 16.0,right: 16.0),
                  child: TextFormField(
                    enabled: false,
                  )
              ),
              SizedBox(height: size.height * 0.03,),
              Container(
                padding: EdgeInsets.only(left: 16.0),
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tổng tiền', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(left: 16.0,right: 16.0),
                  child: TextFormField(
                    enabled: false,
                  )
              ),
              SizedBox(height: size.height * 0.05,),
              Container(
                padding: EdgeInsets.only(left: 16.0,right: 16.0),
                child: MainButton(
                    name: "Thêm",
                    onpressed:() {
                      _AddBil();
                    }
                ),
              ),
            ],

          ),
        ),
      ),
    );
  }
}