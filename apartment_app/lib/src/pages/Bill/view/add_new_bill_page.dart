import 'package:apartment_app/src/pages/Bill/firebase/fb_list_bill_info.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
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

  final _fomkey = GlobalKey<FormState>();

  final TextEditingController _idcontroler = TextEditingController();
  final TextEditingController _roomidcontroler = TextEditingController();
  final TextEditingController _billdatecontroler = TextEditingController();
  final TextEditingController _servicecontroler = TextEditingController();
  final TextEditingController _statuscontroler = TextEditingController();

  DateTime selectedDate = new DateTime.now();

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
        _billdatecontroler.text = date;
      });
  }

  void _AddBil(){
    if(_fomkey.currentState!.validate()){
      String billdate = _billdatecontroler.text.trim();

      apartmentBillInfo.add(widget.roomid, billdate).then((value) => {
        Navigator.pop(context),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                padding: EdgeInsets.only(left: 16.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.0)),
                    color: Colors.lightBlueAccent
                ),
                alignment: Alignment.centerLeft,
                width: size.width,
                height: size.height* 1/15,
                child: Text(
                  "Thông tin hóa đơn",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ),
              SizedBox(height: size.height * 0.03,),
              Container(
                padding: EdgeInsets.only(left: 16.0),
                child: RichText(
                  text:
                  TextSpan(text: 'Chọn ngày lập hóa đơn',style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                      children: [TextSpan(text: '*',style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18))]),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 8.0,right: 16.0),
                child: GestureDetector(
                  onTap: (){
                    _selectDate(context);
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: _billdatecontroler,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                          icon: Icon(Icons.calendar_today)
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.0)),
                    color: Colors.lightBlueAccent
                ),
                padding: EdgeInsets.only(left: 16.0),
                alignment: Alignment.centerLeft,
                width: size.width,
                height: size.height* 1/15,
                child: Text(
                  "Chi tiết hóa đơn",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
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
              Container(
                  padding: EdgeInsets.only(left: 16.0,right: 16.0),
                child: TextFormField(
                      decoration: InputDecoration(

                      ),
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