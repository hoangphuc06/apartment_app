import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/tab_pages/contract_tab/contract_liquidation.dart';
import 'package:apartment_app/src/pages/tab_pages/contract_tab/contract_tab.dart';
import 'package:flutter/material.dart';

import 'floor_tab.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

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
            "Trang chủ",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          bottom: TabBar(
            labelStyle: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
            indicatorColor: Colors.white,
            indicatorWeight: 5,
            tabs: [
              Tab(text: "Tầng",),
              Tab(text: "Hợp đồng",),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FloorTab(),
            ContractTab(),
          ],
        ),
      ),
    );
  }
}
