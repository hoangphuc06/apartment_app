import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/dweller/firebase/fb_dweller.dart';
import 'package:apartment_app/src/pages/dweller/model/dweller_model.dart';
import 'package:apartment_app/src/pages/dweller/view/detail_dweller_page.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/cards/dweller_card.dart';
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
  DwellersFB fb= new DwellersFB();
  int radioValue = 1;
  bool option= true;
  String hitText= 'Họ và tên';
  String? state='Tất cả';
  bool check=false;
  String? gioiTinh= 'Tất cả';
  String role='Tất cả';
  List<String> roleindex=['Tất cả','Chủ hộ','Người thân chủ hộ','Người thuê lại'];
  bool setVisible= true;
  List<String> gt=['Tất cả','Nam','Nữ'];
  bool chechInfo(Dweller temp){
    if(temp.homeTown!.isEmpty||temp.phoneNumber!.isEmpty||temp.gender!.isEmpty
        ||temp.email!.isEmpty||temp.name!.isEmpty||temp.birthday!.isEmpty)
      return true;
    return false;
  }
  bool _filter(Dweller temp){
    bool KTGioiTinh= true ;
    if(this.gioiTinh=='Tất cả'||(this.gioiTinh=='Nam'&&temp.gender=='0')||(this.gioiTinh=='Nữ'&&temp.gender=='1'))
      KTGioiTinh=true;
    else KTGioiTinh=false;
    bool chekRole= true;
    if(this.role=='Tất cả'||(this.role=='Chủ hộ'/*&&temp.role=='1'*/)||(this.role=='Người thân chủ hộ'/*&&temp.role=='2'*/)||(this.role=='Người thuê lại'/*&&temp.role=='3'*/))
      chekRole=true;
    else chekRole=false;
    if((!check||this.chechInfo(temp))&&KTGioiTinh&&chekRole&&
        ((this.option&&(temp.name!.contains(this.searchController.text)||this.searchController.text.isEmpty))
            ||(!this.option&&(temp.cmnd!.contains(this.searchController.text)||this.searchController.text.isEmpty)))
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
    keyboardType: this.option? TextInputType.name: TextInputType.phone,
    decoration: InputDecoration(
      hintText: this.hitText,
      icon: Icon(Icons.search)
    ),
  );
  _dropDownList() => DropdownButton(
    hint: Text(this.gioiTinh.toString(),  style: TextStyle(
      fontWeight: FontWeight.bold,
      color: this.gioiTinh.toString()=='Nam'? myRed :  this.gioiTinh.toString()=='Nam'? myYellow: Colors.grey,
    ),),
    iconSize: 36,
    onChanged: (temp) {
      setState(() {
        this.gioiTinh = temp.toString();
      });
    },
    items: this.gt.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
  );
  _roleDownList() => DropdownButton(
    hint: Text(this.role),
    iconSize: 36,
    onChanged: (temp) {
      setState(() {
        this.role = temp.toString();
      });
    },
    items: this.roleindex.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
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
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(0.18),
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Row(
                        children: [
                          Text('Tìm kiếm dân cư',style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),),
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
                        visible:  this.setVisible,
                        child:Column(
                      children: [
                      Container(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: _SearchBar(),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        title: Text('Họ tên', style:  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                        leading: Radio(
                          value: 1,
                          groupValue: this.radioValue,
                          onChanged: (value) {
                            setState(() {
                              hitText= 'Họ và tên';
                              this.radioValue = 1;
                              this.searchController.text='';
                              option=true;
                            });
                          },
                          activeColor: Colors.green,
                        ),
                      ),
                      ListTile(
                        title: Text('CMND/CCCD',style:  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                        leading: Radio(
                          value: 2,
                          groupValue: this.radioValue,
                          onChanged: (value) {
                            setState(() {
                              this.radioValue=2;
                              this.searchController.text='';
                              this.hitText='Số CMND/CCCD';
                              this.option= false;
                            });
                          },
                          activeColor: Colors.green,
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
                            _dropDownList()
                          ],
                        ),
                      ),
                        Container(
                          padding: EdgeInsets.only(left: 16, right: 16),
                          child: Row(
                            children: [
                              Text(
                                'Vai trò:',
                                style:  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              _roleDownList()
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
                                })
                          ],
                        ),
                      ),

                    ],)),

                  ],
                ),
              ),
            ),
            SizedBox(height: 7,),
            Expanded(
                child: StreamBuilder(
                    stream: this.fb.collectionReference.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: Text("No Data"));
                      }
                      this.Cache.clear();
                      snapshot.data!.docs.forEach((element) {
                        Dweller temp= Dweller.fromDocument(element);
                        if(this._filter(temp))
                          this.Cache.add(temp);
                      }
                      );
                      return ListView.builder(
                          itemCount: this.Cache.length,
                          itemBuilder: (context, index) {
                            return DwellerCard(dweller: this.Cache[index], funtion: (){
                              Route route = MaterialPageRoute(builder: (context) => DetailDwellerPage(dweller: this.Cache[index], ));
                              Navigator.push(context,route);
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
