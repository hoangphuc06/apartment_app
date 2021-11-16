
import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/fire_base/fb_floor_info.dart';
import 'package:apartment_app/src/pages/apartment/view/apartment_detail_page.dart';
import 'package:apartment_app/src/widgets/appbars/my_app_bar.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:apartment_app/src/fire_base/fb_floor.dart';
import 'package:apartment_app/src/widgets/cards/floor_info_card.dart';
import 'package:apartment_app/src/pages/apartment/view/add_new_apartment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class FloorInfoPage extends StatefulWidget{
  final String floorid;
  FloorInfoPage({required this.floorid});
  //const FloorInfoPage({Key ? key}) : super(key: key);

  @override
  _FloorInfoPageState createState() => _FloorInfoPageState();
}

class _FloorInfoPageState  extends State<FloorInfoPage>{
  FloorInfoFB floorInfoFB = new FloorInfoFB();
  FloorFB floorFB = new FloorFB();

  late int dem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar(
        "Tầng " + widget.floorid,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: _title("Danh sách căn hộ"),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: StreamBuilder(
                stream: floorInfoFB.collectionReference.where('floorid', isEqualTo: widget.floorid).snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: Text("No Data"));
                    } else {
                      dem = snapshot.data!.docs.length;
                      _updateNumofApm(snapshot.data!.docs.length);
                      _updateNumofUse(snapshot.data!.docs.length);
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, i) {
                            QueryDocumentSnapshot x = snapshot.data!.docs[i];
                            return FloorInfoCard(
                                id: x["id"],
                                status: x["status"],
                                funtion: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ApartmentDetailPage(x["id"])));
                                }
                            );
                          },
                      );
                    }
                  }
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddApartmentPage(widget.floorid,dem.toString())));
        },
        backgroundColor: myGreen,
      ),
    );
  }

  void _updateNumofApm(int a){
    floorFB.update(widget.floorid, a.toString());
  }

  void _updateNumofUse(int a){
    final floor = FirebaseFirestore.instance.collection('floorinfo').where('status', isEqualTo: 'trống').snapshots();
  }

  _title(String text) => Text(
    text,
    style: TextStyle(
        color: Colors.black.withOpacity(0.5),
        fontWeight: FontWeight.bold
    ),
  );
}

