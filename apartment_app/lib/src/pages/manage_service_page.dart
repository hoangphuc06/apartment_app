<<<<<<< Updated upstream
import 'package:flutter/material.dart';

import 'add_service_page.dart';
class ServicePage extends StatefulWidget{
=======
import 'dart:ffi';

import 'package:apartment_app/src/fire_base/fb_service.dart';
import 'package:apartment_app/src/pages/service_object/service_info.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_service_page.dart';

class ServicePage extends StatefulWidget {
>>>>>>> Stashed changes
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateServicePage();
    throw UnimplementedError();
  }
<<<<<<< Updated upstream


}

class StateServicePage extends State<ServicePage>{

  void addButtonOnPressed(){
    Route route = MaterialPageRoute(builder: (context) => AddServicPage());
    Navigator.push(this.context, route);
  }
  late List<Widget> items=  <Widget>[];
  void createListCard(){
    int i=0;
    items.clear();
    while(i<16)
    {
      i++;
      items.add(this.ServiceBox());
    }

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    createListCard();
    return Scaffold(
      floatingActionButton:FloatingActionButton(onPressed: addButtonOnPressed,) ,
      appBar: AppBar(title: Row(
        children: [
          SizedBox( width: 150,),
          Text("DICH VU",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold))
        ],
      ),),

      body:

      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(

          mainAxisAlignment:  MainAxisAlignment.start,
          crossAxisAlignment:  CrossAxisAlignment.start,
          children: [
            Container(

              decoration: BoxDecoration(
                  color: Colors.white70,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: TextField(
                style: TextStyle(fontSize: 18),
                cursorColor: Colors.red,
                decoration: InputDecoration(

                  hintText: 'Tim kiem theo ten',
                  hintStyle: TextStyle(color:Colors.grey.shade400,fontSize: 18),
                  icon: const Icon(Icons.search,size: 35,color: Colors.grey,),

                ),
              ),
            ),
            SizedBox(height: 20),
            Text("Dich Vu Co Phi",style: TextStyle(fontSize: 22,color: Colors.grey.shade700),),
            SizedBox(height: 18),
            Expanded(
              child: GridView.count(crossAxisCount: 3,mainAxisSpacing: 5,crossAxisSpacing: 5,
                children: items,
              ),
            ),

          ],
        ),
      ),


    );
    throw UnimplementedError();
  }
  Widget ServiceBox () {
    return Card(
      color: Colors.blue,
      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.account_balance_sharp,size:16,color: Colors.deepOrange,),
                SizedBox(
                  width: 10,
                )
              ],
            ),
            Icon(Icons.access_alarm,color: Colors.amber,size: 40.0,),
            SizedBox(height: 10,),
            Text("Name",),
            SizedBox(height: 8),
            Text('Detail'),

          ],
        ),
      ),

    );
  }



}
=======
}

class StateServicePage extends State<ServicePage> {
  List<Widget> items = <Widget>[];
  List<ServiceInfo> listService = <ServiceInfo>[];
  ServiceFB fb = new ServiceFB();

  TextEditingController seachControler= new TextEditingController();
  Future<ServiceInfo> addButtonOnPressed() async {
    Route route = MaterialPageRoute(builder: (context) => AddServicPage());
    ServiceInfo Result = await Navigator.push(this.context, route);

    return Result;
  }

  Future<void> loadData()async {
    listService = [];

      Stream<QuerySnapshot> query = this.fb.collectionReference.snapshots();
    await  query.forEach((x) {
        x.docs.asMap().forEach((key, value) {
          var t = x.docs[key];
          print('path::' + t['icon'].toString());
          listService.add(ServiceInfo(id: t['id'],
              name: t['name'],
              type: t['type'],
              iconPath: t['icon'],
              detail: t['note'],
              charge: t['charge']));
        });
      });

  }
  void filt(){
    listService.forEach((element) {
      if(element.name!.contains(this.seachControler.text))
       listService.remove(element);
    });

  }

