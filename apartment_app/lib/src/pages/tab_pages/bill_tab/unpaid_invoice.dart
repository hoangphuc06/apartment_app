import 'package:apartment_app/src/colors/colors.dart';
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
            Navigator.pushNamed(context, "add_new_bill_page");
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
