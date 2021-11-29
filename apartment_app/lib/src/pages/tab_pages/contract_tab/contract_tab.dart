import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/tab_pages/bill_tab/bill_paid.dart';
import 'package:apartment_app/src/pages/tab_pages/bill_tab/overdue_invoice.dart';
import 'package:apartment_app/src/pages/tab_pages/bill_tab/unpaid_invoice.dart';
import 'package:apartment_app/src/pages/tab_pages/contract_tab/contract_liquidation.dart';
import 'package:apartment_app/src/pages/tab_pages/contract_tab/contract_not_liquidation.dart';

import 'package:flutter/material.dart';

class ContractTab extends StatefulWidget {
  const ContractTab({Key? key}) : super(key: key);

  @override
  _ContractTabState createState() => _ContractTabState();
}

class _ContractTabState extends State<ContractTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: myGreen, //change your color here
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          title: Text("Thông tin căn hộ", style: TextStyle(color: myGreen,),),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: TabBar(
              labelColor: Colors.black,
              indicatorColor: myGreen,
              indicatorWeight: 3,
              tabs: [
                Tab(text: "Chưa thanh lý",),
                Tab(text: "Đã thanh lý",),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [ContractNotLiquidation(), ContractLiquidation()],
        ),
      ),
    );
  }
}
