import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/apartment/view/apartment_info_page.dart';
import 'package:apartment_app/src/pages/apartment/view/listServicePage.dart';
import 'package:apartment_app/src/pages/dweller/view/list_dwellers_page.dart';
import 'package:apartment_app/src/pages/Bill/view/list_bill_info_page.dart';
import 'package:flutter/material.dart';

class ApartmentDetailPage extends StatefulWidget {
  final String id_apartment;
  //const ApartmentDetailPage({Key? key}) : super(key: key);
  ApartmentDetailPage(this.id_apartment);

  @override
  _ApartmentDetailPageState createState() => _ApartmentDetailPageState();
}

class _ApartmentDetailPageState extends State<ApartmentDetailPage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
                Tab(text: "Thông tin",),
                Tab(text: "Thành viên",),
                Tab(text: "Dịch vụ",),
              ],
            ),
          ),
        ),

        body: TabBarView(
          children: [
            ApartmentInfoPage(widget.id_apartment),
            ListDwellersPage(widget.id_apartment),
            ListServicePage(id:widget.id_apartment),
          ],
        ),
      ),
    );
  }
}
