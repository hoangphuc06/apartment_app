import 'package:animated_float_action_button/animated_floating_action_button.dart';
import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/dweller/firebase/fb_dweller.dart';
import 'package:apartment_app/src/pages/dweller/model/dweller_model.dart';
import 'package:apartment_app/src/pages/dweller/view/edit_dweller_page.dart';
import 'package:apartment_app/src/widgets/appbars/my_app_bar.dart';
import 'package:apartment_app/src/widgets/dialog/msg_dilog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailDwellerPage extends StatefulWidget {
  late  Dweller dweller;
  final String id;
  DetailDwellerPage({Key? key,
  required this.dweller, required this.id}) : super(key: key);

  @override
  _DetailDwellerPageState createState() => _DetailDwellerPageState();
}

class _DetailDwellerPageState extends State<DetailDwellerPage> {

  final GlobalKey<AnimatedFloatingActionButtonState> fabKey = GlobalKey();
  DwellersFB dwellersFB = new DwellersFB();
  bool _isAdd = false;
  bool _canDelete = false;

  @override
  Widget build(BuildContext context) {
    CheckforDelete();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar("Hồ sơ"),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: StreamBuilder(
              stream: dwellersFB.collectionReference.where('idApartment', isEqualTo: widget.dweller.idApartment).where('id', isEqualTo: widget.dweller.id).snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Text("No Data"),);
                } else {
                  QueryDocumentSnapshot x = snapshot.data!.docs[0];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Thông tin chi tiết
                      _title("Thông tin chi tiết"),
                      SizedBox(height: 10,),
                      _detail("Họ tên", x["name"]),
                      SizedBox(height: 10,),
                      _detail("Giới tính", x["gender"]=="0"?"Nam":"Nữ"),
                      SizedBox(height: 10,),
                      _detail("Ngày sinh", x["birthday"]),
                      SizedBox(height: 10,),
                      _detail("CMND/CCCD", x["cmnd"]==""?"Trống":x["cmnd"]),
                      SizedBox(height: 10,),
                      _detail("Quê quán", x["homeTown"]),
                      SizedBox(height: 10,),
                      _detail("Nghề nghiệp", x["job"]),

                      //Cư trú
                      SizedBox(height: 30,),
                      _title("Cư trú"),
                      SizedBox(height: 10,),
                      _detail("Căn hộ", x["idApartment"]),

                      //Liên hệ
                      SizedBox(height: 30,),
                      _title("Liên hệ"),
                      SizedBox(height: 10,),
                      _detail("Số điện thoại", x["phoneNumber"]==""?"Trống":x["phoneNumber"]),
                      SizedBox(height: 10,),
                      _detail("Email", x["email"]==""?"Trống":x["email"]),

                      //Ghi chú
                      SizedBox(height: 30,),
                      _title("Khác"),
                      SizedBox(height: 10,),
                      _note(x["note"]),

                      SizedBox(height: 50,)
                    ],
                  );
                }
              }
          ),
        ),
      ),
      floatingActionButton: AnimatedFloatingActionButton(
          key: fabKey,
          fabButtons: <Widget>[
            edit(),
            delete(),
          ],
          colorStartAnimation: myGreen,
          colorEndAnimation: myGreen,
          animatedIconData: AnimatedIcons.menu_close //To principal button
      ),
    );
  }

  _detailInfo(IconData icons, String title, String value) => Row(
    children: [
      Icon(icons),
      SizedBox(width: 5,),
      Text(title, style: TextStyle(fontSize: 15),),
      Spacer(),
      Text(value, style: TextStyle(fontSize: 15),),
    ],
  );

  Widget edit() {
    return FloatActionButtonText(
      onPressed: (){
        fabKey.currentState!.animate();
        _gotoPage();
      },
      icon: Icons.mode_edit,
      text: "Sửa",
      textLeft: -80,
    );
  }

  void _gotoPage() async {
    final Dweller d = await Navigator.push(context, MaterialPageRoute(builder: (context) => EditDwellerPage(this.widget.dweller, this.widget.id)));
    if (d!=null) {
      setState(() {
        this.widget.dweller = d;
      });
    }
  }

  Widget delete() {
    return FloatActionButtonText(
      onPressed: _isAdd == false ? () => _AddConfirm(context) : null,
      icon: Icons.delete,
      textLeft: -80,
      text: "Xóa",
    );
  }

  _title(String text) => Text(
    text,
    style: TextStyle(
        color: Colors.black.withOpacity(0.5),
        fontWeight: FontWeight.bold
    ),
  );

  _detail(String name, String detail) => Container(
    padding: EdgeInsets.all(8),
    height: 50,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.blueGrey.withOpacity(0.2)
    ),
    child: Row(
      children: [
        Text(
          name,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
        ),
        Spacer(),
        Text(
          detail,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500
          ),
        ),
      ],
    ),
  );

  _note(String text) => Container(
    width: double.infinity,
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.blueGrey.withOpacity(0.2),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ghi chú",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10,),
        Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            height: 1.2,
          ),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 10,),
      ],
    ),
  );

  void _AddConfirm(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('XÁC NHẬN'),
            content: Text('Bạn có chắc muốn xóa thành viên này?'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    // Remove the box
                    setState(() {
                      _isAdd = false;
                    });
                    fabKey.currentState!.animate();
                    if(_canDelete == true)
                    {
                      fabKey.currentState!.animate();
                      this.dwellersFB.delete(widget.dweller.id.toString());
                      Navigator.pop(context);
                      Navigator.of(context).pop();
                    }
                    else {
                      // Close the dialog
                      Navigator.of(context).pop();
                      MsgDialog.showMsgDialog(
                          context, "Không thể xóa thành viên có tên trong hợp đồng",
                          "");
                    }
                  },
                  child: Text('Có')),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: Text('Không'))
            ],
          );
        });
  }

  Future<void> CheckforDelete() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("contract").where('renter',isEqualTo: widget.dweller.id.toString()).get();
    //var con = contractFB.collectionReference.where('room',isEqualTo: this.widget.id_apartment).get();
    print(querySnapshot.docs.length);
    if(querySnapshot.docs.length == 0) {
      print("oke");
      _canDelete = true;
    }
    else {
      print("not oke");
      _canDelete = false;
    }
  }

}
