import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/Bill/view/selectRoomService.dart';
import 'package:apartment_app/src/pages/contract/view/selectRoom.dart';
import 'package:flutter/material.dart';

class UnpaidInvoice extends StatefulWidget {
  const UnpaidInvoice({Key? key}) : super(key: key);

  @override
  _UnpaidInvoiceState createState() => _UnpaidInvoiceState();
}

class _UnpaidInvoiceState extends State<UnpaidInvoice> {
  bool isPaid = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.1),
        body: isPaid ? null : emptyTab(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: myGreen,
          onPressed: () {
            Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SelectRoomService(
                  status: 'Đang thuê',
                )));
          },
        ));
  }
}

Widget emptyTab() {
  return Center(
      child: Text(
    "Dữ liệu trống",
    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
  ));
}
