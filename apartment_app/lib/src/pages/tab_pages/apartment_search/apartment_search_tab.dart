import 'dart:async';
import 'dart:async';
import 'dart:collection';
import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/fire_base/fb_floor.dart';
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
    final temp = _ApartmentSearchTabState();
    CategoryApartmentFB categoryApartmentFB = new CategoryApartmentFB();
    return temp;
  }
}

class _ApartmentSearchTabState extends State<ApartmentSearchTab> {
  TextEditingController searchController = new TextEditingController();
  List<ApartmentModel> listApartmentCache = [];
  FloorInfoFB floorInfoFB = new FloorInfoFB();
  CategoryApartmentFB categoryApartmentFB = new CategoryApartmentFB();
  List<String> ListCategory = [];
  List<String> floorList = [];
  Map<String, String> idAndName = new HashMap<String, String>();
  int radioValue = 1;
  bool option = true;
  String tt = '';
  FloorFB floorFB= new FloorFB();
  List<String> stateindex = ['Trống', 'Đang thuê', 'Đã bán', 'Tất cả            '];
  String hitText = 'Tên căn hộ   ';
  String? state = 'Tất cả            ';
  String? floor='Tất cả            ';
  String? Category = 'Tất cả';

  void filterBottomSheep() {
    showModalBottomSheet(
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState1) {
              return Container(
                height: 270,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Tìm kiếm theo',
                          style: TextStyle(
                              fontSize: 24,
                              color: myGreen,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                        children: [
                          Text(
                            'Trạng thái căn hộ:',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Spacer(),
                          DropdownButton(
                            onTap: () {
                              setState(() {});
                            },
                            hint: Text(
                              this.state.toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: state.toString() == "Trống"
                                      ? myGreen
                                      : state.toString() == "Đã bán"
                                          ? myRed
                                          : state.toString() == 'Đang thuê'
                                              ? Colors.orange
                                              : Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            iconSize: 36,
                            onChanged: (temp) {
                              setState(() {
                                this.state = temp.toString();
                              });
                              setState1(() {});
                            },
                            items: this
                                .stateindex
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                        children: [
                          Text(
                            'Tầng:',
                            style:  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          StreamBuilder(
                              stream: this.floorFB.collectionReference.snapshots(),
                              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(child: Text("No Data"),);
                                }
                                this.floorList.clear();
                                floorList.add('Tất cả            ');
                                snapshot.data!.docs.forEach((element) {
                                  if(!this.floorList.contains(element['id']))
                                    this.floorList.add(element['id']);
                                }
                                );
                                return  DropdownButton(
                                  hint: Text(this.floor.toString(),  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),),
                                  iconSize: 36,
                                  onChanged: (temp) {
                                    setState(() {
                                      this.floor = temp.toString();
                                    });
                                    setState1((){
                                    });
                                  },
                                  items: this.floorList.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                );
                              }),
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Row(
                          children: [
                            Text(
                              'Loại căn hộ :',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            Spacer(),
                            StreamBuilder(
                                stream: this
                                    .categoryApartmentFB
                                    .collectionReference
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: Text("No Data"),
                                    );
                                  }
                                  this.idAndName.clear();
                                  this.ListCategory.clear();
                                  this.ListCategory.add('Tất cả');
                                  snapshot.data!.docs.forEach((element) {
                                    idAndName.putIfAbsent(
                                        element['id'], () => element['name']);
                                    this.ListCategory.add(element['name']);
                                  });
                                  return DropdownButton(
                                    hint: Text(this.Category.toString()),
                                    iconSize: 36,
                                    onChanged: (temp) {
                                      setState(() {
                                        this.Category = temp.toString();
                                      });
                                      setState1(() {});
                                    },
                                    items: this
                                        .ListCategory
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  );
                                }),
                          ],
                        )),
                  ],
                ),
              );
            },
          );
        },
        context: context);
  }

  bool _filter(ApartmentModel temp) {
    String value = this.idAndName.keys.firstWhere(
        (element) => this.idAndName[element] == this.Category,
        orElse: () => '');
    bool checkFloor=true;
    if(this.floor=='Tất cả            '||temp.floorid==this.floor) checkFloor=true;
    else checkFloor=false;
    if ((temp.status == this.state ||
            this.state == null ||
            this.state == 'Tất cả            ') &&
        (temp.categoryid == value || value == ''||this.Category=='Tất cả') && checkFloor&&
        ((this.option &&
                (temp.id!.contains(this.searchController.text) ||
                    this.searchController.text.isEmpty)) ||
            (!this.option &&
                (temp.floorid!.contains(this.searchController.text) ||
                    this.searchController.text.isEmpty)))) return true;
    return false;
  }

  _SearchBar() => TextField(
        style: MyStyle().style_text_tff(),
        controller: this.searchController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            size: 27,
          ),
          hintText: this.hitText,
        ),
        keyboardType: TextInputType.number,
        onChanged: (value) {
          setState(() {});
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: _SearchBar(),
                      ),
                      IconButton(
                          color: myGreen,
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            this.filterBottomSheep();
                          },
                          iconSize: 40,
                          icon: Icon(Icons.filter_list)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                  child: StreamBuilder(
                      stream: this.floorInfoFB.collectionReference.snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text("No Data"),
                          );
                        }
                        this.listApartmentCache.clear();
                        snapshot.data!.docs.forEach((element) {
                          ApartmentModel temp =
                              ApartmentModel.fromDocument(element);
                          if (this._filter(temp))
                            this.listApartmentCache.add(temp);
                        });
                        return ListView.builder(
                            itemCount: this.listApartmentCache.length,
                            itemBuilder: (context, index) {
                              return FloorInfoCard(
                                funtion: () async {
                                  await this
                                      .listApartmentCache[index]
                                      .setInfo();
                                  Route route = MaterialPageRoute(
                                      builder: (context) => ApartmentDetailPage(
                                          this
                                              .listApartmentCache[index]
                                              .id
                                              .toString()));
                                  Navigator.push(context, route);
                                },
                                status: this
                                    .listApartmentCache[index]
                                    .status
                                    .toString(),
                                id: this
                                    .listApartmentCache[index]
                                    .id
                                    .toString(),
                              );
                            });
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
