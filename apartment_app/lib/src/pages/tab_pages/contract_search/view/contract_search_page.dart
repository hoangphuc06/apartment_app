import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/apartment/firebase/fb_service_apartment.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_contract.dart';
import 'package:apartment_app/src/pages/contract/model/contract_model.dart';
import 'package:apartment_app/src/pages/contract/view/contract_details_page.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/cards/contract_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class ContractSearchTab extends StatefulWidget {
  const ContractSearchTab({Key? key}) : super(key: key);

  @override
  _ContractSearchTabState createState() {
    final temp=_ContractSearchTabState();
    return temp;
  }
}

class _ContractSearchTabState extends State<ContractSearchTab> {
  TextEditingController searchController = new TextEditingController();
  List<Contract>Cache =[];
  List<String> ListApartment=[];
  ContractFB fb= new ContractFB();
  ServiceApartmentFB apartmentFB= new ServiceApartmentFB();
  int radioValue = 1;
  bool option= true;
  String hitText= 'mã hợp đồng';
  String apartment= 'Tất cả               ';
  bool check=false;
  String? type= 'Tất cả';
  List<String> typelist=['Tất cả','Hợp đồng bán','Hợp đông thuê'];

  List<String> listContract = <String>[];

  Future<void> loadData() async {
    ContractFB contractFB = new ContractFB();
    listContract.add('h');
    Stream<QuerySnapshot> query = contractFB.collectionReference
        .where('liquidation', isEqualTo: false)
        .snapshots();
    await query.forEach((x) {
      x.docs.asMap().forEach((key, value) {
        var t = x.docs[key];
        listContract.add(t['id']);
      });
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  void filterBottomSheep() {
    showModalBottomSheet(builder: (BuildContext context) {
      return StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState1) {
        return Container(
          padding: EdgeInsets.all(16),
          height: 240,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Tìm kiếm theo',style: TextStyle(fontSize: 24,color: myGreen,fontWeight: FontWeight.bold),)
                ],
              ),
              SizedBox(height: 20,),
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
                          ListApartment.add('Tất cả               ');
                          snapshot.data!.docs.forEach((element) {
                            if(!this.ListApartment.contains(element['idRoom']))
                            this.ListApartment.add(element['idRoom']);
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
                      'Loại hơp đồng:',
                      style:  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    DropdownButton(
                      hint: Text(this.type.toString(),  style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: this.type.toString()=='Hợp đồng bán'? myRed :  this.type.toString()=='Hợp đông thuê'? myYellow: Colors.grey,
                      ),),
                      iconSize: 36,
                      onChanged: (temp) {
                        setState(() {
                          this.type = temp.toString();
                        });
                        setState1((){
                        });
                      },
                      items: this.typelist.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),


            ],),
        );
      },

      );

    }, context: context);
  }

  bool _filter(Contract temp){
      if((this.apartment=='Tất cả               '||this.apartment==temp.room)&&
          (this.type=='Tất cả'||(this.type=='Hợp đồng bán'&&temp.type=='0')||(this.type=='Hợp đông thuê'&&temp.type=='1'))&&
          (temp.id!.contains(this.searchController.text)||this.searchController.text.isEmpty))return true;
      return false;

  }
  _SearchBar() => TextField(

    style: MyStyle().style_text_tff(),
    controller: this.searchController,
    onChanged: (value){
      setState(() {
      });
    },
    keyboardType: TextInputType.phone,
    decoration: InputDecoration(
        hintText: this.hitText,
        icon: Icon(Icons.search)
    ),
  );

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
                        Contract temp = Contract.fromDocument(element);
                        if (this._filter(temp))
                          this.Cache.add(temp);
                      });
                      return ListView.builder(
                          itemCount: this.Cache.length,
                          itemBuilder: (context, index) {
                            return  ContractCard(id: Cache[index].id.toString(),
                              startDay: Cache[index].startDay.toString(),
                              expirationDate: Cache[index].expirationDate.toString(),
                              room: Cache[index].room.toString(),
                              host: Cache[index].host.toString(),
                              funtion: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ContractDetails(
                                        id:  Cache[index].id.toString(),
                                        idRoom:  Cache[index].room.toString(),
                                        flag: '0',
                                        listContract: listContract,
                                      )));
                            }
                            );
                          });
                    })
            ),
          ],
        ),
      ),
    );
  }
}
