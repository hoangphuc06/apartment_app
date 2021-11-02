import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/fire_base/fb_floor_info.dart';
import 'package:apartment_app/src/pages/category_apartment/firebase/fb_category_apartment.dart';
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

  // void getNamebyid(String id)
  // {
  //   final floorfb = FirebaseFirestore.instance.collection('floor');
  //   floorfb.doc(id).get().then((value) => {
  //     _flooridcontroler.text = value['name'].toString(),
  //     print(_flooridcontroler.text),
  //   });
  // }
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
        backgroundColor: Colors.white.withOpacity(0.9),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16,horizontal: 16),
          child: StreamBuilder(
              stream: floorInfoFB.collectionReference.where('id', isEqualTo: widget.id).snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Text("No Data", style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22)),);
                } else {
                  QueryDocumentSnapshot x = snapshot.data!.docs[0];
                  _notecontroler.text = x['note'];
                  _getCategorybyid(x['categoryid']);
                  return Column(
                    children: [
                      Card(
                        elevation: 2,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10,),
                              Text("Thông tin chi tiết căn hộ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                              SizedBox(height: 20,),
                              _detailInfo(Icons.house_sharp, "Căn hộ" , x['id']),
                              SizedBox(height: 20,),
                              _detailInfo(Icons.apartment, "Tầng ", x['floorid']),
                              SizedBox(height: 20,),
                              _detailInfo(Icons.wysiwyg_rounded, "Trạng thái phòng",x['status']),
                              SizedBox(height: 20,),
                            ],
                          ),
                        ),
                      ),
                      //SizedBox(height: size.height * 0.015,),
                      Card(
                        elevation: 2,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10,),
                              Text("Thông tin chi tiết loại phòng", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                              SizedBox(height: 20,),
                              Row(
                                  children: [
                                    Icon(Icons.house_rounded),
                                    SizedBox(width: 5,),
                                    Text("Loại phòng", style: TextStyle(fontSize: 15),),
                                    Spacer(),
                                    Container(width: size.width*1/2,
                                        child: TextField(
                                          decoration: InputDecoration(
                                              border: InputBorder.none
                                          ),
                                          textAlign: TextAlign.right,
                                          controller: _categorynamecontroler, style: TextStyle(fontSize: 15),)),
                                  ]
                              ),
                              Row(
                                children: [
                                  Icon(Icons.crop_square_rounded),
                                  SizedBox(width: 5,),
                                  Text("Diện tích", style: TextStyle(fontSize: 15),),
                                  Spacer(),
                                  Container(width: 50,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: InputBorder.none
                                      ),
                                        textAlign: TextAlign.right,
                                        controller: _areacontroler, style: TextStyle(fontSize: 15),)),
                                ]
                              ),
                              Row(
                                  children: [
                                    Icon(Icons.bed),
                                    SizedBox(width: 5,),
                                    Text("Số phòng ngủ", style: TextStyle(fontSize: 15),),
                                    Spacer(),
                                    Container(width: 50,
                                        child: TextField(
                                          decoration: InputDecoration(
                                              border: InputBorder.none
                                          ),
                                          textAlign: TextAlign.right,
                                          controller: _bedroomtroler, style: TextStyle(fontSize: 15),)),
                                  ]
                              ),
                              //
                              Row(
                                  children: [
                                    Icon(Icons.wc),
                                    SizedBox(width: 5,),
                                    Text("Số phòng vệ sinh", style: TextStyle(fontSize: 15),),
                                    Spacer(),
                                    Container(width: 50,
                                        child: TextField(
                                          decoration: InputDecoration(
                                              border: InputBorder.none
                                          ),
                                          textAlign: TextAlign.right,
                                          controller: _wccontroler, style: TextStyle(fontSize: 15),)),
                                  ]
                              ),
                              Row(
                                  children: [
                                    Icon(Icons.person),
                                    SizedBox(width: 5,),
                                    Text("Số người ở", style: TextStyle(fontSize: 15),),
                                    Spacer(),
                                    Container(width: 50,
                                        child: TextField(
                                          decoration: InputDecoration(
                                              border: InputBorder.none
                                          ),
                                          textAlign: TextAlign.right,
                                          controller: _dwellercontroler, style: TextStyle(fontSize: 15),)),
                                  ]
                              ),
                              SizedBox(height: 10,),
                            ],
                          ),
                        ),
                      ),
                      // Card(
                      //   elevation: 2,
                      //   child: Container(
                      //     padding: EdgeInsets.all(8),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         SizedBox(height: 10,),
                      //         Text("Giá cả giao động", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                      //         SizedBox(height: 20,),
                      //         Column(
                      //         children: [
                      //           Row(
                      //             children: [
                      //               Icon(Icons.money),
                      //               SizedBox(width: 5,),
                      //               Text("Giá thuê", style: TextStyle(fontSize: 15),),
                      //               Spacer(),
                      //               Container(width: 60,
                      //                   child: TextField(
                      //                     decoration: InputDecoration(
                      //                         border: InputBorder.none
                      //                     ),
                      //                     textAlign: TextAlign.right,
                      //                     controller: _minRentalcontroler, style: TextStyle(fontSize: 15),)),
                      //               Text(" - ", style: TextStyle(fontSize: 15),),
                      //               Container(width: 60,
                      //                   child: TextField(
                      //                     decoration: InputDecoration(
                      //                         border: InputBorder.none
                      //                     ),
                      //                     textAlign: TextAlign.right,
                      //                     controller: _maxRentalcontroler, style: TextStyle(fontSize: 15),)),
                      //               Text(" VNĐ", style: TextStyle(fontSize: 15),),
                      //             ],
                      //             ),
                      //
                      //         ],
                      //         ),
                      //         Column(
                      //           children: [
                      //             Row(
                      //               children: [
                      //                 Icon(Icons.money),
                      //                 SizedBox(width: 5,),
                      //                 Text("Giá bán", style: TextStyle(fontSize: 15),),
                      //                 Spacer(),
                      //                 Container(width: 60,
                      //                     child: TextField(
                      //                       decoration: InputDecoration(
                      //                           border: InputBorder.none
                      //                       ),
                      //                       textAlign: TextAlign.right,
                      //                       controller: _minPricecontroler, style: TextStyle(fontSize: 15),)),
                      //                 Text(" - ", style: TextStyle(fontSize: 15),),
                      //                 Container(width: 60,
                      //                     child: TextField(
                      //                       decoration: InputDecoration(
                      //                           border: InputBorder.none
                      //                       ),
                      //                       textAlign: TextAlign.right,
                      //                       controller: _maxPricecontroler, style: TextStyle(fontSize: 15),)),
                      //                 Text(" VNĐ", style: TextStyle(fontSize: 15),),
                      //               ],
                      //             ),
                      //
                      //           ],
                      //         ),
                      //         SizedBox(height: 10,)
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: size.height * 0.015,),
                      Container(
                        width: size.width,
                        child: Text('Ghi chú',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
                      ),
                      SizedBox(height: size.height * 0.015,),

                      Container(
                        //padding: EdgeInsets.only(left: 16),
                        width: size.width,
                        child: TextField(
                          controller: _notecontroler,
                          enabled: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 4,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16),
                        ),
                      ),
                    ],
                  );
                }
              }
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

  _priceInfo(IconData icons, String title, String minValue, String maxValue) => Column(
    children: [
      Row(
        children: [
          Icon(icons),
          SizedBox(width: 5,),
          Text(title, style: TextStyle(fontSize: 15),),
          Spacer(),
          Text(minValue + " - " + maxValue + " VNĐ", style: TextStyle(fontSize: 15),),
        ],
      ),

    ],
  );
}