  void createListCard() {
    listService.forEach((element) {
      items.add(ServiceBox(element));
    });
  }

  void delete(ServiceInfo sv) {
    this.fb.delete(sv.id.toString());
    setState(() {});
  }

  Future<void> modifi(ServiceInfo sv) async {
    Route route =
        MaterialPageRoute(builder: (context) => AddServicPage(sv: sv));
    ServiceInfo Result = await Navigator.push(this.context, route);
    if (Result != null) {

    this.fb.update(sv.id.toString(), Result.iconPath.toString(), Result.name.toString(),Result.detail.toString() , Result.charge.toString(), Result.type.toString());
    }
    setState(() {});
  }

  void addService(ServiceInfo service) {
    this.items.add(this.ServiceBox(service));
  }

  void modifiService(ServiceInfo sv) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        builder: (BuildContext conText) {
          return Container(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  RaisedButton(
                    onPressed: () {
                      this.delete(sv);
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text('Xoa'),
                    ),
                  ),
                  RaisedButton(
                    onPressed: ()async {
                        await  this.modifi(sv);
                        Navigator.pop(context);


                    },
                    child: Center(
                      child: Text('Thay doi'),

                    ),
                  )
                ],
              ),
            ),
          );
        });
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
    this.loadData();
  print('BUILD FUNTION');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          ServiceInfo temp = await addButtonOnPressed();
          if(temp==null) return;
          this.fb.add(temp.iconPath.toString(), temp.name.toString(), temp.detail.toString(), temp.charge.toString(), temp.type.toString());
      //    listService.add(temp);

          setState(() {});
        },
      ),
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(
              width: 150,
            ),
            Text("DICH VU",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
       /*     Container(
              decoration: BoxDecoration(
                  color: Colors.white70,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: TextField(
                controller: this.seachControler,
                style: TextStyle(fontSize: 18),
                cursorColor: Colors.red,
                decoration: InputDecoration(
                  hintText: 'Tim kiem theo ten',
                  hintStyle:
                      TextStyle(color: Colors.grey.shade400, fontSize: 18),
                  icon: const Icon(
                    Icons.search,
                    size: 35,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),*/
            SizedBox(height: 20),
            SizedBox(height: 18),
            Expanded(
                child: StreamBuilder(
                    stream: fb.collectionReference.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      return GridView.builder(
                          itemCount: snapshot.data!.docs.length,
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 2 / 2.5,
                            crossAxisCount: 3,
                          ),
                          itemBuilder: (context, index) {
                            QueryDocumentSnapshot x =
                            snapshot.data!.docs[index];
                            //    if(!x['name'].toString().contains(this.seachControler.text))
                            return ServiceBox(ServiceInfo(
                                id: x['id'], name: x['name'], type: x['type'],iconPath: x['icon'],detail: x['note'],charge: x['charge']));
                          });
                    })
            ),
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }

  Widget ServiceBox(ServiceInfo info) {
    print('Icon Path:${info.iconPath.toString()}');
    String pathAsset = info.iconPath != null
        ? info.iconPath.toString()
        : 'assets/images/service_icon/add_icon.png';
    String temp1 = '/';
    temp1 = info.type != null ? temp1 + info.type.toString() : '';

    String detail = (info.charge != null && info.charge!.contains(new RegExp(r'[0-9]'))
        ? info.charge.toString() + 'VND'
        : '0vnd');
    print(detail);
    print(temp1);

    return GestureDetector(
      onLongPress: () {

        this.modifiService(info);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(child: Image.asset(pathAsset, fit: BoxFit.fill)),
              Text(
                info.name.toString(),
                style: TextStyle(fontSize: 20),
              ),
              Text(detail + temp1, style: TextStyle(fontSize: 16))
            ],
          ),
        ),
      ),
    );
  }
}
>>>>>>> Stashed changes
