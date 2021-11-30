import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/fire_base/fb_floor_info.dart';
import 'package:apartment_app/src/pages/apartment/firebase/fb_service_apartment.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_contract.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_rentedRoom.dart';
import 'package:apartment_app/src/pages/dweller/firebase/fb_dweller.dart';
import 'package:apartment_app/src/pages/dweller/model/dweller_model.dart';
import 'package:apartment_app/src/pages/dweller/view/add_dweller_page.dart';
import 'package:apartment_app/src/pages/dweller/view/detail_dweller_page.dart';
import 'package:apartment_app/src/pages/dweller/view/edit_dweller_page.dart';
import 'package:apartment_app/src/widgets/cards/dweller_card.dart';
import 'package:apartment_app/src/widgets/dialog/msg_dilog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListDwellersPage extends StatefulWidget {
  final String id_apartment;
  //const ListDwellersPage({Key? key}) : super(key: key);
  ListDwellersPage(this.id_apartment);

  @override
  _ListDwellersPageState createState() => _ListDwellersPageState();
}

class _ListDwellersPageState extends State<ListDwellersPage> {
  DwellersFB dwellersFB = new DwellersFB();
  RentedRoomFB rentedRoomFB = new RentedRoomFB();
  FloorInfoFB floorInfoFB = new FloorInfoFB();
  ServiceApartmentFB serviceApartmentFB = new ServiceApartmentFB();
  ContractFB contractFB = new ContractFB();
  bool _canAdd = false;

  late int num;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CheckforAdd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: _title("Danh sách thành viên"),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: StreamBuilder(
                  stream: dwellersFB.collectionReference.where('idApartment',isEqualTo: this.widget.id_apartment).snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: Text("No Data"));
                    } else {
                      num = snapshot.data!.docs.length;
                      floorInfoFB.updateDweller(widget.id_apartment, num.toString());
                      CheckforAdd();
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, i) {
                            QueryDocumentSnapshot x = snapshot.data!.docs[i];
                            Dweller dweller = Dweller.fromDocument(x);
                            return DwellerCard(
                              dweller: dweller,
                              funtion: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailDwellerPage(dweller: dweller)));
                              },
                            );
                          });
                    }
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          if(_canAdd == true)
            gotoPage();
          //else MsgDialog.showMsgDialog(context, "Chỉ phòng có hợp đồng mới có thể thêm người", "");
          else MsgDialog.showMsgDialog(context,"Thông báo", "Chỉ phòng có hợp đồng mới có thể thêm người");
        },
        backgroundColor: myGreen,
      ),
    );
  }


  gotoPage(){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddDwellerPage(widget.id_apartment)));
  }

  _title(String text) => Text(
    text,
    style: TextStyle(
        color: Colors.black.withOpacity(0.5),
        fontWeight: FontWeight.bold
    ),
  );
  Future<void> CheckforAdd() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("contract").where('room',isEqualTo: this.widget.id_apartment).where('liquidation',isEqualTo: false).where('isVisible',isEqualTo: true).get();
    //var con = contractFB.collectionReference.where('room',isEqualTo: this.widget.id_apartment).get();
    print(querySnapshot.docs.length);
    if(querySnapshot.docs.length == 0) {
      print("oke");
      _canAdd = false;
    }
    else {
      print("not oke");
      _canAdd = true;
    }
  }
}
