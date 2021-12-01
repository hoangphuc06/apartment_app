import 'package:apartment_app/src/PDF/pdf_api.dart';
import 'package:apartment_app/src/PDF/pdf_form_bill.dart';
import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/Bill/firebase/fb_billService.dart';
import 'package:apartment_app/src/pages/Bill/firebase/fb_billinfo.dart';
import 'package:apartment_app/src/pages/Bill/model/billService_model.dart';
import 'package:apartment_app/src/pages/Bill/model/bill_model.dart';
import 'package:apartment_app/src/pages/apartment/firebase/fb_service_apartment.dart';
import 'package:apartment_app/src/pages/service/firebase/fb_service.dart';
import 'package:apartment_app/src/widgets/buttons/roundedButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:flutter/material.dart';
import 'package:apartment_app/src/fire_base/fb_floor_info.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class BillDetailPage extends StatefulWidget {
  String id;
  bool flag;
  BillDetailPage({required this.id, required this.flag});

  @override
  _BillInfoPageState createState() => _BillInfoPageState();
}

class _BillInfoPageState extends State<BillDetailPage> {
  BillInfoFB billInfoFB = new BillInfoFB();
  ServiceFB serviceFB = new ServiceFB();
  BillServiceFB billServiceFB = new BillServiceFB();
  List<BillService> listService = <BillService>[];
  final TextEditingController _idcontroler = TextEditingController();
  final TextEditingController _roomidcontroler = TextEditingController();
  final TextEditingController _billdatecontroler = TextEditingController();
  final TextEditingController _serviceChargeControler = TextEditingController();
  final TextEditingController _roomChargeControler = TextEditingController();
  final TextEditingController _depositControler = TextEditingController();
  final TextEditingController _fineControler = TextEditingController();
  final TextEditingController _startControler = TextEditingController();
  final TextEditingController _endControler = TextEditingController();
  final TextEditingController _total = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _discountControler = TextEditingController();
  DateTime selectedDate = new DateTime.now();
  bool _isAdd = false;

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

  Future<void> loadData() async {
    Stream<QuerySnapshot> query = billServiceFB.collectionReference
        .where('idBillinfo', isEqualTo: widget.id)
        .snapshots();
    await query.forEach((x) {
      x.docs.asMap().forEach((key, value) {
        var t = x.docs[key];
        listService.add(
            BillService(name: t['nameService'], charge: t['chargeService']));
      });
    });
  }

  BillModel billModel = new BillModel();
  @override
  void initState() {
    billInfoFB.collectionReference.doc(widget.id).get().then((value) => {
          _noteController.text = value['note'],
          billModel = BillModel.fromDocument(value),
          billServiceFB.collectionReference
              .where('idBillinfo', isEqualTo: value['idBillInfo'])
              .get()
              .then((value) => {})
        });
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: myGreen, //change your color here
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () async {
                final pdfFile =
                    await PdFFormBill.generate(billModel, listService);

                PdfApi.openFile(pdfFile);
              },
              icon: Icon(
                Icons.find_in_page_outlined,
                size: 30,
              ),
            ),
          ],
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            "Hóa đơn",
            style: TextStyle(
              color: myGreen,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: StreamBuilder(
              stream: billInfoFB.collectionReference
                  .where('idBillInfo', isEqualTo: this.widget.id)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                      _title("Hóa đơn"),
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
                      _title("Dịch vụ"),

                      StreamBuilder(
                          stream: billServiceFB.collectionReference
                              .where('idBillinfo', isEqualTo: this.widget.id)
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            } else {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, i) {
                                    QueryDocumentSnapshot y =
                                        snapshot.data!.docs[i];
                                    return Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        _detail(y['nameService'],
                                            y['chargeService'] + ' đ'),
                                      ],
                                    );
                                  });
                            }
                          }),

                      SizedBox(
                        height: 20,
                      ),
                      _title("Tổng hợp"),
                      SizedBox(
                        height: 10,
                      ),
                      _detail("Tiền phòng", x["roomCharge"] + ' đ'),
                      SizedBox(
                        height: 10,
                      ),
                      _detail("Tiền dịch vụ", x["serviceFee"] + ' đ'),
                      SizedBox(
                        height: 10,
                      ),
                      _detail("Tiền cọc hợp đồng", x["deposit"] + ' đ'),
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

                      widget.flag
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(right: 8),
                                  child: RoundedButton(
                                      name: 'Xóa',
                                      onpressed: () => {},
                                      color: myRed),
                                ),
                                Container(
                                  child: RoundedButton(
                                      name: 'Thanh toán',
                                      onpressed:_isAdd == false ? () => _AddConfirm(context,x['idBillInfo']) : null,
                                      color: myGreen),
                                ),
                              ],
                            )
                          : Container(),
                      SizedBox(
                        height: 30,
                      ),
                      _title("Ghi chú"),
                      SizedBox(
                        height: 10,
                      ),
                      _note(_noteController),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                }
              }),
        ));
  }

  void _AddConfirm(BuildContext context, String bill) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('XÁC NHẬN'),
            content: Text('Bạn có chắc muốn xóa hóa đơn này?'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    // Remove the box
                    setState(() {
                      _isAdd = false;
                    });
                    billInfoFB.updateStatus(
                        bill,
                        "Đã thanh toán");
                    Navigator.pop(context);
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: Text('Có')),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: Text('Không'))
            ],
          );
        });
  }

  _title(String text) => Text(
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

  _note(TextEditingController controller) => Container(
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
              controller: controller,
              maxLines: 10,
              minLines: 3,
              decoration: InputDecoration(
                  enabled: false,
                  border: InputBorder.none,
                  hintText: "[Trống]"),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      );
}
