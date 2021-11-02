import 'package:apartment_app/src/pages/Bill/firebase/fb_list_bill_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:flutter/material.dart';
import 'package:apartment_app/src/fire_base/fb_floor_info.dart';
import 'package:select_form_field/select_form_field.dart';

class BillDetailPage extends StatefulWidget {
  String billid;
  BillDetailPage(this.billid);

  @override
  _BillInfoPageState createState() => _BillInfoPageState();
}

class _BillInfoPageState extends State<BillDetailPage> {
  ApartmentBillInfo apartmentBillInfo = new ApartmentBillInfo();

  final TextEditingController _idcontroler = TextEditingController();
  final TextEditingController _roomidcontroler = TextEditingController();
  final TextEditingController _billdatecontroler = TextEditingController();
  final TextEditingController _servicecontroler = TextEditingController();
  final TextEditingController _statuscontroler = TextEditingController();

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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Thông tin hóa đơn',style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
        //padding: const EdgeInsets.all(16.0),
          stream: apartmentBillInfo.collectionReference.where('billid', isEqualTo: widget.billid).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Text("No Data", style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22)),);
            } else {
              QueryDocumentSnapshot x = snapshot.data!.docs[0];
              return Column(
                children: [

                ],
              );
            }
          }
        )
      ),

    );
  }
}