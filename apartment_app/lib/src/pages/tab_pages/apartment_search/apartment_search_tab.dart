import 'dart:async';
import 'dart:async';
import 'package:apartment_app/src/pages/apartment/view/apartment_detail_page.dart';

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
    return temp;
  }
}

class _ApartmentSearchTabState extends State<ApartmentSearchTab> {
  TextEditingController searchController = new TextEditingController();
  List<ApartmentModel>listApartmentCache =[];
  FloorInfoFB floorInfoFB = new FloorInfoFB();
  int radioValue = 1;
  bool option= true;
  List<String> stateindex = ['Trống', 'Đang thuê', 'Đã bán','Tất cả'];
  String hitText= 'Tên căn hộ';
  String? state='Tất cả';

  _dropDownList() => DropdownButton(
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

   bool _filter(ApartmentModel temp){
    print(this.radioValue.toString());
     if((temp.status==this.state||this.state==null||this.state=='Tất cả')&&
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
    keyboardType: TextInputType.name,
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
      backgroundColor: Colors.white.withOpacity(0.9),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Card(
              elevation: 2,
              child: Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: _SearchBar(),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {});
                              },
                              iconSize: 35,
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
                    ListTile(
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
                    ListTile(
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
                  ],
                ),
              ),
            ),

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
    );
  }
}