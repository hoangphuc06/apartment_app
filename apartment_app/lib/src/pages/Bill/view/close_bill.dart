import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/Bill/view/add_new_bill_page.dart';
import 'package:apartment_app/src/pages/apartment/firebase/fb_service_apartment.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_contract.dart';
import 'package:apartment_app/src/pages/service/firebase/fb_service.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CloseBill extends StatefulWidget {
  // const CloseBill({ Key? key }) : super(key: key);
  late String id;

  CloseBill({required this.id});
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
  ContractFB contractFB = new ContractFB();
  ServiceApartmentFB serviceApartmentFB = new ServiceApartmentFB();
  ServiceFB serviceFB = new ServiceFB();

  List<String> listChargeService = <String>[];

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
            .then((value) => {listChargeService.add(value['charge'])});
      });
    });
  }

  @override
  void initState() {
    contractFB.collectionReference
        .where('room', isEqualTo: this.widget.id)
        .get()
        .then((value) => {
              _chargeRoom.text = value.docs[0]['roomCharge'],
            });
    _totalE.text = '0';
    _totalW.text = '0';
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.9),
        appBar: AppBar(
          backgroundColor: myGreen,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Chốt dịch vụ - Điện nước",
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
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection("ServiceInfo")
                                                    .where('id',
                                                        isEqualTo:
                                                            x["idService"])
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
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      child: MainButton(
                        name: "Chốt dịch vụ",
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

                _TotalWE.text =
                    (int.parse(_totalW.text) + int.parse(_totalE.text))
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
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddBillPage(
                    id: widget.id,
                    listService: listChargeService,
                    totalWE: _TotalWE.text,
                    roomCharge: _chargeRoom.text,
                  )));
    }
  }
}
