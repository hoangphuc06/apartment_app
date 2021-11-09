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

  //  Future<List<ApartmentModel>>? _init() async {
  //   List<ApartmentModel> listApartment = [];
  //   QuerySnapshot eventsQuery = await floorInfoFB.collectionReference.get();
  //   eventsQuery.docs.forEach((element) async {
  //     ApartmentModel temp = ApartmentModel.fromDocument(element);
  //     await temp.setInfo();
  //     listApartment.add(temp);
  //   });
  //   this.listApartmentCache=listApartment;
  //   return listApartment;
  // }

  bool chechInfo(Dweller temp){
    if(temp.homeTown!.isEmpty||temp.phoneNumber!.isEmpty||temp.gender!.isEmpty
        ||temp.email!.isEmpty||temp.name!.isEmpty||temp.birthday!.isEmpty)
      return false;
    return true;
  }
  bool _filter(Dweller temp){
    if((!check||!this.chechInfo(temp))&&
        ((this.option&&(temp.name!.contains(this.searchController.text)||this.searchController.text.isEmpty))
            ||(!this.option&&(temp.cmnd!.contains(this.searchController.text)||this.searchController.text.isEmpty)))
    )
      return true;
    return false;
  }
  _SearchBar() => TextField(
    style: MyStyle().style_text_tff(),
    controller: this.searchController,
    keyboardType: this.option? TextInputType.name: TextInputType.phone,
    decoration: InputDecoration(
      hintText: this.hitText,
    ),
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
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: _SearchBar(),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {});
                    },
                    iconSize: 50,
                    icon: Icon(Icons.search)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListTile(
                    title: Text('Theo tên'),
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
                ),
                Expanded(
                  child: ListTile(
                    title: Text('Theo số CMND'),
                    leading: Radio(
                      value: 2,
                      groupValue: this.radioValue,
                      onChanged: (value) {
                        setState(() {
                          this.radioValue=2;
                          this.searchController.text='';
                          this.hitText='số CMND của dân cư';
                          this.option= false;
                        });
                      },
                      activeColor: Colors.green,
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Chưa đầy đủ thông tin:',
                  style: MyStyle().style_text_tff(),
                ),
                Checkbox(value: check,
                    onChanged: (value){
                      setState(() {
                        this.check=value!;
                      });
                    })
              ],
            ),
            Expanded(
                child: StreamBuilder(
                    stream: this.fb.collectionReference.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
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
