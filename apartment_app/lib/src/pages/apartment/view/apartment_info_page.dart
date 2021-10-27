import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:apartment_app/src/fire_base/fb_floor_info.dart';
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

  final TextEditingController _flooridcontroler = TextEditingController();
  final TextEditingController _notecontroler = TextEditingController();

  void getNamebyid(String id)
  {
    final floorfb = FirebaseFirestore.instance.collection('floor');
    floorfb.doc(id).get().then((value) => {
      _flooridcontroler.text = value['name'].toString(),
      print(_flooridcontroler.text),
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
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
                  getNamebyid(x['floorid']);
                  return Column(
                    children: [
                      Container(
                        //padding: EdgeInsets.only(left: 16),
                        width: size.width,
                        child: Text("Phòng " +
                            x['name'],
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                      Container(
                        //padding: EdgeInsets.only(left: 16),
                        width: size.width,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          controller: _flooridcontroler,
                          enabled: false,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),

                      Container(
                        //padding: EdgeInsets.only(left: 16),
                        width: size.width,
                        child: Text("Trạng thái phòng:  " +
                            x['status'],
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                      SizedBox(height: size.height * 0.015,),
                      Container(
                        width: size.width,
                        child: Text('Loại phòng',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
                      ),
                      SizedBox(height: size.height * 0.015,),
                      Container(
                        //padding: EdgeInsets.only(top: 16),
                        decoration: BoxDecoration(
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        width: size.width * 0.9,
                        height: size.height * 1/3,
                        child: Column(
                          children: [
                            Container(

                            ),
                          ],
                        ),
                      ),
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
}
