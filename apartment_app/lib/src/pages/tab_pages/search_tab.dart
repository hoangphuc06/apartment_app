import 'package:apartment_app/src/colors/colors.dart';
import 'package:flutter/material.dart';
import 'apartment_search/apartment_search_tab.dart';
import 'contract_search/view/contract_search_page.dart';
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
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: myGreen, //change your color here
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          title: Text("Tìm kiếm", style: TextStyle(color: myGreen,),),
          centerTitle: true,
          // actions:[
          //   IconButton(
          //     icon: Icon(Icons.settings),
          //     onPressed: () {},
          //   ),
          // ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: TabBar(
              labelColor: Colors.black,
              indicatorColor: myGreen,
              indicatorWeight: 3,
              tabs: [
                Tab(text: "Căn hộ",),
                Tab(text: "Dân cư",),
                Tab(text: "Hợp đồng",),
              ],
            ),
          ),
        ),

        body: TabBarView(
          children: [
            ApartmentSearchTab(),
            DwellerSearchTab(),
            ContractSearchTab(),
          ],
        ),
      ),
    );
  }
}
