import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/tab_pages/bill_tab/bill_paid.dart';
import 'package:apartment_app/src/pages/tab_pages/bill_tab/overdue_invoice.dart';
import 'package:apartment_app/src/pages/tab_pages/bill_tab/unpaid_invoice.dart';
import 'package:apartment_app/src/pages/tab_pages/contract_tab/contract_liquidation.dart';
import 'package:apartment_app/src/pages/tab_pages/contract_tab/contract_not_liquidation.dart';

import 'package:flutter/material.dart';

class ContracTab extends StatefulWidget {
  const ContracTab({Key? key}) : super(key: key);

  @override
  _ContracTabState createState() => _ContracTabState();
}

class _ContracTabState extends State<ContracTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: myGreen,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Hợp đồng",
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
                text: "Chưa thanh lý",
              ),
              Tab(
                text: "Đã thanh lý",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [ContractNotLiquidation(), ContractLiquidation()],
        ),
      ),
    );
  }
}
