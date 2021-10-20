

import 'package:apartment_app/src/pages/service_info.dart';



import 'package:flutter/material.dart';

import 'add_icon_page.dart';

class AddServicPage extends StatefulWidget {


  ServiceInfo? sv;
  AddServicPage({this.sv ,Key? key}): super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createStatee
    print('create state');
    if(sv==null) {
      return StateAddPage();
    }

    var temp= StateAddPage();
    temp.sv=sv;
    print(this.sv!=null? this.sv?.name.toString():'sth wrong');
    if(this.sv!=null) temp.filltemplate(this.sv);
    return temp;

  }
}

class StateAddPage extends State<AddServicPage> {
  String pathAsset = 'assets/images/service_icon/add_icon.png';
  String type = 'Thu phi dua tren';
  TextEditingController chargeController= new TextEditingController();
  TextEditingController nameController= new TextEditingController();
  TextEditingController noteController= new TextEditingController();
  String? name;
  String? notes;
  String? charge;
  ServiceInfo ?sv;
  String buttonText='Them Dich Vu';

  late ServiceInfo info;
  ServiceInfo? get service=>sv;



  void setTypeService (String name, BuildContext ct) {
    setState(() {
      this.type = name;
      Navigator.pop(ct);
    });
  }
  void callname(){
    print('sth else');

  }
  void filltemplate(ServiceInfo? service){
    this.buttonText='Thay doi thong tin';
    this.nameController.text=service!.name.toString();
    this.chargeController.text=service.charge.toString();
    pathAsset=service.iconPath.toString();
    type= service.type.toString();
    noteController.text= service.detail.toString();


  }
  void setIconPath(String path) {
    pathAsset = path;
  }
  bool checkService() {
    if (info.iconPath == 'assets/images/service_icon/add_icon.png') {
      getMes('Chua them icon');
      return false;
    } else if (info.type == 'Thu phi dua tren') {
      getMes('Chưa thêm hình thưc thu phí ');
      return false;
    } else if (info.name == null || info.name!.isEmpty) {
      getMes('Chưa thêm tên dịch vụ');
      return false;
    }
    return true;
  }
  void getMes  (String msg) {

    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: Text(msg))
    );
  }
  Widget getTypeButton(String name, String discripe, BuildContext context) {

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          onPressed: () => this.setTypeService(name, context),
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(name,style: TextStyle(color:Colors.black,fontSize:20,fontWeight: FontWeight.bold),),
              Text(discripe,style: TextStyle(color:Colors.grey.shade400,fontSize:18),),
            ],
          ),
        ),
      ),
    );
  }




  void setIcon() async {
    Route route = MaterialPageRoute(builder: (context) => IconList());
    final Result = await Navigator.push(this.context, route);
    print(Result.toString());
    if(Result==null) return;
    setState(() {
      this.pathAsset = Result;
    });
  }

  void ChoiceType() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        builder: (BuildContext conText) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  getTypeButton('Luy tien theo chi so dong ho', 'Dich vu co chi so dau cuoi', conText),
                  getTypeButton('Nguoi', 'Tinh theo so nguoi', conText),
                  getTypeButton('Phong', 'Tinh theo phonh', conText),
                  getTypeButton('So lan su dung', 'tinh theo so lan', conText),
                  getTypeButton('Khac', 'Tuy chinh', conText),
                ],
              ),
            ),
          );
        });
  }

  StateAddPage({this.sv}){

    print(this.sv?.name != null?this.sv?.name.toString():'');
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text(buttonText, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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

            controller: this.nameController,
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
                  this.type!=null? this.type:'Thu phi dua tren',
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

            controller: this.chargeController,
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
            controller: this.noteController,
            keyboardType: TextInputType.multiline,
          ),
          SizedBox(
            height: 50,
          ),


          RaisedButton(
            onPressed:() {
              /*   print('============');
             print(this.nameController.text);
             print(this.noteController.text);
              print(this.pathAsset);
             print(this.chargeController.text);
              print(this.type);
            print('============');

          */
              this.info= new ServiceInfo(
                  name :this.nameController.text,
                  charge: this.chargeController.text,
                  iconPath: pathAsset,
                  type: type,
                  detail: noteController.text
              );


              if(this.checkService())
              {
                Navigator.pop(context,this.info);
              }
            },
            padding: EdgeInsets.fromLTRB(0, 24, 0, 24),
            color: Colors.green,
            child: Text(
              buttonText,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
          )

        ],
      ),
    );
    throw UnimplementedError();
  }
}
