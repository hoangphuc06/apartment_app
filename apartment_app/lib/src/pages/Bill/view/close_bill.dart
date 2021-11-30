import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/Bill/firebase/fb_billinfo.dart';
import 'package:apartment_app/src/pages/Bill/model/WE_model.dart';
import 'package:apartment_app/src/pages/Bill/model/billService_model.dart';
import 'package:apartment_app/src/pages/Bill/view/add_new_bill_page.dart';
import 'package:apartment_app/src/pages/apartment/firebase/fb_service_apartment.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_contract.dart';
import 'package:apartment_app/src/pages/service/firebase/fb_service.dart';
import 'package:apartment_app/src/pages/service/model/service_model.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/appbars/my_app_bar.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:apartment_app/src/widgets/title/title_info_not_null.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CloseBill extends StatefulWidget {
  // const CloseBill({ Key? key }) : super(key: key);
  late String id;
  late String liquidation;
  List<String> listContract;
  late String flag;
  CloseBill(
      {required this.id,
      required this.flag,
      required this.liquidation,
      required this.listContract});
  @override
  _CloseBillState createState() => _CloseBillState();
}

class _CloseBillState extends State<CloseBill> {
  final _fomkey = GlobalKey<FormState>();

  final TextEditingController _startIndexW = TextEditingController();
  final TextEditingController _endIndexW = TextEditingController();
  final TextEditingController _startIndexE = TextEditingController();
  final TextEditingController _endIndexE = TextEditingController();
  final TextEditingController _totalE = TextEditingController();
  final TextEditingController _totalW = TextEditingController();
  final TextEditingController _chargeE = TextEditingController();
  final TextEditingController _chargeW = TextEditingController();
  final TextEditingController _TotalWE = TextEditingController();
  final TextEditingController _chargeRoom = TextEditingController();
  final TextEditingController _check = TextEditingController();
  final TextEditingController _deposit = TextEditingController();
  final TextEditingController _startDay = TextEditingController();
  final TextEditingController _type = TextEditingController();
  ContractFB contractFB = new ContractFB();
  ServiceApartmentFB serviceApartmentFB = new ServiceApartmentFB();
  ServiceFB serviceFB = new ServiceFB();
  BillInfoFB billInfoFB = new BillInfoFB();
  List<BillService> listService = <BillService>[];

  Future<void> loadData() async {
    ServiceApartmentFB serviceApartmentFB = new ServiceApartmentFB();
    Stream<QuerySnapshot> query = serviceApartmentFB.collectionReference
        .where('idRoom', isEqualTo: widget.id)
        .snapshots();
    await query.forEach((x) {
      x.docs.asMap().forEach((key, value) {
        var t = x.docs[key];
        serviceFB.collectionReference
            .doc(t['idService'])
            .get()
            .then((value) => {
                  listService.add(
                    BillService(name: value['name'], charge: value['charge']),
                  )
                });
      });
    });
  }

