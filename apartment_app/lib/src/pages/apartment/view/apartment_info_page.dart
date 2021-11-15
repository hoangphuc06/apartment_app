import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/fire_base/fb_floor_info.dart';
import 'package:apartment_app/src/pages/service/firebase/fb_service.dart';
import 'package:apartment_app/src/fire_base/fb_floor.dart';
import 'package:apartment_app/src/pages/category_apartment/firebase/fb_category_apartment.dart';
import 'package:apartment_app/src/pages/apartment/firebase/fb_service_apartment.dart';
import 'package:apartment_app/src/pages/apartment/firebase/fb_apartment.dart';

class ApartmentInfoPage extends StatefulWidget {
  String id;
  //const ApartmentInfoPage({Key? key}) : super(key: key);
  ApartmentInfoPage(this.id);
  @override
  _ApartmentInfoPageState createState() => _ApartmentInfoPageState();

}


class _ApartmentInfoPageState extends State<ApartmentInfoPage> {

  FloorInfoFB floorInfoFB = new FloorInfoFB();

  ServiceApartmentFB serviceApartmentFB = new ServiceApartmentFB();

  final TextEditingController _categorynamecontroler = TextEditingController();
  final TextEditingController _notecontroler = TextEditingController();
  final TextEditingController _areacontroler = TextEditingController();
  final TextEditingController _dwellercontroler = TextEditingController();
  final TextEditingController _bedroomtroler = TextEditingController();
  final TextEditingController _wccontroler = TextEditingController();
  final TextEditingController _minRentalcontroler = TextEditingController();
  final TextEditingController _maxRentalcontroler = TextEditingController();
  final TextEditingController _minPricecontroler = TextEditingController();
  final TextEditingController _maxPricecontroler = TextEditingController();
  final TextEditingController _Servicenamecontroler = TextEditingController();
  final TextEditingController _chargecontroler = TextEditingController();

  // void getNamebyid(String id)
  // {
  //   final floorfb = FirebaseFirestore.instance.collection('floor');
  //   floorfb.doc(id).get().then((value) => {
  //     _flooridcontroler.text = value['name'].toString(),
  //     print(_flooridcontroler.text),
  //   });
  // }
  String getServicenamebyID(String id){
    final servicefb = FirebaseFirestore.instance.collection('ServiceInfo');
      servicefb.doc(id).get().then((value) => {
        _Servicenamecontroler.text = value['name'].toString(),
        print(_Servicenamecontroler.text)
      });
      return _Servicenamecontroler.text;
  }
  String getChargebyID(String id){
    final servicefb = FirebaseFirestore.instance.collection('ServiceInfo');
    servicefb.doc(id).get().then((value) => {
      _chargecontroler.text = value['charge'].toString(),
    });
    return _chargecontroler.text;
  }

