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
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: myGreen, //change your color here
          ),
          backgroundColor:Colors.white,
          elevation: 1,
          centerTitle: true,
          title: Text("Hóa đơn", style: TextStyle(color: myGreen,),),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: TabBar(
              labelColor: Colors.black,
              indicatorColor: myGreen,
              indicatorWeight: 3,
              tabs: [
                Tab(text: "Chưa thanh toán",),
                Tab(text: "Đã thanh toán",),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [UnpaidInvoice(), BillPaid()],
        ),
      ),
    );
  }
}