  final TextEditingController _idContract = TextEditingController();
  bool check = false;
  @override
  void initState() {
    _startIndexE.text = '0';
    _startIndexW.text = '0';
    _endIndexE.text = '0';
    _endIndexW.text = '0';
    _chargeE.text = '0';
    _chargeW.text = '0';
    _check.text = '0';
    contractFB.collectionReference
        .where('room', isEqualTo: this.widget.id)
        .where('liquidation', isEqualTo: false)
        .get()
        .then((value) => {
              _chargeRoom.text = value.docs[0]['roomCharge'],
              _deposit.text = value.docs[0]['deposit'],
              _startDay.text = value.docs[0]['startDay'],
              _type.text = value.docs[0]['type'],
              _idContract.text = value.docs[0]['id']
            });
    var now = DateTime.now();
    billInfoFB.collectionReference
        .where('idRoom', isEqualTo: this.widget.id)
        .where('monthBill', isEqualTo: (now.toLocal().month - 1).toString())
        .where('idContract', isEqualTo: _idContract.text)
        .where('yearBill', isEqualTo: now.toLocal().year.toString())
        .get()
        .then((value) => {
              if (value.docs.length != 0)
                {
                  _check.text = '1',
                  _startIndexE.text = value.docs[0]['endE'],
                  _startIndexW.text = value.docs[0]['endW'],
                  _endIndexE.text = value.docs[0]['endE'],
                  _endIndexW.text = value.docs[0]['endW'],
                  _chargeE.text = value.docs[0]['chargeE'],
                  _chargeW.text = value.docs[0]['chargeW'],
                }
            });
    _totalE.text = '0';
    _totalW.text = '0';
    _TotalWE.text = '0';
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: myAppBar("Chốt dịch vụ - điện nước"),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: _fomkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _titletext("Thông tin hợp đồng"),
                    SizedBox(
                      height: 10,
                    ),
                    TitleInfoNotNull(text: "Điện nước"),
                    SizedBox(
                      height: 10,
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
                      height: 30,
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
                      height: 30,
                    ),
                    _titletext("Dịch vụ"),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StreamBuilder(
                              stream: serviceApartmentFB.collectionReference
                                  .where('idRoom', isEqualTo: widget.id)
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return SizedBox(
                                    height: 10,
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
                                                  return Center(
                                                      child: Text(""));
                                                } else {
                                                  QueryDocumentSnapshot y =
                                                      snapshot.data!.docs[0];

                                                  return _services_month(
                                                      y['name'],
                                                      width,
                                                      y['charge']);
                                                }
                                              }),
                                        );
                                      });
                                }
                              }),
                        ],
                      ),
                    ),
                    // Card(
                    //   elevation: 2,
                    //   child: Container(
                    //     padding: EdgeInsets.all(16),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         SizedBox(
                    //           height: 10,
                    //         ),
                    //         _title("Dịch vụ"),
                    //         StreamBuilder(
                    //             stream: serviceApartmentFB.collectionReference
                    //                 .where('idRoom', isEqualTo: widget.id)
                    //                 .snapshots(),
                    //             builder: (context,
                    //                 AsyncSnapshot<QuerySnapshot> snapshot) {
                    //               if (!snapshot.hasData) {
                    //                 return SizedBox(
                    //                   height: 10,
                    //                 );
                    //               } else {
                    //                 return ListView.builder(
                    //                     shrinkWrap: true,
                    //                     physics: ScrollPhysics(),
                    //                     itemCount: snapshot.data!.docs.length,
                    //                     itemBuilder: (context, i) {
                    //                       QueryDocumentSnapshot x =
                    //                           snapshot.data!.docs[i];
                    //
                    //                       return Container(
                    //                         child: StreamBuilder(
                    //                             stream: FirebaseFirestore
                    //                                 .instance
                    //                                 .collection("ServiceInfo")
                    //                                 .where('id',
                    //                                     isEqualTo:
                    //                                         x["idService"])
                    //                                 .snapshots(),
                    //                             builder: (context,
                    //                                 AsyncSnapshot<QuerySnapshot>
                    //                                     snapshot) {
                    //                               if (!snapshot.hasData) {
                    //                                 return Center(
                    //                                     child: Text(""));
                    //                               } else {
                    //                                 QueryDocumentSnapshot y =
                    //                                     snapshot.data!.docs[0];
                    //
                    //                                 return _services_month(
                    //                                     y['name'],
                    //                                     width,
                    //                                     y['charge']);
                    //                               }
                    //                             }),
                    //                       );
                    //                     });
                    //               }
                    //             }),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: MainButton(
                        name: "Chốt dịch vụ & Điện - nước",
                        onpressed: _onClick,
                      ),
                    ),
                  ],
                ))));
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
        TitleInfoNotNull(text: name),
        SizedBox(
          height: 10,
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
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.blueGrey.withOpacity(0.2)),
          child: TextFormField(
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

                  _TotalWE.text =
                      (int.parse(_totalW.text) + int.parse(_totalE.text))
                          .toString();
                }
              });
            },
            decoration: InputDecoration(
              hintText: 'Đơn giá',
              border: InputBorder.none,
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
        ),
        SizedBox(
          height: 10,
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
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.blueGrey.withOpacity(0.2)),
                    child: TextFormField(
                      style: MyStyle().style_text_tff(),
                      controller: controllerStart,
                      enabled: false,
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
                          }
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
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
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.blueGrey.withOpacity(0.2)),
                    child: TextFormField(
                      style: MyStyle().style_text_tff(),
                      controller: controllerEnd,
                      onChanged: (value) {
                        setState(() {
                          if (int.parse(controllerStart.text) <=
                              int.parse(controllerEnd.text)) {
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
                            }
                          } else {
                            total.text = '0';
                          }
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
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
                          if (int.parse(controllerEnd.text) <
                              int.parse(controllerStart.text))
                            return "Chỉ số cuối phải lớn hơn \nchỉ số đầu";
                        }
                      },
                    ),
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
      ],
    );
  }

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
  _title(String text) =>
      Text(text, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold));
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

  void _onClick() {
    if (_fomkey.currentState!.validate()) {
      print(_check.text);
      WE we = WE(
          startE: _startIndexE.text,
          endE: _endIndexE.text,
          chargeE: _chargeE.text,
          totalE: _totalE.text,
          startW: _startIndexW.text,
          endW: _endIndexW.text,
          chargeW: _chargeW.text,
          totalW: _totalW.text,
          totalWE: _TotalWE.text,
          chargeRoom: _chargeRoom.text,
          deposit: _deposit.text,
          startDay: _startDay.text,
          type: _type.text,
          idContract: _idContract.text);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddBillPage(
                    liquidation: widget.liquidation,
                    type: widget.flag,
                    flag: _check.text,
                    id: widget.id,
                    listService: listService,
                    we: we,
                  )));
    }
  }

  _titletext(String text) => Text(
        text,
        style: TextStyle(
            color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.bold),
      );
}
