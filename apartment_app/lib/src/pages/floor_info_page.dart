
import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/fire_base/fb_floor_info.dart';
import 'package:apartment_app/src/pages/apartment/view/apartment_detail_page.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:apartment_app/src/fire_base/fb_floor.dart';
import 'package:apartment_app/src/widgets/cards/floor_info_card.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myGreen,
        elevation: 0,
        centerTitle: true,
        title:  Text(
          "Tầng " + widget.floorid,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
      ),
      body: Container(
        height: double.infinity,
        color: Colors.grey.withOpacity(0.1),
        padding: const EdgeInsets.all(16),
        child: Expanded(
          child: SingleChildScrollView(
            child: StreamBuilder(
              stream: floorInfoFB.collectionReference.where('floorid', isEqualTo: widget.floorid).snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: Text("No Data"));
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, i) {
                          QueryDocumentSnapshot x = snapshot.data!.docs[i];
                          return FloorInfoCard(
                              id: x["id"],
                              numOfDweller: x["numOfDweller"],
                              status: x["status"],
                              funtion: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ApartmentDetailPage(x["id"])));
                              }
                          );
                        }
                    );
                  }
                }
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){

        }
      ),
    );
  }

}

