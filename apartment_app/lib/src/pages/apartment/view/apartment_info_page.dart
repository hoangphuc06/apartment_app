import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
  ApartmentInfoPage(this.id);
  @override
  _ApartmentInfoPageState createState() => _ApartmentInfoPageState();

}


class _ApartmentInfoPageState extends State<ApartmentInfoPage> {

  FloorInfoFB floorInfoFB = new FloorInfoFB();
  CategoryApartmentFB categoryApartmentFB = new CategoryApartmentFB();
  ServiceApartmentFB serviceApartmentFB = new ServiceApartmentFB();

  @override
  Widget build(BuildContext context) {
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
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Thông tin chi tiết
                        _title("Thông tin chi tiết"),
                        SizedBox(height: 10,),
                        _detail("Tên căn hộ", x["id"]),
                        SizedBox(height: 10,),
                        _detail("Tầng", x["floorid"]),
                        SizedBox(height: 10,),
                        _detail("Trạng thái", x["status"]),
                        SizedBox(height: 10,),
                        _detail("Số người đang ở", x["numOfDweller"]),

                        //Thông tin loại phòng
                        StreamBuilder(
                            stream: categoryApartmentFB.collectionReference.where('id', isEqualTo: x["categoryid"]).snapshots(),
                            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return Center(child: Text("No Data"),);
                              } else {
                                QueryDocumentSnapshot y = snapshot.data!.docs[0];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 30,),
                                    _title("Loại căn hộ"),
                                    SizedBox(height: 10,),
                                    _detail("Loại", y["name"]),
                                    SizedBox(height: 10,),
                                    _detail("Diện tích", y["area"] + " m2"),
                                    SizedBox(height: 10,),
                                    _detail("Số phòng ngủ", y["amountBedroom"]),
                                    SizedBox(height: 10,),
                                    _detail("Số phòng vệ sinh", y["amountWc"]),
                                    SizedBox(height: 10,),
                                    _detail("Số người tối đa", y["amountDweller"]),
                                  ],
                                );
                              }
                            }
                        ),

                        //Ghi chú
                        SizedBox(height: 30,),
                        _title("Khác"),
                        SizedBox(height: 10,),
                        _note(x["note"]),

                        SizedBox(height: 50,)
                      ],
                    );
                  }
                }
            ),
          ),
        )
    );
  }

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

  _note(String text) => Container(
    width: double.infinity,
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.grey.withOpacity(0.1),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ghi chú",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10,),
        Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            height: 1.2,
          ),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 10,),
      ],
    ),
  );

}
