import 'dart:convert';

import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/Bill/firebase/fb_bill.dart';
import 'package:apartment_app/src/pages/Bill/model/sevice_model.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_contract.dart';
import 'package:apartment_app/src/pages/contract/model/contract_model.dart';
import 'package:apartment_app/src/pages/contract/view/selectRoom.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:apartment_app/src/widgets/title/title_info_not_null.dart';
import 'package:apartment_app/src/widgets/title/title_info_null.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:apartment_app/src/fire_base/fb_floor_info.dart';
import 'package:select_form_field/select_form_field.dart';

class AddBillPage extends StatefulWidget {
  const AddBillPage({Key? key}) : super(key: key);

  @override
  _AddBillPageState createState() => _AddBillPageState();
}

class _AddBillPageState extends State<AddBillPage> {
  late String _id;
  List<Sevice> SeviceItem = [];
  ContractFB contractFB = new ContractFB();

  Object? selectedCurrency;

  void getCategory(String id) {
    final sevicefb = FirebaseFirestore.instance.collection('sevice');
  }

  final _fomkey = GlobalKey<FormState>();

  final TextEditingController _idcontroler = TextEditingController();
  final TextEditingController _temp = TextEditingController();
  final TextEditingController _chargeRoom = TextEditingController();
  final TextEditingController _roomidcontroler = TextEditingController();
  final TextEditingController _billdatecontroler = TextEditingController();
  final TextEditingController _billmonthcontroler = TextEditingController();
  final TextEditingController _billyearcontroler = TextEditingController();
  final TextEditingController _servicecontroler = TextEditingController();
  final TextEditingController _statuscontroler = TextEditingController();
  final TextEditingController _startDayController = TextEditingController();
  final TextEditingController _expirationDateController =
      TextEditingController();
  bool isSelectRoom = false;
  DateTime selectedDate = new DateTime.now();
  Contract contract = new Contract();
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

  @override
  void initState() {
    // TODO: implement initState
    var date =
        "${DateTime.now().toLocal().day}/${DateTime.now().toLocal().month}/${DateTime.now().toLocal().year}";
    _billdatecontroler.text = date;
    super.initState();
  }
  // void _AddBil() {
  //   if (_fomkey.currentState!.validate()) {
  //     String billdate = _billdatecontroler.text.trim();

