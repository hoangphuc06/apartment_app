import 'package:animated_float_action_button/animated_floating_action_button.dart';
import 'package:animated_float_action_button/float_action_button_text.dart';
import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/apartment/firebase/fb_service_apartment.dart';
import 'package:apartment_app/src/pages/service/firebase/fb_service.dart';
import 'package:apartment_app/src/pages/service/model/service_model.dart';
import 'package:apartment_app/src/widgets/appbars/my_app_bar.dart';
import 'package:apartment_app/src/widgets/dialog/msg_dilog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailService extends StatefulWidget {
  late String id;
  late String idRoom;
  DetailService({Key? key, required this.id, required this.idRoom})
      : super(key: key);
  @override
  _DetailServiceState createState() => _DetailServiceState();
}

class _DetailServiceState extends State<DetailService> {
  final GlobalKey<AnimatedFloatingActionButtonState> fabKey = GlobalKey();
  ServiceFB serviceFB = new ServiceFB();
  ServiceApartmentFB serviceApartmentFB = new ServiceApartmentFB();
  bool _isAdd = false;
  bool _canDelete = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: myAppBar("Thông tin dịch vụ"),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: StreamBuilder(
                stream: serviceFB.collectionReference
                    .where('id', isEqualTo: widget.id)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text("No Data"),
                    );
                  } else {
                    QueryDocumentSnapshot x = snapshot.data!.docs[0];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Thông tin chi tiết
                        _title("Thông tin chi tiết"),
                        SizedBox(
                          height: 10,
                        ),
                        _detail("Tên dịch vụ", x['name'].toString()),
                        // SizedBox(height: 10,),
                        // _detail("Loại dịch vụ", widget.service.type.toString()),
                        SizedBox(
                          height: 10,
                        ),
                        _detail("Phí dịch vụ", x['charge'].toString()),
                        SizedBox(
                          height: 30,
                        ),
                        _title("Khác"),
                        SizedBox(
                          height: 10,
                        ),
                        _note(x['note']),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    );
                  }
                }),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.delete_forever_outlined),
          backgroundColor: myGreen,
          onPressed: () {
            serviceApartmentFB.collectionReference
                .where('idService', isEqualTo: widget.id)
                .where('idRoom', isEqualTo: widget.idRoom)
                .get()
                .then((value) => {serviceApartmentFB.delete(value.docs[0].id)});
                Navigator.pop(context);
          },
        ));
  }

  _title(String text) => Text(
        text,
        style: TextStyle(
            color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.bold),
      );

  _detail(String name, String detail) => Container(
        padding: EdgeInsets.all(8),
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.blueGrey.withOpacity(0.2)),
        child: Row(
          children: [
            Text(
              name,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Text(
              detail,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );

  _note(String text) => Container(
        width: double.infinity,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blueGrey.withOpacity(0.2),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ghi chú",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                height: 1.2,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      );
}
