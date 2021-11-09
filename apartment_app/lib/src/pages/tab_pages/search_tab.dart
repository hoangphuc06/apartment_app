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
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Tìm kiếm",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          bottom: TabBar(
            labelStyle: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
            indicatorColor: Colors.white,
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
