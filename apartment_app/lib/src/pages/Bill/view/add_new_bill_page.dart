import 'dart:convert';

import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/Bill/firebase/fb_bill.dart';
import 'package:apartment_app/src/pages/Bill/model/sevice_model.dart';
import 'package:apartment_app/src/pages/apartment/firebase/fb_service_apartment.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_contract.dart';
import 'package:apartment_app/src/pages/contract/model/contract_model.dart';
import 'package:apartment_app/src/pages/contract/view/selectRoom.dart';
import 'package:apartment_app/src/pages/service/firebase/fb_service.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:apartment_app/src/widgets/title/title_info_not_null.dart';
import 'package:apartment_app/src/widgets/title/title_info_null.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:apartment_app/src/fire_base/fb_floor_info.dart';
import 'package:select_form_field/select_form_field.dart';

class AddBillPage extends StatefulWidget {
  // const AddBillPage({Key? key}) : super(key: key);
  late String id;

  AddBillPage({required this.id});

  @override
  _AddBillPageState createState() => _AddBillPageState();
}

class _AddBillPageState extends State<AddBillPage> {
  late String _id;
  List<Sevice> SeviceItem = [];
  ContractFB contractFB = new ContractFB();
  ServiceApartmentFB serviceApartmentFB = new ServiceApartmentFB();
  ServiceFB serviceFB = new ServiceFB();
  Object? selectedCurrency;

  void getCategory(String id) {
    final sevicefb = FirebaseFirestore.instance.collection('sevice');
  }

  final _fomkey = GlobalKey<FormState>();

