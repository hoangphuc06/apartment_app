import 'package:flutter/material.dart';

import 'add_icon_page.dart';

class AddServicPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createStatee
    return StateAddPage();
    throw UnimplementedError();
  }
}

class StateAddPage extends State<AddServicPage> {
  String pathAsset='assets/images/service_icon/add_icon.png';
  void setTypeService(String name){
  }
  void setIconPath(String path){
    pathAsset=path;
  }
  Widget getTypeButton(String name,String discripe){

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(onPressed:()=> this.setTypeService(name) ,
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(name,style: TextStyle(color:Colors.black,fontSize:20,fontWeight: FontWeight.bold),),
              Text(discripe,style: TextStyle(color:Colors.grey.shade400,fontSize:18),)
            ],
          ),
        ),
      ),
    );
  }
  void setIcon(){
    Route route = MaterialPageRoute(builder: (context) => IconList());
    Navigator.push(this.context, route);
  }
  void ChoiceType(){
    showModalBottomSheet(context: context, shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(15)) ,builder: (BuildContext context){
      return Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              getTypeButton('Luy tien theo chi so dong ho','Dich vu co chi so dau cuoi'),
              getTypeButton('Nguoi','Tinh theo so nguoi'),
              getTypeButton('Phong','Tinh theo phonh'),
              getTypeButton('So lan su dung','tinh theo so lan'),
              getTypeButton('Khac','Tuy chinh'),
            ],
          ),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Them Dich Vu',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(18, 24, 18, 30),
        // mainAxisAlignment: MainAxisAlignment.start,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
            child: Text(
              'Ten dich vu',
              style: TextStyle(fontSize: 18),
            ),
          ),
          TextField(
            style: TextStyle(fontSize: 18, color: Colors.grey),
            decoration: InputDecoration(
              hintText: 'Dien,Nuoc,Thang may,bao ve,..',
              hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
            child: Text(
              'Thu phi dua tren',
              style: TextStyle(fontSize: 18),
            ),
          ),
          RaisedButton(
            padding: EdgeInsets.fromLTRB(10, 25, 10, 25),
            onPressed: this.ChoiceType,
            color: Colors.grey.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Thu phi dua tren',
                  style: TextStyle(fontSize: 20,color: Colors.grey.shade600),
                ),
                Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 22,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
            child: Text(
              'Phi dich vu',
              style: TextStyle(fontSize: 18),
            ),
          ),
          TextField(
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: 20, color: Colors.grey),
            decoration: InputDecoration(
              hintText: 'O VND',
              hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 20),
            ),
          ),
          RaisedButton(
            color: Colors.grey.shade50,


            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text(
                  'Anh dai dien',
                  style: TextStyle(fontSize: 18),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: setIcon,
                    child:ImageIcon(new AssetImage(pathAsset),size:25)
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
            child: Text(
              'Ghi chu',
              style: TextStyle(fontSize: 18),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1,color: Colors.grey.shade300),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),),
              hintText: 'Nhap ghi chu',

            ),
            minLines: 6,
            maxLines: 10,
            keyboardType: TextInputType.multiline,
          ),
          SizedBox(
            height: 50,
          ),
          RaisedButton(onPressed: (){},
            padding: EdgeInsets.fromLTRB(0,24 ,0 ,24 ),
            color: Colors.green,
            child: Text('Them Dich Vu',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white),),
            shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
          )
        ],
      ),
    );
    throw UnimplementedError();
  }
}
