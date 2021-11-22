import 'dart:ui';

import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/Bill/firebase/fb_billService.dart';
import 'package:apartment_app/src/pages/Bill/firebase/fb_billinfo.dart';
import 'package:apartment_app/src/pages/Bill/model/billService_model.dart';
import 'package:apartment_app/src/pages/Bill/view/close_bill.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_contract.dart';
import 'package:apartment_app/src/model/task.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_rentedRoom.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_renter.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/appbars/my_app_bar.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:apartment_app/src/widgets/title/title_info_not_null.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:steps/steps.dart';

class LiquidationContractPage extends StatefulWidget {
  // const LiquidationContractPage({ Key? key }) : super(key: key);
  final String id;
  final String flag;
  final String idBill;
  LiquidationContractPage(
      {required this.id, required this.flag, required this.idBill});
  @override
  _LiquidationContractPageState createState() =>
      _LiquidationContractPageState();
}

class _LiquidationContractPageState extends State<LiquidationContractPage> {
  int _currentStep = 0;
  ContractFB contractFB = new ContractFB();
  BillInfoFB billInfoFB = new BillInfoFB();
  BillServiceFB billServiceFB = new BillServiceFB();
  RentedRoomFB rentedRoomFB = new RentedRoomFB();

  Task task = new Task();
  DateTime selectedDate = DateTime.now();
  final TextEditingController _DateController = TextEditingController();
  final TextEditingController _idRoom = TextEditingController();
  String? _billingStartDateController;
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
    contractFB.collectionReference
        .doc(widget.id)
        .get()
        .then((value) => {_idRoom.text = value['room']});
    super.initState();
    binding();
  }

  var dateNow =
      "${DateTime.now().toLocal().day}/${DateTime.now().toLocal().month}/${DateTime.now().toLocal().year}";

  void binding() {
    setState(() {
      _DateController.text = dateNow;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar("Thanh lý"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title("Hợp đồng #" + widget.id),
            SizedBox(
              height: 10,
            ),
            TitleInfoNotNull(text: "Ngày thanh lý"),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () => _selectDate(context, _DateController),
                child: AbsorbPointer(
                  child: _textformFieldwithIcon(
                      _DateController,
                      "20/04/2021...",
                      "ngày thanh lý",
                      height,
                      Icons.calendar_today_outlined),
                )),
            SizedBox(
              height: 30,
            ),
            widget.flag == '1'
                ? SingleChildScrollView(
                    child: StreamBuilder(
                        stream: billInfoFB.collectionReference
                            .where('idBillInfo', isEqualTo: this.widget.idBill)
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: Text("No Data"),
                            );
                          } else {
                            QueryDocumentSnapshot x = snapshot.data!.docs[0];
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //thông tin hợp đồng
                                  _titletext("Hóa đơn"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _detail("Số hóa đơn", x["idBillInfo"]),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _detail("Ngày lập hóa đơn", x["billDate"]),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _detail("Phòng", x["idRoom"]),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _detail("Khoảng thời gian",
                                      x["startBill"] + ' - ' + x['endBill']),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _detail("Hạn thanh toán", x["paymentTerm"]),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  _titletext("Dịch vụ"),

                                  StreamBuilder(
                                      stream: billServiceFB.collectionReference
                                          .where('idBillinfo',
                                              isEqualTo: this.widget.idBill)
                                          .snapshots(),
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (!snapshot.hasData) {
                                          return Container();
                                        } else {
                                          return ListView.builder(
                                              shrinkWrap: true,
                                              physics: ScrollPhysics(),
                                              itemCount:
                                                  snapshot.data!.docs.length,
                                              itemBuilder: (context, i) {
                                                QueryDocumentSnapshot y =
                                                    snapshot.data!.docs[i];
                                                return Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    _detail(
                                                        y['nameService'],
                                                        y['chargeService'] +
                                                            ' đ'),
                                                  ],
                                                );
                                              });
                                        }
                                      }),

                                  SizedBox(
                                    height: 20,
                                  ),
                                  _titletext("Tổng hợp"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _detail("Tiền phòng", x["roomCharge"] + ' đ'),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _detail(
                                      "Tiền dịch vụ", x["serviceFee"] + ' đ'),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _detail(
                                      "Tiền cọc hợp đồng", x["deposit"] + ' đ'),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _detail("Trả thêm/phạt", x["fine"] + ' đ'),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _detail("Giảm giá", x["discount"] + ' đ'),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _detail("Tổng", x["total"] + ' đ'),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ]);
                          }
                        }),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _titletext("Hóa đơn"),
                      SizedBox(
                        height: 20,
                      ),
                      _titletext("Dịch vụ"),
                      SizedBox(
                        height: 20,
                      ),
                      _titletext("Tổng hợp"),
                    ],
                  ),
            SizedBox(
              height: 20,
            ),
            widget.flag == '1'
                ? Container(
                    child: MainButton(
                        name: "Thanh lý",
                        onpressed: () {
                          _onClick();
                        }),
                  )
                : Container(
                    child: MainButton(
                        name: "Chốt hóa đơn cuối",
                        onpressed: () {
                          print(_idRoom.text);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CloseBill(
                                        id: _idRoom.text,
                                        flag: '1',
                                      )));
                        }),
                  ),
          ],
        ),
      ),
    );
  }

  _title(String text) =>
      Text(text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  _textformFieldwithIcon(TextEditingController controller, String hint,
          String text, double height, IconData icon) =>
      Container(
        padding: MyStyle().padding_container_tff(),
        decoration: MyStyle().style_decoration_container(),
        child: TextFormField(
          style: MyStyle().style_text_tff(),
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
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
        ),
      );
  _textinColumnRow(String text, String startday, String total) => Container(
        padding: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Từ " + startday + " đến " + dateNow.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        color: Colors.grey),
                  ),
                ),
              ],
            ),
            Text(
              total,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ],
        ),
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
  _titletext(String text) => Text(
        text,
        style: TextStyle(
            color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.bold),
      );
  _detail(String name, String detail) => Container(
        padding: EdgeInsets.all(8),
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.blueGrey.withOpacity(0.2)),
        child: Row(
          children: [
            Text(
              name,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Text(
              detail,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );
  _titletextblack(String text) => Text(
        text,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      );
  _titletextred(String text) => Text(
        text,
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      );
  _nameTextFormField() => Container(
        padding: MyStyle().padding_container_tff(),
        decoration: MyStyle().style_decoration_container(),
        child: TextFormField(
          decoration: MyStyle().style_decoration_tff(""),
          style: MyStyle().style_text_tff(),
        ),
      );
  _detailtotal(String name, String detail) => Container(
        padding: EdgeInsets.all(8),
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.blueGrey.withOpacity(0.2)),
        child: Row(
          children: [
            Text(
              name,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Text(
              detail,
              style: TextStyle(color: myGreen, fontWeight: FontWeight.w500),
            ),
          ],
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
              maxLines: 10,
              minLines: 3,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "Ghi chú cho thanh lý"),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      );

  void _onClick() {
    var count = 0;
    contractFB.liquidation(widget.id);
    rentedRoomFB.collectionReference
        .where('idRoom', isEqualTo: _idRoom.text)
        .where('expired', isEqualTo: false)
        .get()
        .then((value) => {
              print(value.docs[0]['id']),
              rentedRoomFB.liquidation(value.docs[0]['id'])
            });
    Navigator.popUntil(context, (route) {
      return count++ == 2;
    });
  }
}