  final TextEditingController _fine = TextEditingController();
  final TextEditingController _discount = TextEditingController();
  final TextEditingController _noteControler = TextEditingController();
  final TextEditingController _chargeRoom = TextEditingController();
  final TextEditingController _roomidcontroler = TextEditingController();
  final TextEditingController _billdatecontroler = TextEditingController();
  final TextEditingController _billmonthcontroler = TextEditingController();
  final TextEditingController _billyearcontroler = TextEditingController();
  final TextEditingController _servicecontroler = TextEditingController();
  final TextEditingController _statuscontroler = TextEditingController();
  final TextEditingController _startDayController = TextEditingController();
  final TextEditingController _startIndexW = TextEditingController();
  final TextEditingController _endIndexW = TextEditingController();
  final TextEditingController _startIndexE = TextEditingController();
  final TextEditingController _endIndexE = TextEditingController();
  final TextEditingController _totalE = TextEditingController();
  final TextEditingController _totalW = TextEditingController();
  final TextEditingController _chargeE = TextEditingController();
  final TextEditingController _chargeW = TextEditingController();
  final TextEditingController _Total = TextEditingController();
  final TextEditingController _TotalWE = TextEditingController();
  final TextEditingController _FinalTotal = TextEditingController();
  final TextEditingController _expirationDateController =
      TextEditingController();
  bool isSelectRoom = false;
  int temp = 0;
  DateTime selectedDate = new DateTime.now();
  Contract contract = new Contract();
  final TextEditingController serviceFee = TextEditingController();
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
    var now = DateTime.now();
    var start_date =
        "${now.toLocal().day}/${now.toLocal().month}/${now.toLocal().year}";
    contractFB.collectionReference
        .where('room', isEqualTo: this.widget.id)
        .get()
        .then((value) => {
              _startDayController.text = value.docs[0]['startDay'],
              _chargeRoom.text = value.docs[0]['roomCharge'],
            });
    var lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    var last_date =
        "${lastDayOfMonth.toLocal().day}/${lastDayOfMonth.toLocal().month}/${lastDayOfMonth.toLocal().year}";
    _expirationDateController.text = last_date;
    _billdatecontroler.text = start_date;
    _roomidcontroler.text = this.widget.id;
    _totalW.text = '0';
    _totalE.text = '0';
    _Total.text = '0';
    _TotalWE.text = '0';
    _FinalTotal.text = '0';
    serviceFee.text = '0';
    super.initState();
    _discount.text = '0';
    _fine.text = '0';
  }

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
                                      onTap: () => {},
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
                                child: TextFormField(
                                  decoration: InputDecoration(enabled: false),
                                  controller: _chargeRoom,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17,
                                      color: Colors.black),
                                ),
                              ),
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
                            _title("Điện - Nước"),
                            SizedBox(
                              height: 20,
                            ),
                            _services_startend_index(
                                "Điện",
                                '10000 đ/kwh',
                                width,
                                _totalE,
                                _startIndexE,
                                _endIndexE,
                                _chargeE,
                                Icons.flash_on_outlined,
                                'đ/kwh'),
                            SizedBox(
                              height: 20,
                            ),
                            _services_startend_index(
                                "Nước",
                                '10000 đ/m3',
                                width,
                                _totalW,
                                _startIndexW,
                                _endIndexW,
                                _chargeW,
                                Icons.invert_colors,
                                'đ/m3'),
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
                      _title("Dịch vụ"),
                      StreamBuilder(
                          stream: serviceApartmentFB.collectionReference
                              .where('idRoom', isEqualTo: widget.id)
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: _CardNull("Dịch vụ"),
                              );
                            } else {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, i) {
                                    QueryDocumentSnapshot x =
                                        snapshot.data!.docs[i];

                                    return Container(
                                      child: StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection("ServiceInfo")
                                              .where('id',
                                                  isEqualTo: x["idService"])
                                              .snapshots(),
                                          builder: (context,
                                              AsyncSnapshot<QuerySnapshot>
                                                  snapshot) {
                                            if (!snapshot.hasData) {
                                              return Center(child: Text(""));
                                            } else {
                                              QueryDocumentSnapshot y =
                                                  snapshot.data!.docs[0];

                                              return _services_month(y['name'],
                                                  width, y['charge']);
                                            }
                                          }),
                                    );
                                  });
                            }
                          }),
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
                      _title("Tổng hợp"),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tiền phòng',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                            ),
                          ),
                          Container(
                            width: width * 0.25,
                            child: TextFormField(
                              decoration: InputDecoration(enabled: false),
                              controller: _chargeRoom,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _textinRow("Điện - Nước", FontWeight.w400,
                          FontWeight.w700, Colors.black, _TotalWE, 16),
                      SizedBox(
                        height: 20,
                      ),
                      _textinRow("Dịch vụ", FontWeight.w400, FontWeight.w700,
                          Colors.black, serviceFee, 16),
                      SizedBox(
                        height: 20,
                      ),
                      _textinRow("Tổng", FontWeight.w400, FontWeight.w700,
                          Colors.black, _Total, 16),
                      SizedBox(
                        height: 20,
                      ),
                      _textFormFieldinRow(
                          _fine, "Tiền phạt", width, Colors.black),
                      SizedBox(
                        height: 20,
                      ),
                      _textFormFieldinRow(_discount, "Giảm giá", width, myRed),
                      SizedBox(
                        height: 20,
                      ),
                      _textinRow("Thanh toán", FontWeight.w500, FontWeight.w700,
                          myGreen, _FinalTotal, 18),
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
                        controller: _noteControler,
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
                child: MainButton(name: "Thêm", onpressed: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _services_startend_index(
      String name,
      String charge,
      double width,
      TextEditingController total,
      TextEditingController controllerStart,
      TextEditingController controllerEnd,
      TextEditingController controllerCharge,
      IconData icon,
      String unit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text(
              'Đơn giá(' + unit + ')',
              style: TextStyle(
                color: myGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              " *",
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
          ],
        ),
        TextFormField(
          style: MyStyle().style_text_tff(),
          controller: controllerCharge,
          onChanged: (value) {
            setState(() {
              if (!(controllerEnd.text.isEmpty &&
                  controllerStart.text.isEmpty &&
                  controllerCharge.text.isEmpty)) {
                total.text = (((int.parse(controllerEnd.text) -
                            int.parse(controllerStart.text))) *
                        int.parse(controllerCharge.text))
                    .toString();

                _FinalTotal.text = _Total.text;
                serviceFee.text = temp.toString();
                _TotalWE.text =
                    (int.parse(_totalW.text) + int.parse(_totalE.text))
                        .toString();
                _Total.text = (int.parse(_TotalWE.text) +
                        int.parse(_chargeRoom.text) +
                        int.parse(serviceFee.text))
                    .toString();
              }
            });
          },
          decoration: InputDecoration(
            hintText: 'Đơn giá',
            suffixIcon: Padding(
              padding: EdgeInsetsDirectional.all(0),
              child: Icon(icon),
            ),
          ),
          keyboardType: TextInputType.datetime,
          validator: (value) {
            if (value!.isEmpty) {
              return "Vui lòng nhập đơn giá";
            } else {
              return null;
            }
          },
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Chọn ngày bắt đầu
            Container(
              width: width * 0.4,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Chỉ số đầu',
                        style: TextStyle(
                          color: myGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        " *",
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ],
                  ),
                  TextFormField(
                    style: MyStyle().style_text_tff(),
                    controller: controllerStart,
                    onChanged: (value) {
                      setState(() {
                        if (!(controllerEnd.text.isEmpty &&
                            controllerStart.text.isEmpty &&
                            controllerCharge.text.isEmpty)) {
                          total.text = (((int.parse(controllerEnd.text) -
                                      int.parse(controllerStart.text))) *
                                  int.parse(controllerCharge.text))
                              .toString();
                          _TotalWE.text = (int.parse(_totalW.text) +
                                  int.parse(_totalE.text))
                              .toString();
                          _Total.text = (int.parse(_TotalWE.text) +
                                  int.parse(_chargeRoom.text) +
                                  int.parse(serviceFee.text))
                              .toString();
                          _FinalTotal.text = _Total.text;
                        }
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Chỉ số đầu',
                      suffixIcon: Padding(
                        padding: EdgeInsetsDirectional.all(0),
                        child: Icon(icon),
                      ),
                    ),
                    keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Vui lòng nhập chỉ số đầu";
                      } else {
                        return null;
                      }
                    },
                  ),
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
                  Row(
                    children: [
                      Text(
                        'Chỉ số cuối',
                        style: TextStyle(
                          color: myGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        " *",
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ],
                  ),
                  TextFormField(
                    style: MyStyle().style_text_tff(),
                    controller: controllerEnd,
                    onChanged: (value) {
                      setState(() {
                        if (!(controllerEnd.text.isEmpty &&
                            controllerStart.text.isEmpty &&
                            controllerCharge.text.isEmpty)) {
                          total.text = (((int.parse(controllerEnd.text) -
                                      int.parse(controllerStart.text))) *
                                  int.parse(controllerCharge.text))
                              .toString();
                          _TotalWE.text = (int.parse(_totalW.text) +
                                  int.parse(_totalE.text))
                              .toString();
                          _Total.text = (int.parse(_TotalWE.text) +
                                  int.parse(_chargeRoom.text) +
                                  int.parse(serviceFee.text))
                              .toString();
                          _FinalTotal.text = _Total.text;
                        }
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Chỉ số cuối',
                      suffixIcon: Padding(
                        padding: EdgeInsetsDirectional.all(0),
                        child: Icon(icon),
                      ),
                    ),
                    keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Vui lòng nhập chỉ số cuối";
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        _textinRow("Thành tiền", FontWeight.w400, FontWeight.w700, Colors.black,
            total, 17),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  _services_month(String name, double width, String total) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'đ/tháng',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),
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
              "Thành tiền",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
            ),
            Text(
              total,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                  color: Colors.black),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
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
  _textFormFieldinRow(TextEditingController controller, String text,
          double width, Color color) =>
      Row(
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
              controller: controller,
              textAlign: TextAlign.center,
              onChanged: (value) {
                if (!(_Total.text.isEmpty &&
                    !_fine.text.isEmpty &&
                    _discount.text.isEmpty)) {
                  setState(() {
                    _FinalTotal.text = (int.parse(_Total.text) +
                            int.parse(_fine.text) -
                            int.parse(_discount.text))
                        .toString();
                  });
                }
              },
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      );
  _textinRow(String text, FontWeight fontWeight1, FontWeight fontWeight2,
          Color color, TextEditingController total, double fontsize) =>
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
            total.text,
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
}
