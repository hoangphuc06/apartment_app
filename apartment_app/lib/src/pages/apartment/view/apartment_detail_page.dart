import 'package:apartment_app/src/pages/apartment/view/apartment_info_page.dart';
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
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Thông tin phòng",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: "Thông tin",),
              Tab(text: "Thành viên",),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ApartmentInfoPage(widget.id_apartment),
            ListDwellersPage(widget.id_apartment),
            ListBillInfoPage(widget.id_apartment),
          ],
        ),
      ),
    );
  }
}
