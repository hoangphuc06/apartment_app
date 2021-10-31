

import 'package:apartment_app/src/pages/service/model/service_info.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/title/title_info_null.dart';
import 'package:apartment_app/src/widgets/title/title_info_not_null.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:flutter/material.dart';

import '../../add_icon_page.dart';

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
      padding: const EdgeInsets.all(9),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          padding: const EdgeInsets.all(8),
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
    Route route = MaterialPageRoute(builder: (context) => IconList(path: 'assets/images/service_icon/',));
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
                  getTypeButton('Lũy tiền theo chỉ số đồng hồ', 'Dich vụ có chỉ số đầu cuối', conText),
                  getTypeButton('Người ', 'Tinh theo so nguoi', conText),
                  getTypeButton('Phòng', 'Tính theo phòng', conText),
                  getTypeButton('Số lần sử dụng', 'Tính theo số lần', conText),
                  getTypeButton('Khác', 'Tùy chỉnh', conText),
                ],
              ),
            ),
          );
        });
  }

  StateAddPage({this.sv}){

    print(this.sv?.name != null?this.sv?.name.toString():'');
  }
  _nameTextField() => TextFormField(
    style: MyStyle().style_text_tff(),
    controller: this.nameController,
    decoration: InputDecoration(
      hintText:  'Dien,Nuoc,Thang may,bao ve,..',
    ),
    keyboardType: TextInputType.name,
    validator: (val) {
      if (val!.isEmpty) {
        return "Vui lòng nhập ten";
      }

      return null;
    },
  );
  _chargeTextField() => TextFormField(
    style: MyStyle().style_text_tff(),
    controller: this.chargeController,

    decoration: InputDecoration(
      hintText:  'O VND',

    ),
    keyboardType: TextInputType.number,


  );
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        child: Column(

          // mainAxisAlignment: MainAxisAlignment.start,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleInfoNotNull(text: "Ten dich vu"),
            SizedBox(height: 30,),
            _nameTextField(),
            SizedBox(height: 30,),
            TitleInfoNotNull(text: "Thu phi dua tren"),
            SizedBox(height: 30,),
            RaisedButton(
              padding: EdgeInsets.all(10),
              onPressed: this.ChoiceType,
              color: Colors.grey.shade50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    this.type!=null? this.type:'Thu phi dua tren',
                    style: TextStyle(fontSize: 17,color: Colors.grey.shade600),
                  ),
                  Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 25,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30,),
            TitleInfoNull(text:  'Phi dich vu'),
            SizedBox(height: 30,),
            _chargeTextField(),
            SizedBox(height: 30,),
            RaisedButton(
              color: Colors.grey.shade50,
              onPressed: () {},
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleInfoNotNull(text: 'Anh dai dien'),


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
            SizedBox(height: 30,),
            TitleInfoNull(text: 'Ghi chu'),
            SizedBox(height: 30,),
            TextField(
              style: MyStyle().style_text_tff(),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1,color: Colors.grey.shade300),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),),
                hintText: 'Nhap ghi chu',
              ),
              minLines: 5,
              maxLines: 8,
              controller: this.noteController,
              keyboardType: TextInputType.multiline,
            ),
            SizedBox(
              height: 30,
            ),

            MainButton(name:buttonText, onpressed: () {
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
            }),
        /*    RaisedButton(
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
            )*/

          ],
        ),
      ),
    );
    throw UnimplementedError();
  }
}
