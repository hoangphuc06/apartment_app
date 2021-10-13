import 'package:apartment_app/src/pages/tab_pages/contract_tab.dart';
import 'package:apartment_app/src/pages/tab_pages/service_tab.dart';
import 'package:flutter/material.dart';

import 'floor_tab.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Trang chính",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: "Tầng",),
              Tab(text: "Hợp đồng",),
              Tab(text: "Dịch vụ",),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FloorTab(),
            ContractTab(),
            ServiceTab()
          ],
        ),
      ),
    );
  }
}