  void _getCategorybyid(String id)
  {
    final categoryfb = FirebaseFirestore.instance.collection('category_apartment');
      categoryfb.doc(id).get().then((value) => {
        _categorynamecontroler.text = value['name'].toString(),
        _areacontroler.text = value['area'].toString() + " m²",
        _dwellercontroler.text = value['amountDweller'].toString(),
        _bedroomtroler.text = value['amountBedroom'].toString(),
        _wccontroler.text = value['amountWc'].toString(),
        _minRentalcontroler.text = value['minRentalPrice'].toString(),
        _maxRentalcontroler.text = value['maxRentalPrice'].toString(),
        _minPricecontroler.text = value['minPrice'].toString(),
        _maxPricecontroler.text = value['maxPrice'].toString(),
      });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: StreamBuilder(
                stream: floorInfoFB.collectionReference.where('id', isEqualTo: widget.id).snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: Text("No Data"),);
                  } else {
                    QueryDocumentSnapshot x = snapshot.data!.docs[0];
                    _notecontroler.text = x['note'];
                    _getCategorybyid(x['categoryid']);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      //   Card(
                      //     elevation: 2,
                      //     child: Container(
                      //       padding: EdgeInsets.all(8),
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           SizedBox(height: 10,),
                      //           Text("THÔNG TIN CHI TIẾT CĂN HỘ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                      //           SizedBox(height: 20,),
                      //           _detailInfo(Icons.house_sharp, "Căn hộ" , x['id']),
                      //           SizedBox(height: 20,),
                      //           _detailInfo(Icons.apartment, "Tầng ", x['floorid']),
                      //           SizedBox(height: 20,),
                      //           _detailInfo(Icons.wysiwyg_rounded, "Trạng thái phòng",x['status']),
                      //           SizedBox(height: 10,),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      //   Card(
                      //     elevation: 2,
                      //     child: Container(
                      //       padding: EdgeInsets.all(8),
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           SizedBox(height: 10,),
                      //           Text("THÔNG TIN CHI TIẾT LOẠI CĂN HỘ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                      //           SizedBox(height: 5,),
                      //           Row(
                      //               children: [
                      //                 Icon(Icons.house_rounded),
                      //                 SizedBox(width: 5,),
                      //                 Text("Loại phòng", style: TextStyle(fontSize: 15),),
                      //                 Spacer(),
                      //                 Container(width: size.width*1/2,
                      //                     child: TextField(
                      //                       decoration: InputDecoration(
                      //                           border: InputBorder.none
                      //                       ),
                      //                       textAlign: TextAlign.right,
                      //                       controller: _categorynamecontroler, style: TextStyle(fontSize: 15),)),
                      //               ]
                      //           ),
                      //           Row(
                      //             children: [
                      //               Icon(Icons.crop_square_rounded),
                      //               SizedBox(width: 5,),
                      //               Text("Diện tích", style: TextStyle(fontSize: 15),),
                      //               Spacer(),
                      //               Container(width: 50,
                      //                   child: TextField(
                      //                     decoration: InputDecoration(
                      //                       border: InputBorder.none
                      //                   ),
                      //                     textAlign: TextAlign.right,
                      //                     controller: _areacontroler, style: TextStyle(fontSize: 15),)),
                      //             ]
                      //           ),
                      //           Row(
                      //               children: [
                      //                 Icon(Icons.bed),
                      //                 SizedBox(width: 5,),
                      //                 Text("Số phòng ngủ", style: TextStyle(fontSize: 15),),
                      //                 Spacer(),
                      //                 Container(width: 50,
                      //                     child: TextField(
                      //                       decoration: InputDecoration(
                      //                           border: InputBorder.none
                      //                       ),
                      //                       textAlign: TextAlign.right,
                      //                       controller: _bedroomtroler, style: TextStyle(fontSize: 15),)),
                      //               ]
                      //           ),
                      //           Row(
                      //               children: [
                      //                 Icon(Icons.wc),
                      //                 SizedBox(width: 5,),
                      //                 Text("Số phòng vệ sinh", style: TextStyle(fontSize: 15),),
                      //                 Spacer(),
                      //                 Container(width: 50,
                      //                     child: TextField(
                      //                       decoration: InputDecoration(
                      //                           border: InputBorder.none
                      //                       ),
                      //                       textAlign: TextAlign.right,
                      //                       controller: _wccontroler, style: TextStyle(fontSize: 15),)),
                      //               ]
                      //           ),
                      //           Row(
                      //               children: [
                      //                 Icon(Icons.person),
                      //                 SizedBox(width: 5,),
                      //                 Text("Số người ở", style: TextStyle(fontSize: 15),),
                      //                 Spacer(),
                      //                 Container(width: 50,
                      //                     child: TextField(
                      //                       decoration: InputDecoration(
                      //                           border: InputBorder.none
                      //                       ),
                      //                       textAlign: TextAlign.right,
                      //                       controller: _dwellercontroler, style: TextStyle(fontSize: 15),)),
                      //               ]
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      //   Card(
                      //     elevation: 2,
                      //     child: Container(
                      //       padding: EdgeInsets.all(8),
                      //       child: Column(
                      //         children: [
                      //           SizedBox(height: 10,),
                      //           Container(
                      //             width: size.width,
                      //             child: Text('GHI CHÚ',
                      //               style: TextStyle(
                      //                   color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
                      //           ),
                      //           SizedBox(height: size.height * 0.015,),
                      //           Container(
                      //             //padding: EdgeInsets.only(left: 16),
                      //             width: size.width,
                      //             child: TextField(
                      //               decoration: InputDecoration(
                      //                   border: InputBorder.none
                      //               ),
                      //               controller: _notecontroler,
                      //               enabled: false,
                      //               maxLines: 20,
                      //               minLines: 5,
                      //               style: TextStyle(
                      //                   color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16),
                      //             ),
                      //           ),
                      //           SizedBox(height: 10,),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                        _title("Thông tin chi tiết"),
                        SizedBox(height: 10,),
                        _detail("Tên căn hộ", x["id"]),
                        SizedBox(height: 10,),
                        _detail("Tầng", x["floorid"]),
                        SizedBox(height: 10,),
                        _detail("Trạng thái", x["status"]),

                        SizedBox(height: 30,),
                        _title("Loại căn hộ"),
                        SizedBox(height: 10,),
                        _detail("Loại", _categorynamecontroler.text),
                        SizedBox(height: 10,),
                        _detail("Diện tích", _areacontroler.text),
                        SizedBox(height: 10,),
                        _detail("Số phòng ngủ", _bedroomtroler.text),
                        SizedBox(height: 10,),
                        _detail("Số phòng vệ sinh", _wccontroler.text),
                        SizedBox(height: 10,),
                        _detail("Số người tối đa", _dwellercontroler.text),
                      ],
                    );
                  }
                }
            ),
          ),
        )
    );
  }
  _detailInfo(IconData icons, String title, String value) => Row(
    children: [
      Icon(icons),
      SizedBox(width: 5,),
      Text(title, style: TextStyle(fontSize: 15),),
      Spacer(),
      Text(value, style: TextStyle(fontSize: 15),),
    ],
  );

  _title(String text) => Text(
    text,
    style: TextStyle(
        color: Colors.black.withOpacity(0.5),
        fontWeight: FontWeight.bold
    ),
  );

  _detail(String name, String detail) => Container(
    padding: EdgeInsets.all(8),
    height: 50,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.grey.withOpacity(0.1)
    ),
    child: Row(
      children: [
        Text(
          name,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
        ),
        Spacer(),
        Text(
          detail,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500
          ),
        ),
      ],
    ),
  );

}
