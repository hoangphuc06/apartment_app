import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/statistic/view/year_statistic_page.dart';
import 'package:flutter/material.dart';

import 'month_statistic_page.dart';
class  StatisticPage extends StatefulWidget {
  const StatisticPage({Key? key}) : super(key: key);

  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState  extends State<StatisticPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return   DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          title: Text(
            "Thống kê",
            style: TextStyle(color:myGreen, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: TabBar(
              labelColor: Colors.black,
              indicatorColor: myGreen,
              indicatorWeight: 3,
              tabs: [
                Tab(text: "Theo tháng",),
                Tab(text: "Theo năm",),
              ],
            ),
          ),
        ),

        body: TabBarView(
          children: [
            MonthStatisticPage(),
            YearStatisticPage(),
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }

}
