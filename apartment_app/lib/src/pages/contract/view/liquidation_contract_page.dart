import 'dart:ui';

import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_contract.dart';
import 'package:apartment_app/src/model/task.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/title/title_info_not_null.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:steps/steps.dart';

class LiquidationContractPage extends StatefulWidget {
  // const LiquidationContractPage({ Key? key }) : super(key: key);
  final String id;
  LiquidationContractPage({required this.id});
  @override
  _LiquidationContractPageState createState() =>
      _LiquidationContractPageState();
}

class _LiquidationContractPageState extends State<LiquidationContractPage> {
  int _currentStep = 0;
  ContractFB contractFB = new ContractFB();
  Task task = new Task();
  DateTime selectedDate = DateTime.now();

  final TextEditingController _DateController = TextEditingController();
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
    // TODO: implement initState
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
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text("Thanh lý"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: Expanded(
            child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stepper(
            steps: _stepper(height, width),
            type: StepperType.horizontal,
            physics: ClampingScrollPhysics(),
            currentStep: this._currentStep,
            onStepTapped: (step) {
              setState(() {
                this._currentStep = step;
              });
            },
            onStepContinue: () {
              setState(() {
                if (this._currentStep <
                    this._stepper(height, width).length - 1) {
                  this._currentStep = this._currentStep + 1;
                } else {}
              });
            },
            onStepCancel: () {
              setState(() {
                if (this._currentStep > 0) {
                  this._currentStep = this._currentStep - 1;
                } else {
                  this._currentStep = 0;
                }
              });
            },
          ),
        )),
      ),
    );
  }

  List<Step> _stepper(double height, double width) {
    List<Step> _steps = [
      Step(
        title: Text('Chốt dịch vụ cuối'),
        content: Column(
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
                    _title("Hợp đồng #" + widget.id),
                    SizedBox(
                      height: 20,
                    ),
                    TitleInfoNotNull(text: "Ngày thanh lý"),
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
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            Card(
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
                    _title("Dịch vụ"),
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
                    _title("Tổng hợp"),
                    SizedBox(
                      height: 20,
                    ),
                    _textinRow("Tổng tiền", FontWeight.w400, FontWeight.w700,
                        Colors.black, '0 đ', 16),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        isActive: _currentStep >= 0,
        state: StepState.indexed,
      ),
      Step(
        title: Text('Thanh lý'),
        content: Column(
          children: [
            StreamBuilder(
                stream: contractFB.collectionReference
                    .where('id', isEqualTo: widget.id)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text("No Data"),
                    );
                  } else {
                    QueryDocumentSnapshot x = snapshot.data!.docs[0];
                    return Column(
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
                                _title("Tiền khách nợ"),
                                SizedBox(
                                  height: 20,
                                ),
                                _textinColumnRow("Tiền chốt dịch vụ cuối (1)",
                                    x["billingStartDate"], '1000.000 đ'),
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
                                _title("Tiền trả khách"),
                                SizedBox(
                                  height: 20,
                                ),
                                _textinColumnRow("Tiền chốt dịch vụ cuối (1)",
                                    x["billingStartDate"], '1000.000 đ'),
                                SizedBox(
                                  height: 20,
                                ),
                                _textinColumnRow("Tiền phòng",
                                    x["billingStartDate"], '1000.000 đ'),
                                SizedBox(
                                  height: 20,
                                ),
                                _textinColumnRow("Tiền dịch vụ",
                                    x["billingStartDate"], '1000.000 đ'),
                                SizedBox(
                                  height: 20,
                                ),
                                _textinColumnRow("Tiền cọc",
                                    x["billingStartDate"], '1000.000 đ'),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                      ],
                    );
                  }
                }),
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
                    _textinRow("Tiền khách nợ", FontWeight.w400,
                        FontWeight.w700, Colors.black, "1000.000", 16),
                    SizedBox(
                      height: 20,
                    ),
                    _textinRow("Tiền trả khách", FontWeight.w400,
                        FontWeight.w700, Colors.black, "100.000.000", 16),
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
                        hintText: 'Ghi chú cho thanh lý',
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
          ],
        ),
        isActive: _currentStep >= 1,
        state: StepState.disabled,
      ),
    ];
    return _steps;
  }

  _title(String text) =>
      Text(text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  _textformFieldwithIcon(TextEditingController controller, String hint,
          String text, double height, IconData icon) =>
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
}