  //     apartmentBillInfo
  //         .add(widget.roomid, billdate, _billmonthcontroler.text.trim(),
  //             _billyearcontroler.text.trim())
  //         .then((value) => {
  //               Navigator.pop(context),
  //             });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    bool isNull = true;
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: myGreen,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Thêm hóa đơn",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _fomkey,
          child: Column(
            children: [
              Card(
                  elevation: 2,
                  child: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            _title("Thông tin"),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  TitleInfoNotNull(text: "Ngày lập hóa đơn"),
                                  GestureDetector(
                                      onTap: () {},
                                      child: AbsorbPointer(
                                        child: _textformFieldwithIcon(
                                            _billdatecontroler,
                                            "20/04/2021...",
                                            "ngày bắt đầu tính tiền",
                                            Icons.calendar_today_outlined),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  TitleInfoNotNull(text: "Chọn phòng"),
                                  GestureDetector(
                                      onTap: () => {_gotoPageRoom()},
                                      child: AbsorbPointer(
                                        child: _textformFieldwithIcon(
                                            _roomidcontroler,
                                            "Chọn phòng",
                                            "phòng",
                                            Icons.home),
                                      )),
                                ],
                              ),
                            ),

                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   children: [
                            //     //Chọn ngày bắt đầu
                            //     Container(
                            //       width: width * 0.4,
                            //       child: Column(
                            //         children: [
                            //           TitleInfoNotNull(text: "Ngày thanh toán"),
                            //           GestureDetector(
                            //               onTap: () => _selectDate(
                            //                   context, _startDayController),
                            //               child: AbsorbPointer(
                            //                 child: _textformFieldwithIcon(
                            //                     _startDayController,
                            //                     "Chọn ngày",
                            //                     "ngày thanh toán",
                            //                     Icons.calendar_today_outlined),
                            //               )),
                            //         ],
                            //       ),
                            //     ),

                            //     SizedBox(
                            //       height: 20,
                            //     ),
                            //     //Chọn ngày kết thúc
                            //     Container(
                            //         width: width * 0.4,
                            //         child: Column(
                            //           children: [
                            //             TitleInfoNotNull(
                            //                 text: "Hạn thanh toán"),
                            //             GestureDetector(
                            //                 onTap: () => _selectDate(context,
                            //                     _expirationDateController),
                            //                 child: AbsorbPointer(
                            //                   child: _textformFieldwithIcon(
                            //                       _expirationDateController,
                            //                       "Chọn ngày",
                            //                       "hạn thanh toán",
                            //                       Icons
                            //                           .calendar_today_outlined),
                            //                 )),
                            //           ],
                            //         )),
                            //   ],
                            // ),
                            // isSelectRoom
                            //     ? Card(
                            //         elevation: 2,
                            //         child: Container(
                            //           padding: EdgeInsets.all(16),
                            //           child: Column(
                            //             crossAxisAlignment:
                            //                 CrossAxisAlignment.center,
                            //             children: [
                            //               SizedBox(
                            //                 height: 10,
                            //               ),
                            //               Text('Hợp đồng',
                            //               style: TextStyle(color: myRed,fontWeight: FontWeight.w500),),
                            //               SizedBox(
                            //                 height: 10,
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //       )
                            //     : Container(),
                            SizedBox(
                              height: 10,
                            ),
                          ]))),
              Card(
                elevation: 2,
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      _title("Tiền phòng"),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          TitleInfoNull(text: "Khoảng thời gian"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //Chọn ngày bắt đầu
                              Container(
                                width: width * 0.4,
                                child: Column(
                                  children: [
                                    GestureDetector(
                                        onTap: () {},
                                        child: AbsorbPointer(
                                          child: _textformFieldwithIcon(
                                              _startDayController,
                                              "Chọn ngày",
                                              "ngày thanh toán",
                                              Icons.calendar_today_outlined),
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              //Chọn ngày kết thúc
                              Container(
                                width: width * 0.4,
                                child: Column(
                                  children: [
                                    GestureDetector(
                                        onTap: () {},
                                        child: AbsorbPointer(
                                          child: _textformFieldwithIcon(
                                              _expirationDateController,
                                              "Chọn ngày",
                                              "hạn thanh toán",
                                              Icons.calendar_today_outlined),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tiền phòng',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                ),
                              ),
                              Container(
                                width: width * 0.3,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: TextFormField(
                                    controller: _chargeRoom,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17,
                                        color: Colors.black),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              _CardNull("Dịch vụ"),
              Card(
                elevation: 2,
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      _title("Tổng hợp"),
                      SizedBox(
                        height: 20,
                      ),
                      _textinRow("Tiền phòng", FontWeight.w400, FontWeight.w700,
                          Colors.black, "0", 16),
                      SizedBox(
                        height: 20,
                      ),
                      _textinRow("Dịch vụ", FontWeight.w400, FontWeight.w700,
                          Colors.black, "0", 16),
                      SizedBox(
                        height: 20,
                      ),
                      _textinRow("Tổng", FontWeight.w400, FontWeight.w700,
                          Colors.black, "0", 16),
                      SizedBox(
                        height: 20,
                      ),
                      _textFormFieldinRow("Tiền phạt", width, Colors.black),
                      SizedBox(
                        height: 20,
                      ),
                      _textFormFieldinRow("Giảm giá (%)", width, myRed),
                      SizedBox(
                        height: 20,
                      ),
                      _textinRow("Thanh toán", FontWeight.w500, FontWeight.w700,
                          myGreen, "10000000", 18),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 2,
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      _title("GHI CHÚ"),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        minLines: 2,
                        maxLines: 7,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: 'Ghi chú cho hóa đơn',
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: MainButton(
                    name: "Thêm",
                    onpressed: () {
                      // _AddBil();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _gotoPageRoom() async {
    var id = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SelectRoomContract(
                  status: 'Đang thuê',
                )));
    if (id != null) {
      setState(() {
        _roomidcontroler.text = id;
        isSelectRoom = true;
        contractFB.collectionReference
            .where("room", isEqualTo: id)
            .get()
            .then((value) => {
                  _startDayController.text = value.docs[0]['startDay'],
                  _chargeRoom.text = value.docs[0]['roomCharge']
                });
        // contractFB.collectionReference
        //     .doc(_id)
        //     .get()
        //     .then((value) => {_startDayController.text = value['startDay']});
      
        var now = DateTime.now();
        var lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
        var date =
            "${lastDayOfMonth.toLocal().day}/${lastDayOfMonth.toLocal().month}/${lastDayOfMonth.toLocal().year}";
        _expirationDateController.text = date;
        var temp = _startDayController.text.substring(0, 2);
        var x =  (lastDayOfMonth.toLocal().day-int.parse(temp)+1)/lastDayOfMonth.toLocal().day;
      
   
      });
    }
  }
}

_title(String text) =>
    Text(text, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold));
_textformFieldwithIcon(TextEditingController controller, String hint,
        String text, IconData icon) =>
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
_textFormFieldinRow(String text, double width, Color color) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.w400, fontSize: 16, color: color),
        ),
        Container(
          width: width * 0.25,
          child: TextFormField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
_textinRow(String text, FontWeight fontWeight1, FontWeight fontWeight2,
        Color color, String total, double fontsize) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            fontWeight: fontWeight1,
            fontSize: fontsize,
          ),
        ),
        Text(
          total,
          style: TextStyle(
              fontWeight: fontWeight2, fontSize: fontsize, color: color),
        ),
      ],
    );
_CardNull(String text) {
  return Card(
    elevation: 2,
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          _title(text),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    ),
  );
}
