
import 'package:apartment_app/src/pages/service/model/service_info.dart';
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
  List<Widget> items = <Widget>[];
  List<ServiceInfo> listService = <ServiceInfo>[];
  ServiceFB fb = new ServiceFB();
  TextEditingController seachControler= new TextEditingController();

  Future<ServiceInfo> addButtonOnPressed() async {
    Route route = MaterialPageRoute(builder: (context) => AddServicPage());
    ServiceInfo Result = await Navigator.push(this.context, route);
    this.seachControler.text='';
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
    this.seachControler.text='';
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
                      Navigator.pop(context);
                        await  this.modifi(sv);

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
  _searchTextField() => TextFormField(
    style: MyStyle().style_text_tff(),
    controller: seachControler,
    decoration: InputDecoration(
      hintText: "Tên Dịch Vụ ",
      icon: Icon(Icons.search),
      
    ),
    onChanged: (text){
      setState(() {
        
      });
    },
  );
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          ServiceInfo temp = await addButtonOnPressed();
          if(temp==null) return;
          this.fb.add(temp.iconPath.toString(), temp.name.toString(), temp.detail.toString(), temp.charge.toString(), temp.type.toString());
      //    listService.add(temp);

          setState(() {});
        },
      ),
      appBar: AppBar(
        title:Text("Dịch Vụ",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _searchTextField(),
            SizedBox(height: 20),
            Expanded(
                child: StreamBuilder(
                    stream: fb.collectionReference.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      }
                      this.listService.clear();
                      snapshot.data!.docs.forEach((element) {
                        if(this.seachControler.text.isEmpty||element['name'].toString().contains(seachControler.text))
                        this.listService.add(ServiceInfo(
                            id: element['id'], name: element['name'], type: element['type'],iconPath: element['icon'],detail: element['note'],charge: element['charge']));
                        print('Ten dich vu:###${element['name']}');
                      }
                      );
                      return GridView.builder(
                          itemCount: listService.length,
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 2 / 2.5,
                            crossAxisCount: 3,
                          ),
                          itemBuilder: (context, index) {
                            return ServiceCard(info: listService[index],onPressed: (){ this.modifi(listService[index]); },);
                           // return ServiceBox(listService[index]);
                            // QueryDocumentSnapshot x = snapshot.data!.docs[index];
                            //   //  if(!x['name'].toString().contains(this.seachControler.text))
                            // return ServiceBox(ServiceInfo(
                            //     id: x['id'], name: x['name'], type: x['type'],iconPath: x['icon'],detail: x['note'],charge: x['charge']));

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
        : 'assets/images/add_icon.png';
    String temp1 = '/';
    temp1 = info.type != null ? temp1 + info.type.toString() : '';

    String detail = (info.charge != null && info.charge!.contains(new RegExp(r'[0-9]'))
        ? info.charge.toString() + 'VND'
        : '0vnd');
    print(detail);
    print(temp1);
    if(temp1.contains('Lũy tiền theo chỉ số đồng hồ')) temp1='';
    return GestureDetector(
      onTap: () {
        this.modifi(info);
      //  this.modifiService(info);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 4, 0, 10),
                child: SizedBox(height: 125,child: Image.asset(pathAsset, fit: BoxFit.fill)),
              ),
              Text(
                info.name.toString(),
                style: TextStyle(fontSize: 18),
              ),
              SizedBox.fromSize(size: Size(0,4),),
              Text(detail + temp1, style: MyStyle().style_text_tff(),)
            ],
          ),
        ),
      ),
    );
  }
}

