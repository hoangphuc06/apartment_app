import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/tab_pages/bill_tab/bill_paid.dart';
import 'package:apartment_app/src/pages/tab_pages/bill_tab/overdue_invoice.dart';
import 'package:apartment_app/src/pages/tab_pages/bill_tab/unpaid_invoice.dart';

import 'package:flutter/material.dart';

class BillTab extends StatefulWidget {
  const BillTab({Key? key}) : super(key: key);

  @override
  _BillTabState createState() => _BillTabState();
}

class _BillTabState extends State<BillTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: myGreen,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Hóa đơn",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          bottom: TabBar(
            labelStyle: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
            indicatorColor: Colors.white,
            indicatorWeight: 5,
            tabs: [
              Tab(
                text: "Chưa thanh toán",
              ),
              Tab(
                text: "Quá hạn thanh toán",
              ),
              Tab(
                text: "Đã thanh toán",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [UnpaidInvoice(), OverdueInvoice(), BillPaid()],
        ),
      ),
    );
  }
}
