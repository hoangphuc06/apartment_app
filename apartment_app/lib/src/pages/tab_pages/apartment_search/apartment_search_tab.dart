import 'dart:async';
import 'dart:async';
import 'dart:collection';
import 'package:apartment_app/src/pages/apartment/view/apartment_detail_page.dart';
import 'package:apartment_app/src/pages/category_apartment/firebase/fb_category_apartment.dart';
import 'package:apartment_app/src/pages/category_apartment/model/category_apartment_model.dart';

import 'apartment_detail.dart';
import 'model/apartment_model.dart';

import 'package:apartment_app/src/fire_base/fb_floor_info.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/cards/apartment_card.dart';
import 'package:apartment_app/src/widgets/cards/floor_info_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class ApartmentSearchTab extends StatefulWidget {
  const ApartmentSearchTab({Key? key}) : super(key: key);

  @override
  _ApartmentSearchTabState createState() {
   final temp=_ApartmentSearchTabState();
   CategoryApartmentFB categoryApartmentFB = new CategoryApartmentFB();
   return temp;
  }
}

class _ApartmentSearchTabState extends State<ApartmentSearchTab> {
  TextEditingController searchController = new TextEditingController();
  List<ApartmentModel>listApartmentCache =[];
  FloorInfoFB floorInfoFB = new FloorInfoFB();
  CategoryApartmentFB categoryApartmentFB = new CategoryApartmentFB();
  List<String> ListCategory=[];
  Map<String,String> idAndName=new HashMap<String, String>();
  int radioValue = 1;
  bool option= true;
  String tt='';
  bool setVisible= true;
  List<String> stateindex = ['Trống', 'Đang thuê', 'Đã bán','Tất cả'];
  String hitText= 'Tên căn hộ';
  String? state='Tất cả';
  String? Category= 'Tất cả';

  _dropDownList() => DropdownButton(
    onTap: (){
      setState(() {

      });
    },
        hint: Text(this.state.toString()),
        iconSize: 36,
        onChanged: (temp) {
          setState(() {
            this.state = temp.toString();
          });
        },
        items: this.stateindex.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );
  _typeApartmentList() => DropdownButton(
    hint: Text(this.Category.toString()),
    iconSize: 36,
    onChanged: (temp) {
      setState(() {
        this.Category = temp.toString();
      });
    },
    items: this.ListCategory.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
  );
  Future<void>loadType()async {
  Future<QuerySnapshot> temp  =this.categoryApartmentFB.collectionReference.get();
  temp.then((value) {
    value.docs.forEach((element) {
      print('@@@@@@@@@@@@@@@@@@@@@@@@${element['name']}');
      this.stateindex.add(element['name']);
    });
  });




  }
  bool _filter(ApartmentModel temp){
    String value =this.idAndName.keys.firstWhere((element) => this.idAndName[element]==this.Category, orElse: () => '');
    print('so sanh ${value} :::::${temp.categoryid}');
    print(this.radioValue.toString());
     if((temp.status==this.state||this.state==null||this.state=='Tất cả')&&
         (temp.categoryid==value||value=='')&&
         ((this.option&&(temp.id!.contains(this.searchController.text)||this.searchController.text.isEmpty))
          ||(!this.option&&(temp.floorid!.contains(this.searchController.text)||this.searchController.text.isEmpty)))
     )
       return true;
       return false;
   }

  _SearchBar() => TextField(
    style: MyStyle().style_text_tff(),
    controller: this.searchController,
    decoration: InputDecoration(
      hintText: this.hitText,
    ),
    keyboardType: this.option? TextInputType.name:TextInputType.number,
    onChanged: (value){
      setState(() {

      });
    },
  );

  @override
  void didChangeDependencies()  async {
    super.didChangeDependencies();
    //try to load all your data in this method :)

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();



  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(left: 16,right: 16),
        child: Container(
          child: Column(
            children: [
              Card(
                elevation: 2,
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: Row(
                          children: [
                           Text('Tìm kiếm căn hộ',style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  this.setVisible=!this.setVisible;
                                  setState(() {});
                                },
                                iconSize: 35,
                                icon: Icon(this.setVisible? Icons.arrow_drop_up_outlined:Icons.arrow_drop_down_outlined)),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: this.setVisible,
                          child: Column(children: [
                            Container(
                              padding: EdgeInsets.only(left: 8, right: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _SearchBar(),
                                  ),
                                  SizedBox(width: 20,),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {});
                                      },
                                      iconSize: 24,
                                      icon: Icon(Icons.search)),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 16, right: 16),
                              child: Row(
                                children: [
                                  Text(
                                    'Trạng thái căn hộ:',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  Spacer(),
                                  _dropDownList()
                                ],
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 16, right: 16),
                                child: Row(
                                  children: [
                                    Text(
                                      'Loại căn hộ :',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    Spacer(),
                                    StreamBuilder(
                                        stream: this.categoryApartmentFB.collectionReference.snapshots(),
                                        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                          if (!snapshot.hasData) {
                                            return Center(child: Text("No Data"),);
                                          }
                                          this.idAndName.clear();
                                          this.ListCategory.clear();
                                          snapshot.data!.docs.forEach((element) {
                                            idAndName.putIfAbsent(element['id'], () => element['name']);
                                            this.ListCategory.add(element['name']);
                                          }
                                          );
                                          return this._typeApartmentList();
                                        }),
                                  ],
                                )
                            ),
                            Container(
                              child: ListTile(
                                title: Text('Theo tên'),
                                leading: Radio(
                                  value: 1,
                                  groupValue: this.radioValue,
                                  onChanged: (value) {
                                    setState(() {
                                      hitText= 'Tên căn hộ';
                                      this.radioValue = 1;
                                      this.searchController.text='';
                                      option=true;
                                    });
                                  },
                                  activeColor: Colors.green,
                                ),
                              ),
                            ),
                            Container(
                              child: ListTile(
                                title: Text('Theo tầng'),
                                leading: Radio(
                                  value: 2,
                                  groupValue: this.radioValue,
                                  onChanged: (value) {
                                    setState(() {
                                      this.radioValue=2;
                                      this.searchController.text='';
                                      this.hitText='Thứ tự tầng của căn hộ';
                                      this.option= false;
                                    });
                                  },
                                  activeColor: Colors.green,
                                ),
                              ),
                            ),
                          ],)
                      ),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Expanded(
                  child: StreamBuilder(
                      stream: this.floorInfoFB.collectionReference.snapshots(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: Text("No Data"),);
                        }
                        this.listApartmentCache.clear();
                        snapshot.data!.docs.forEach((element) {
                          ApartmentModel temp= ApartmentModel.fromDocument(element);
                          if(this._filter(temp))
                          this.listApartmentCache.add(temp);
                        }
                        );
                        return ListView.builder(
                            itemCount: this.listApartmentCache.length,
                            itemBuilder: (context, index) {
                              return ApartmentCard(
                                apartment: this.listApartmentCache[index],
                                funtion: ()async{
                                  await this.listApartmentCache[index].setInfo();
                                  Route route = MaterialPageRoute(builder: (context) => ApartmentDetailPage(this.listApartmentCache[index].id.toString()));
                                  Navigator.push(context,route);
                              },);
                            });
                      })
              ),
            ],
          ),
        ),
      ),
    );
  }
}
