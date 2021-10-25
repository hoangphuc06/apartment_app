import 'package:apartment_app/src/fire_base/fb_contract.dart';
import 'package:apartment_app/src/model/task.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:flutter/material.dart';

class EditContractPage extends StatefulWidget {
  // const EditContractPage({ Key? key }) : super(key: key);
  final String id;
  EditContractPage({required this.id});

  @override
  _EditContractPageState createState() => _EditContractPageState();
}

class _EditContractPageState extends State<EditContractPage> {

  ContractFB contractFB = new ContractFB();

  String? _roomPaymentPeriodController = "1 Tháng";

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _hostController = TextEditingController();
  final TextEditingController _roomController = TextEditingController();
  final TextEditingController _startDayController = TextEditingController();
  final TextEditingController _expirationDateController =
      TextEditingController();
  final TextEditingController _billingStartDateController =
      TextEditingController();
  final TextEditingController _roomChargeController = TextEditingController();
  final TextEditingController _depositController = TextEditingController();
  final TextEditingController _renterController = TextEditingController();
  final TextEditingController _rulesController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  Task task = new Task();
  DateTime selectedDate = DateTime.now();

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

  void binding() {
    setState((){
      contractFB.collectionReference.doc(widget.id).get().then((value) => {
            _hostController.text = value["host"],
            _roomController.text = value["room"],
            _startDayController.text = value["startDay"],
            _expirationDateController.text = value["expirationDate"],
            _billingStartDateController.text = value["billingStartDate"],
            _roomPaymentPeriodController = value["roomPaymentPeriod"],
            _roomChargeController.text = value["roomCharge"],
            _depositController.text = value["deposit"],
            _renterController.text = value["renter"],
            _rulesController.text = value["rules"]
      }
      );
    }
    );
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
        title: Text("Chỉnh sửa hợp đồng"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0)),
                    color: Colors.grey),
                padding: EdgeInsets.only(left: 15),
                alignment: Alignment.centerLeft,
                width: width,
                height: height * 0.05,
                child: Text(
                  "Thông tin",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Container(
                        child: TextFormField(
                          controller: _hostController,
                          decoration: InputDecoration(
                            labelText: "Đại diện cho thuê",
                          ),
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Vui lòng nhập đại diện cho thuê";
                              ;
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      TextFormField(
                        controller: _roomController,
                        decoration: InputDecoration(
                          labelText: "Chọn phòng",
                        ),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Vui lòng chọn phòng";
                            ;
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: width * 0.4,
                            child: GestureDetector(
                                onTap: () =>
                                    _selectDate(context, _startDayController),
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    controller: _startDayController,
                                    decoration: InputDecoration(
                                      suffixIcon: Padding(
                                        padding: EdgeInsetsDirectional.only(
                                            start: height * 0.025,
                                            top: height * 0.02),
                                        child:
                                            Icon(Icons.calendar_today_outlined),
                                      ),
                                      labelText: "Ngày bắt đầu",
                                    ),
                                    keyboardType: TextInputType.datetime,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Vui lòng nhập ngày bắt đầu thuê";
                                        ;
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                )),
                          ),
                          Container(
                            width: width * 0.4,
                            child: GestureDetector(
                              onTap: () => _selectDate(
                                  context, _expirationDateController),
                              child: AbsorbPointer(
                                child: TextFormField(
                                  controller: _expirationDateController,
                                  decoration: InputDecoration(
                                    suffixIcon: Padding(
                                      padding: EdgeInsetsDirectional.only(
                                          start: height * 0.025,
                                          top: height * 0.02),
                                      child:
                                          Icon(Icons.calendar_today_outlined),
                                    ),
                                    labelText: "Ngày kết thúc",
                                  ),
                                  keyboardType: TextInputType.datetime,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Vui lòng nhập ngày kết thúc thuê";
                                      ;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Container(
                        child: GestureDetector(
                          onTap: () =>
                              _selectDate(context, _billingStartDateController),
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: _billingStartDateController,
                              decoration: InputDecoration(
                                suffixIcon: Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      start: height * 0.025,
                                      top: height * 0.02),
                                  child: Icon(Icons.calendar_today_outlined),
                                ),
                                labelText: "Ngày bắt đầu tính tiền",
                              ),
                              keyboardType: TextInputType.datetime,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Vui lòng nhập ngày bắt đầu tính tiền";
                                  ;
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Container(
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                              labelText: "Kỳ thanh toán tiền phòng"),
                          value: _roomPaymentPeriodController,
                          items: [
                            "1 Tháng",
                            "2 Tháng",
                            "3 Tháng",
                            "4 Tháng",
                            "5 Tháng",
                            "6 Tháng",
                            "7 Tháng",
                            "8 Tháng",
                            "9 Tháng",
                            "10 Tháng",
                            "11 Tháng",
                            "12 Tháng"
                          ]
                              .map((label) => DropdownMenuItem(
                                    child: Text(label),
                                    value: label,
                                  ))
                              .toList(),
                          hint: Text('Kỳ thanh toán'),
                          onChanged: (value) {
                            setState(() {
                              _roomPaymentPeriodController = value;
                            });
                          },
                        ),
                      ),
                    ],
                  )),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0)),
                    color: Colors.grey),
                padding: EdgeInsets.only(left: 15),
                alignment: Alignment.centerLeft,
                width: width,
                height: height * 0.05,
                child: Text(
                  "Tiền thuê nhà",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Container(
                        child: TextFormField(
                          controller: _roomChargeController,
                          decoration: InputDecoration(
                            labelText: "Tiền nhà",
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Vui lòng nhập tiền thuê nhà";
                              ;
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      TextFormField(
                        controller: _depositController,
                        decoration: InputDecoration(
                          labelText: "Tiền cọc",
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Vui lòng nhập tiền cọc";
                            ;
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  )),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0)),
                    color: Colors.grey),
                padding: EdgeInsets.only(left: 15),
                alignment: Alignment.centerLeft,
                width: width,
                height: height * 0.05,
                child: Text(
                  "Người thuê",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextFormField(
                  controller: _renterController,
                  decoration: InputDecoration(
                    labelText: "Người thuê",
                  ),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Vui lòng nhập người thuê nhà";
                      ;
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0)),
                    color: Colors.grey),
                padding: EdgeInsets.only(left: 15),
                alignment: Alignment.centerLeft,
                width: width,
                height: height * 0.05,
                child: Text(
                  "Dịch vụ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0)),
                    color: Colors.grey),
                padding: EdgeInsets.only(left: 15),
                alignment: Alignment.centerLeft,
                width: width,
                height: height * 0.05,
                child: Text(
                  "Điều khoản",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextFormField(
                  controller: _rulesController,
                  decoration: InputDecoration(
                    labelText: "Điều khoản",
                  ),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Vui lòng nhập điều khoản thuê nhà thuê nhà";
                      ;
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Container(
                padding: EdgeInsets.only(right: 20, left: 20),
                child: MainButton(name: "Chỉnh sửa", onpressed: _onClick),
              ),
              SizedBox(
                height: height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onClick() {
    if (_formKey.currentState!.validate()) _updateContract();
  }

  void _updateContract() {
    contractFB
        .update(
            widget.id,
            _hostController.text,
            _roomController.text,
            _startDayController.text,
            _expirationDateController.text,
            _billingStartDateController.text,
            _roomPaymentPeriodController!,
            _roomChargeController.text,
            _depositController.text,
            _renterController.text,
            _rulesController.text)
        .then((value) => {
              _hostController.clear(),
              _roomController.clear(),
              _startDayController.clear(),
              _expirationDateController.clear(),
              _billingStartDateController.clear(),
              _roomChargeController.clear(),
              _depositController.clear(),
              _renterController.clear(),
              _rulesController.clear(),
              Navigator.pop(context),
            });
  }
}
