import 'dart:convert';

import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/Bill/firebase/fb_billService.dart';
import 'package:apartment_app/src/pages/Bill/firebase/fb_billinfo.dart';
import 'package:apartment_app/src/pages/Bill/model/WE_model.dart';
import 'package:apartment_app/src/pages/Bill/model/billService_model.dart';
import 'package:apartment_app/src/pages/apartment/firebase/fb_service_apartment.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_contract.dart';
import 'package:apartment_app/src/pages/contract/model/contract_model.dart';
import 'package:apartment_app/src/pages/service/firebase/fb_service.dart';

import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:apartment_app/src/widgets/title/title_info_not_null.dart';
import 'package:apartment_app/src/widgets/title/title_info_null.dart';

import 'package:flutter/material.dart';

class AddBillPage extends StatefulWidget {
  // const AddBillPage({Key? key}) : super(key: key);
  final List<BillService> listService;
  final type;
  final id;
  final flag;
  final WE we;
  AddBillPage(
      {required this.id,
      required this.flag,
      required this.listService,
      required this.we,
      required this.type});

  @override
  _AddBillPageState createState() => _AddBillPageState();
}

class _AddBillPageState extends State<AddBillPage> {
  BillInfoFB billInfoFB = new BillInfoFB();
  BillServiceFB billServiceFB = new BillServiceFB();
  ContractFB contractFB = new ContractFB();
  ServiceApartmentFB serviceApartmentFB = new ServiceApartmentFB();
  ServiceFB serviceFB = new ServiceFB();
  Object? selectedCurrency;

  final _fomkey = GlobalKey<FormState>();

  final TextEditingController _fine = TextEditingController();
  final TextEditingController _discount = TextEditingController();
  final TextEditingController _noteControler = TextEditingController();
  final TextEditingController _chargeRoom = TextEditingController();
  final TextEditingController _roomidcontroler = TextEditingController();
  final TextEditingController _billdatecontroler = TextEditingController();

  final TextEditingController _startDayController = TextEditingController();

  final TextEditingController _depositController = TextEditingController();

  final TextEditingController _paymentTerm = TextEditingController();

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

  _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        var date =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        controller.text = date;
      });
  }

  @override
  void initState() {
    var now = DateTime.now();
    if (widget.flag == '0') {
      _startDayController.text = widget.we.startDay!;
      _depositController.text = this.widget.we.deposit!;
    } else {
      _depositController.text = '0';
      _startDayController.text = '01/01/' + now.year.toString();
    }
    var a = 0;
    for (int i = 0; i < widget.listService.length; i++) {
      a = a + int.parse(widget.listService[i].charge.toString());
    }
    serviceFee.text = a.toString();

    var start_date =
        "${now.toLocal().day}/${now.toLocal().month}/${now.toLocal().year}";
    _paymentTerm.text = start_date;
    var lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    var last_date =
        "${lastDayOfMonth.toLocal().day}/${lastDayOfMonth.toLocal().month}/${lastDayOfMonth.toLocal().year}";
    if (widget.type == 1 && widget.flag == '1') {
      _chargeRoom.text = '0';
    } else {
      _chargeRoom.text = widget.we.chargeRoom!;
    }

    _expirationDateController.text = last_date;
    _billdatecontroler.text = start_date;
    _roomidcontroler.text = this.widget.id;

    _discount.text = '0';
    _fine.text = '0';
    _TotalWE.text = widget.we.totalWE!;
    _Total.text = (int.parse(_TotalWE.text) +
            int.parse(_depositController.text) +
            int.parse(_chargeRoom.text) +
            int.parse(serviceFee.text))
        .toString();
    _FinalTotal.text = _Total.text;

    super.initState();
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
                              height: 20,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  TitleInfoNotNull(
                                      text: "Hạn thanh toán hóa đơn"),
                                  GestureDetector(
                                      onTap: () =>
                                          _selectDate(context, _paymentTerm),
                                      child: AbsorbPointer(
                                        child: _textformFieldwithIcon(
                                            _billdatecontroler,
                                            "Chọn ngày thanh toán",
                                            "hạn thanh toán hóa đơn",
                                            Icons.calendar_today_outlined),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ]))),
              (widget.flag == '1' && widget.type == '1')
                  ? Container()
                  : Card(
                      elevation: 2,
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            _title("Tiền nhà"),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                TitleInfoNull(text: "Khoảng thời gian"),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                                    Icons
                                                        .calendar_today_outlined),
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
                                                    Icons
                                                        .calendar_today_outlined),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Thành tiền',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 17,
                                      ),
                                    ),
                                    Container(
                                      width: width * 0.3,
                                      child: TextFormField(
                                        decoration:
                                            InputDecoration(enabled: false),
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
              widget.flag == '0'
                  ? Card(
                      elevation: 2,
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            _title("Tiền cọc"),
                            SizedBox(
                              height: 20,
                            ),
                            _textinRow(
                                'Tiền cọc',
                                FontWeight.w400,
                                FontWeight.w700,
                                Colors.black,
                                _depositController,
                                17),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    )
                  : Container(),
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
                      _textinRow("Tiền nhà", FontWeight.w400, FontWeight.w700,
                          Colors.black, _chargeRoom, 16),
                      SizedBox(
                        height: 20,
                      ),
                      widget.flag == '0'
                          ? Column(
                              children: [
                                _textinRow(
                                    "Tiền cọc",
                                    FontWeight.w400,
                                    FontWeight.w700,
                                    Colors.black,
                                    _depositController,
                                    16),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            )
                          : Container(),
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
                padding: EdgeInsets.all(16),
                child: MainButton(name: "Thêm", onpressed: _onClick),
              ),
            ],
          ),
        ),
      ),
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
  void _onClick() {
    if (_fomkey.currentState!.validate()) {
      print(widget.type);
      _addBill();
    }
  }

  void _addBill() {
    var count = 0;
    var now = DateTime.now();
    var id = (new DateTime.now().microsecondsSinceEpoch);
    if (widget.listService.length != 0)
      for (int i = 0; i < widget.listService.length; i++) {
        billServiceFB.add(
            (id + i).toString(),
            id.toString(),
            widget.listService[i].name.toString(),
            widget.listService[i].charge.toString());
      }
    billInfoFB
        .add(
            id.toString(),
            widget.id,
            _billdatecontroler.text,
            now.toLocal().month.toString(),
            now.toLocal().year.toString(),
            _paymentTerm.text,
            _depositController.text,
            _discount.text,
            _fine.text,
            _noteControler.text,
            _chargeRoom.text,
            serviceFee.text,
            "Chưa thanh toán",
            widget.we.startE!,
            widget.we.endE!,
            widget.we.chargeE!,
            widget.we.totalE!,
            widget.we.startW!,
            widget.we.endW!,
            widget.we.chargeW!,
            widget.we.totalW!,
            _FinalTotal.text,
            _startDayController.text,
            _expirationDateController.text)
        .then((value) => {
              _billdatecontroler.clear(),
              _discount.clear(),
              _fine.clear(),
              _noteControler.clear(),
              _chargeRoom.clear(),
              serviceFee.clear(),
              _FinalTotal.clear(),
              _expirationDateController.clear(),
              _startDayController.clear(),
              Navigator.popUntil(context, (route) {
                if (widget.type == '0') {
                  return count++ == 3;
                } else {
                  return count++ == 4;
                }
              })
            });
  }
}
