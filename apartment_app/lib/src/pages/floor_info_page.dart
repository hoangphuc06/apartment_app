
import 'package:apartment_app/src/fire_base/fb_floor_info.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class FloorInfoPage extends StatefulWidget{

  final String floorid;
  final String floorname;
  FloorInfoPage({required this.floorid,required this.floorname});
  //const FloorInfoPage({Key ? key}) : super(key: key);

  @override
  _FloorInfoPageState createState() => _FloorInfoPageState();
}

class _FloorInfoPageState  extends State<FloorInfoPage>{
  FloorInfoFB floorInfoFB = new FloorInfoFB();

  bool _isAdd = true;

  final TextEditingController _idcontroler = TextEditingController();
  final TextEditingController _namecontroler = TextEditingController();
  final TextEditingController _statuscontroler = TextEditingController();

  void binding(QueryDocumentSnapshot x){
    _idcontroler.text = x['id'];
    _namecontroler.text = x['name'];
    _statuscontroler.text = x['status'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.chevron_left), onPressed: ()
        {
          Navigator.pop(context);
        }),
        elevation: 0,
        centerTitle: true,
        title:  Text(widget.floorname,style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Expanded(
          child: SingleChildScrollView(
            child: StreamBuilder(
              stream: floorInfoFB.collectionReference.where('floorid', isEqualTo: widget.floorid).snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: Text("No Data", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22)),);
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, i) {
                          QueryDocumentSnapshot x = snapshot.data!.docs[i];
                          return Card(
                            color: Colors.grey,
                            elevation: 1,
                            child: ListTile(
                              onTap: () {
                                binding(x);
                                _isAdd = false;
                                _FillDetailOfRoom(context);
                              },
                            title: (Text(x['name'], style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            )
                            ),
                              subtitle: (Text(x['status'], style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),)
                              ),
                          ),
                          );
                        }
                    );
                  }
                }
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add",
        child: Icon(Icons.add),
        onPressed: (){
          _isAdd = true;
          _FillDetailOfRoom(context);
        }
      ),
    );
  }

  void _AddRoom(){
    floorInfoFB.add(widget.floorid, _namecontroler.text,'trống').then((value) => {
      _namecontroler.clear(),
      Navigator.pop(context),
    });
  }
  void _EditRoom(){
    floorInfoFB.update(_idcontroler.text,widget.floorid,_namecontroler.text,_statuscontroler.text).then((value) => {
      _idcontroler.clear(),
      _namecontroler.clear(),
      Navigator.pop(context),
    });
  }
  void _DeleteRoom()
  {
    Navigator.pop(context);
  }

  void _FillDetailOfRoom(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SingleChildScrollView(
                child: Wrap(
                  runSpacing: 10,
                  children: <Widget>[
                    Text(
                      "Thêm căn hộ",
                      style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Vui lòng nhập tên  căn hộ";
                        }
                        return null;
                      },
                      controller: _namecontroler,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.home_sharp),
                          hintText: 'Tên căn hộ',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )
                      ),
                    ),
                    MainButton(name: _isAdd ? "Thêm" : "Sửa",
                        onpressed: _isAdd ? _AddRoom : () {
                          _EditRoom();
                        }
                        ),
                  ],
                )
            ),
          );
        },

    );
  }


}

