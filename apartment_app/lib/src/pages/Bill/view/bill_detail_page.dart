import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/Bill/firebase/fb_bill.dart';
import 'package:apartment_app/src/pages/Bill/firebase/fb_billinfo.dart';
import 'package:apartment_app/src/widgets/buttons/roundedButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:flutter/material.dart';
import 'package:apartment_app/src/fire_base/fb_floor_info.dart';
import 'package:select_form_field/select_form_field.dart';

class BillDetailPage extends StatefulWidget {
  String id;
  BillDetailPage({required this.id});

  @override
  _BillInfoPageState createState() => _BillInfoPageState();
}

class _BillInfoPageState extends State<BillDetailPage> {
  BillInfoFB billInfoFB = new BillInfoFB();

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
@override
  void initState() {
    billInfoFB.collectionReference.doc(widget.id).get().then((value) => {
         _noteController.text=value['note']
    });
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
              onPressed: () {},
              icon: Icon(
                Icons.find_in_page_outlined,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.share),
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
                      _title("Chi tiết"),
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 8),
                            child: RoundedButton(
                                name: 'Xóa', onpressed: () => {}, color: myRed),
                          ),
                        ],
                      ),
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
                  border: InputBorder.none, hintText: "Nhập ghi chú"),
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
