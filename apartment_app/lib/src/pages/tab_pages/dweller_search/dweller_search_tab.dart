import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/fire_base/fb_floor_info.dart';
import 'package:apartment_app/src/pages/apartment/firebase/fb_service_apartment.dart';
import 'package:apartment_app/src/pages/dweller/firebase/fb_dweller.dart';
import 'package:apartment_app/src/pages/dweller/model/dweller_model.dart';
import 'package:apartment_app/src/pages/dweller/view/detail_dweller_page.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/cards/dweller_card.dart';
import 'package:apartment_app/src/widgets/cards/seach_dweller_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dweller_detail.dart';



class DwellerSearchTab extends StatefulWidget {
  const DwellerSearchTab({Key? key}) : super(key: key);

  @override
  _DwellerSearchTabState createState() {
    final temp=_DwellerSearchTabState();
    return temp;
  }
}

class _DwellerSearchTabState extends State<DwellerSearchTab> {
  TextEditingController searchController = new TextEditingController();
  List<Dweller>Cache =[];
  List<String> ListApartment=[];
  FloorInfoFB apartmentFB= new FloorInfoFB();
  String apartment= 'Tất cả';
  DwellersFB fb= new DwellersFB();
  int radioValue = 1;
  String hitText= 'Họ và tên';
  String? state='Tất cả';
  bool check=false;
  String? gioiTinh= 'Tất cả';
  List<String> gt=['Tất cả','Nam','Nữ'];
  void filterBottomSheep() {
    showModalBottomSheet(builder: (BuildContext context) {
      return StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState1) {
        return Container(
          padding: EdgeInsets.all(16),
          height: 270,
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
                      'Căn hộ:',
                      style:  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    StreamBuilder(
                        stream: this.apartmentFB.collectionReference.snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: Text("No Data"),);
                          }
                          this.ListApartment.clear();
                          ListApartment.add('Tất cả');
                          snapshot.data!.docs.forEach((element) {
                            if(!this.ListApartment.contains(element['name']))
                              this.ListApartment.add(element['name']);
                          }
                          );
                          return  DropdownButton(
                            hint: Text(this.apartment.toString(),  style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),),
                            iconSize: 36,
                            onChanged: (temp) {
                              setState(() {
                                this.apartment = temp.toString();
                              });
                              setState1((){
                              });
                            },
                            items: this.ListApartment.map<DropdownMenuItem<String>>((String value) {
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
                      'Giới tính:',
                      style:  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    DropdownButton(
                      hint: Text(this.gioiTinh.toString(),  style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: this.gioiTinh.toString()=='Nam'? myRed :  this.gioiTinh.toString()=='Nam'? myYellow: Colors.grey,
                      ),),
                      iconSize: 36,
                      onChanged: (temp) {
                        setState(() {
                          this.gioiTinh = temp.toString();
                        });
                        setState1((){
                        });
                      },
                      items: this.gt.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: [
                    Text(
                      'Chưa đầy đủ thông tin:',
                      style:  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Checkbox(value: check,
                        onChanged: (value){
                          setState(() {
                            this.check=value!;
                          });
                          setState1((){
                          });
                        })
                  ],
                ),
              ),

            ],),
        );
      },

      );

    }, context: context);
  }
  bool chechInfo(Dweller temp){
    if(temp.homeTown!.isEmpty||temp.phoneNumber!.isEmpty||temp.gender!.isEmpty
        ||temp.email!.isEmpty||temp.name!.isEmpty||temp.birthday!.isEmpty)
      return true;
    return false;
  }
  bool _filter(Dweller temp){
    bool KTGioiTinh= true ;
    bool KTroom=true;
    if(this.gioiTinh=='Tất cả'||(this.gioiTinh=='Nam'&&temp.gender=='0')||(this.gioiTinh=='Nữ'&&temp.gender=='1'))
      KTGioiTinh=true;
    else KTGioiTinh=false;
    if(this.apartment=='Tất cả'||this.apartment==temp.idApartment)
    KTroom=true;
    else KTroom=false;

    if((!check||this.chechInfo(temp))&&
        KTGioiTinh&&KTroom&&
        (temp.name!.toLowerCase().contains(this.searchController.text.toLowerCase())||this.searchController.text.isEmpty)
    )
      return true;
    return false;
  }
  _SearchBar() => TextField(

    style: MyStyle().style_text_tff(),
    controller: this.searchController,
    onChanged: (value){
      setState(() {
      });
    },
    keyboardType: TextInputType.name,
    decoration: InputDecoration(
      hintText: this.hitText,
      icon: Icon(Icons.search)
    ),
  );
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
        padding: EdgeInsets.all(16),
        child: Column(

          children: [
            SizedBox(height: 15,),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                children: [
                  Expanded(
                    child: _SearchBar(),
                  ),
                  IconButton(
                      color:myGreen ,
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        filterBottomSheep();
                      },
                      iconSize: 45,
                      icon:Icon(Icons.filter_list))
                ],
              ),
            ),
            SizedBox(height: 15,),
            Expanded(
                child: StreamBuilder(
                    stream: this.fb.collectionReference.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: Text("No Data"));
                      }
                      this.Cache.clear();
                      snapshot.data!.docs.forEach((element) {
                        Dweller temp = Dweller.fromDocument(element);
                        if (this._filter(temp))
                          this.Cache.add(temp);
                      });
                      return ListView.builder(
                          itemCount: this.Cache.length,
                          itemBuilder: (context, index) {
                            return DwellerCard(dweller: this.Cache[index], funtion: (){
                              //Route route = MaterialPageRoute(builder: (context) => DetailDwellerPage(dweller: this.Cache[index], ));
                              //Navigator.push(context,route);
                            });
                          });
                    })
            ),
          ],
        ),
      ),
    );
  }
}
