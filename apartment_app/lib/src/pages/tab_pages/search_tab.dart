import 'package:apartment_app/src/colors/colors.dart';
import 'package:flutter/material.dart';
import 'apartment_search/apartment_search_tab.dart';
import 'dweller_search/dweller_search_tab.dart';


class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  @override
  Widget build(BuildContext context) {
    return   DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Tìm kiếm",
            style: TextStyle(color:myGreen, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          bottom: TabBar(
            labelColor: myGreen,
            labelStyle: TextStyle(color: myGreen, fontSize: 15, fontWeight: FontWeight.bold),
            indicatorColor: myGreen,
            indicatorWeight: 5,
            tabs: [
              Tab(text: "Căn hộ",),
              Tab(text: "Dân cư",),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            ApartmentSearchTab(),
            DwellerSearchTab(),
          ],
        ),
      ),
    );
  }
}
