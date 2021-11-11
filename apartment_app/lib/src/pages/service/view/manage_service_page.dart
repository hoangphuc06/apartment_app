
import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/service/model/service_info.dart';
import 'package:apartment_app/src/pages/service/model/service_model.dart';
import 'package:apartment_app/src/pages/service/view/service_detail.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/cards/service_card.dart';
import 'package:flutter/material.dart';
import 'package:apartment_app/src/pages/service/firebase/fb_service.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_service_page.dart';
class ServicePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateServicePage();
    throw UnimplementedError();
  }
}
class StateServicePage extends State<ServicePage> {
  List<ServiceModel> ListServiceModel = <ServiceModel>[];
  ServiceFB fb = new ServiceFB();
  Future<ServiceModel> addButtonOnPressed() async {
    Route route = MaterialPageRoute(builder: (context) => AddServicPage());
    ServiceModel Result = await Navigator.push(this.context, route);
    return Result;
  }

  Future<void> loadData() async {
    ListServiceModel = [];
    Stream<QuerySnapshot> query = this.fb.collectionReference.snapshots();
    await query.forEach((x) {
      x.docs.asMap().forEach((key, value) {
        var t = x.docs[key];
        print('path::' + t['icon'].toString());
        ListServiceModel.add(ServiceModel(id: t['id'],
            name: t['name'],
            type: t['type'],
            detail: t['note'],
            charge: t['charge']));
      });
    });
  }
  Future<void> modifi(ServiceModel sv) async {
    Route route =
    MaterialPageRoute(builder: (context) => ServiceDetailPage(service: sv));
    ServiceModel Result = await Navigator.push(this.context, route);
    if (Result != null) {
      this.fb.update(
          sv.id.toString(), Result.name.toString(),
          Result.detail.toString(), Result.charge.toString(),
          Result.type.toString());
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    this.loadData();
    //  createListCard();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('BUILD FUNTION');
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      floatingActionButton: FloatingActionButton(
        backgroundColor: myGreen,
        child: Icon(Icons.add),
        onPressed: () async {
          ServiceModel temp = await addButtonOnPressed();
          if (temp == null) return;
          this.fb.add( temp.name.toString(),
              temp.detail.toString(), temp.charge.toString(),
              temp.type.toString());
          //    listService.add(temp);
          setState(() {});
        },
      ),
      appBar: AppBar(
        backgroundColor: myGreen,
        elevation: 0,
        centerTitle: true,
        title:  Text(
          "Dịch vụ",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //SizedBox(height: 20),
            Expanded(
                child: StreamBuilder(
                    stream: fb.collectionReference.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      }
                      this.ListServiceModel.clear();
                      snapshot.data!.docs.forEach((element) {
                        this.ListServiceModel.add(
                            ServiceModel.fromDocument(element));
                      }
                      );
                      return ListView.builder(
                          itemCount: ListServiceModel.length,
                          itemBuilder: (context, index) {
                            return ServiceCard(
                              serviceInfo: ListServiceModel[index],
                              onPressed: () {
                                this.modifi(ListServiceModel[index]);
                              },);
                          });
                    })
            ),
          ],
        ),
      ),
    );
  }

}
