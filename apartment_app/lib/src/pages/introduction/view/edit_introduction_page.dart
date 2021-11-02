import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/introduction/firebase/fb_introduction.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:apartment_app/src/widgets/title/title_info_not_null.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditIntroductionPage extends StatefulWidget {
  const EditIntroductionPage({Key? key}) : super(key: key);

  @override
  _EditIntroductionPageState createState() => _EditIntroductionPageState();
}

class _EditIntroductionPageState extends State<EditIntroductionPage> {
  final formKey = GlobalKey<FormState>();

  IntroductionFB introductionFB = new IntroductionFB();

  final TextEditingController _NbPhone1Controller = TextEditingController();
  final TextEditingController _NbPhone2Controller = TextEditingController();
  final TextEditingController _AddressController = TextEditingController();
  final TextEditingController _HeadController = TextEditingController();
  final TextEditingController _LinkController = TextEditingController();

  void _editInfo() {
    introductionFB
        .update(
            "1",
            _AddressController.text,
            _HeadController.text,
            _LinkController.text,
            _NbPhone1Controller.text,
            _NbPhone2Controller.text)
        .then((value) => {
              Navigator.pop(context),
            })
        .catchError((error) => {
              print("Lỗi á !"),
            });
    ;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    binding();
  }

  void binding() {
    setState(() {
      introductionFB.collectionReference.doc('1').get().then((value) => {
            _NbPhone1Controller.text = value["phoneNumber1"],
            _NbPhone2Controller.text = value["phoneNumber2"],
            _AddressController.text = value["address"],
            _HeadController.text = value["headquarters"],
            _LinkController.text = value["linkPage"],
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: myGreen,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Chỉnh sửa thông tin",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Form(
          key: formKey,
          child: StreamBuilder(
              stream: introductionFB.collectionReference.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Text("No Data"),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                          elevation: 2,
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                _title("TIỀN THUÊ NHÀ"),
                                SizedBox(
                                  height: 20,
                                ),
                                //tiền nhà
                                TitleInfoNotNull(text: "Hotline 1"),
                                _textformField(_NbPhone1Controller,
                                    "0822904906...", "hotline 1"),
                                SizedBox(
                                  height: 20,
                                ),
                                //tiền cọc
                                TitleInfoNotNull(text: "Hotline 2"),
                                _textformField(_NbPhone2Controller,
                                    "0946385229...", "hotline 2"),
                                SizedBox(
                                  height: 20,
                                ),
                                TitleInfoNotNull(text: "Liên kết trang web"),
                                _textformField(
                                    _LinkController,
                                    "https://www.facebook.com....",
                                    "link liên kết"),
                                SizedBox(
                                  height: 20,
                                ),
                                //tiền cọc
                                TitleInfoNotNull(text: "Trụ sở"),
                                _textformField(_HeadController,
                                    "Tòa A18...", "trụ sở"),
                                SizedBox(
                                  height: 20,
                                ),
                                TitleInfoNotNull(text: "Địa chỉ"),
                                _textformField(_AddressController,
                                    "Khu phố 6, Thủ Đức, Tp.HCM..", "địa chỉ"),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          )),
                      SizedBox(
                        height: height * 0.06,
                      ),
                      MainButton(
                        name: 'Xác nhận',
                        onpressed: _onClick,
                      ),
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }

  void _onClick() {
    if (formKey.currentState!.validate()) {
      _editInfo();
    }
  }

  _textformField(TextEditingController controller, String hint, String text) =>
      TextFormField(
        style: MyStyle().style_text_tff(),
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
        ),
        keyboardType: TextInputType.name,
        validator: (val) {
          if (val!.isEmpty) {
            return "Vui lòng nhập " + text;
          }
          return null;
        },
      );
  _title(String text) =>
      Text(text, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold));
}
