import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/fire_base/fb_floor_info.dart';
import 'package:apartment_app/src/pages/category_apartment/firebase/fb_category_apartment.dart';
import 'package:apartment_app/src/pages/category_apartment/model/category_apartment_model.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_contract.dart';
import 'package:apartment_app/src/model/task.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_owner.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_rentedRoom.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_renter.dart';
import 'package:apartment_app/src/pages/contract/view/selectOnwer.dart';

import 'package:apartment_app/src/pages/contract/view/selectRenter.dart';
import 'package:apartment_app/src/pages/contract/view/selectRoom.dart';
import 'package:apartment_app/src/pages/dweller/firebase/fb_dweller.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/appbars/my_app_bar.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:apartment_app/src/widgets/title/title_info_not_null.dart';
import 'package:apartment_app/src/widgets/title/title_info_null.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:select_form_field/select_form_field.dart';

class AddContractPage extends StatefulWidget {
  // const AddContractPage({Key? key}) : super(key: key);
  late String id;

  AddContractPage({required this.id});

  @override
  _AddContractPageState createState() => _AddContractPageState();
}

class _AddContractPageState extends State<AddContractPage> {
  DwellersFB dwellersFB = new DwellersFB();

  ContractFB contractFB = new ContractFB();

  RentedRoomFB rentedRoomFB = new RentedRoomFB();

  RenterFB renterFB = new RenterFB();

  OwnerFB ownerFB = new OwnerFB();

  FloorInfoFB floorInfoFB = new FloorInfoFB();
  CategoryApartmentFB categoryApartmentFB = new CategoryApartmentFB();
  CategoryApartment? categoryApartment;
  String? _roomPaymentPeriodController = "1 Th??ng";

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _hostController = TextEditingController();
  final TextEditingController _roomController = TextEditingController();
  final TextEditingController _startDayController = TextEditingController();
  final TextEditingController _expirationDateController =
      TextEditingController();
  final TextEditingController _billingStartDateController =
      TextEditingController();
  final TextEditingController _roomChargeController = TextEditingController();
  final TextEditingController _depositController = TextEditingController();
  final TextEditingController _renterController = TextEditingController();
  final TextEditingController _rulesAController = TextEditingController();
  final TextEditingController _rulesBController = TextEditingController();
  final TextEditingController _rulesCController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();

  final TextEditingController _nameRenter = TextEditingController();
  final TextEditingController _nameOwner = TextEditingController();
  final List<Map<String, dynamic>> _items = [
    {
      'value': '0',
      'label': 'H???p ?????ng cho thu??',
    },
    {
      'value': '1',
      'label': 'H???p ?????ng b??n',
    },
  ];

  final _formKey = GlobalKey<FormState>();
  Task task = new Task();
  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var date =
        "${DateTime.now().toLocal().day}/${DateTime.now().toLocal().month}/${DateTime.now().toLocal().year}";
    _startDayController.text = date;
    _typeController.text = '0';
  }

  //Ch???n ng??y
  _selectDate(
      BuildContext context, TextEditingController _startDayController) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2019, 8),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        var date =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        _startDayController.text = date;
        selectedDate = DateTime.now();
      });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar("Th??m h???p ?????ng"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titletext("Th??ng tin h???p ?????ng"),
              SizedBox(
                height: 10,
              ),
              TitleInfoNotNull(text: "Lo???i h???p ?????ng"),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.blueGrey.withOpacity(0.2)),
                child: SelectFormField(
                  decoration: InputDecoration(border: InputBorder.none),
                  hintText: "Ch???n lo???i h???p ?????ng",
                  initialValue: _typeController.text,
                  type: SelectFormFieldType.dropdown, // or can be dialog
                  items: _items,
                  onChanged: (val) {
                    _typeController.text = val;
                    if (_roomController.text.isNotEmpty) {
                      floorInfoFB.collectionReference
                          .doc(_roomController.text)
                          .get()
                          .then((value) => {
                                categoryApartmentFB.collectionReference
                                    .doc(value["categoryid"])
                                    .get()
                                    .then((data) => {
                                          if (_typeController.text == '0')
                                            _roomChargeController.text =
                                                data["rentalPrice"]
                                          else
                                            {
                                              _roomChargeController.text =
                                                  data["price"]
                                            }
                                        })
                              });
                    }
                  },
                  onSaved: (val) => _typeController.text = val!,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TitleInfoNotNull(text: "?????i di???n cho thu??/b??n"),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                  onTap: () {
                    _gotoPageOwner();
                  },
                  child: AbsorbPointer(
                      child: _textformField(
                          _nameOwner,
                          "Ch???n ?????i di???n cho thu??/b??n nh??",
                          "?????i di???n cho thu??/b??n nh??"))),
              SizedBox(
                height: 10,
              ),
              TitleInfoNotNull(text: "Ch???n ph??ng"),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                  onTap: () {
                    _gotoPageRoom();
                  },
                  child: AbsorbPointer(
                      child: _textformField(
                    _roomController,
                    "Ch???n ph??ng",
                    "Ch???n ph??ng",
                  ))),
              SizedBox(
                height: 10,
              ),
              TitleInfoNotNull(text: "Ng??y b???t ?????u"),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                  onTap: () => _selectDate(context, _startDayController),
                  child: AbsorbPointer(
                    child: _textformFieldwithIcon(
                        _startDayController,
                        _startDayController.text,
                        "ng??y b???t ?????u",
                        height,
                        Icons.calendar_today_outlined),
                  )),

              SizedBox(
                height: 30,
              ),
              _titletext("Ti???n thu??, mua nh??"),
              SizedBox(
                height: 10,
              ),
              TitleInfoNotNull(text: "Ti???n nh??"),
              SizedBox(
                height: 10,
              ),
              _textformFieldDisable(
                  _roomChargeController, "Nh???p ti???n nh??", "ti???n nh??"),
              SizedBox(
                height: 10,
              ),
              TitleInfoNotNull(text: "Ti???n c???c"),
              SizedBox(
                height: 10,
              ),
              _textformField(_depositController, "Nh???p ti???n c???c", "ti???n c???c"),
              SizedBox(
                height: 30,
              ),
              _titletext("Ng?????i thu??/mua"),
              SizedBox(
                height: 10,
              ),
              TitleInfoNotNull(text: "Ng?????i thu??/mua nh??"),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                  onTap: () {
                    _gotoPageRenter();
                  },
                  child: AbsorbPointer(
                      child: _textformField(_nameRenter, "Ch???n ng?????i thu?? nh??",
                          "ng?????i thu?? nh??"))),
              SizedBox(
                height: 30,
              ),
              _titletext("??i???u kho???n"),
              SizedBox(
                height: 10,
              ),
              TitleInfoNull(text: "??i???u kho???n b??n A(Ng?????i cho thu??/b??n)"),
              SizedBox(
                height: 10,
              ),
              _noteA(),
              SizedBox(
                height: 10,
              ),
              TitleInfoNull(text: "??i???u kho???n b??n B(Ng?????i thu??/mua)"),
              SizedBox(
                height: 10,
              ),
              _noteB(),
              SizedBox(
                height: 10,
              ),
              TitleInfoNull(text: "??i???u kho???n chung"),
              SizedBox(
                height: 10,
              ),
              _note(),
              SizedBox(
                height: 30,
              ),

              //t???o h???p ?????ng
              Container(
                child: MainButton(name: "T???o h???p ?????ng", onpressed: _onClick),
              ),
              SizedBox(
                height: height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onClick() {
    if (_formKey.currentState!.validate()) {
      _addContract();
    }
  }

  void _addContract() {
    contractFB
        .add(
          _hostController.text,
          _nameOwner.text,
          _roomController.text,
          _startDayController.text,
          _expirationDateController.text,
          _billingStartDateController.text,
          _roomPaymentPeriodController!,
          _roomChargeController.text,
          _depositController.text,
          _renterController.text,
          _nameRenter.text,
          _rulesAController.text,
          _rulesBController.text,
          _rulesCController.text,
          _typeController.text,
          false,
          true,
        )
        .then((value) => {
              _typeController.text == '0'
                  ? floorInfoFB.updateStatus(_roomController.text, "??ang thu??")
                  : floorInfoFB.updateStatus(_roomController.text, "???? b??n"),
              rentedRoomFB.add(
                  _renterController.text, _roomController.text, false),
              renterFB.updateIdApartment(
                  _renterController.text, _roomController.text),
              print(_renterController.text),
              renterFB.collectionReference
                  .doc(_renterController.text)
                  .get()
                  .then((value) => {
                      
                        dwellersFB.add(
                            value['id'],
                            value['idApartment'],
                            value['name'],
                            value['birthday'],
                            value['gender'],
                            value['cmnd'],
                            value['homeTown'],
                            value['job'],
                            value['phoneNumber'],
                            value['email'],
                            ""),
                      }),
              floorInfoFB.updateDweller(_roomController.text, '1'),
              _hostController.clear(),
              _roomController.clear(),
              _startDayController.clear(),
              _expirationDateController.clear(),
              _billingStartDateController.clear(),
              _roomChargeController.clear(),
              _depositController.clear(),
              _renterController.clear(),
              _rulesAController.clear(),
              _rulesBController.clear(),
              _rulesCController.clear(),
              Navigator.pop(context),
            });
  }

  _textformField(TextEditingController controller, String hint, String text) =>
      Container(
        padding: MyStyle().padding_container_tff(),
        decoration: MyStyle().style_decoration_container(),
        child: TextFormField(
          style: MyStyle().style_text_tff(),
          controller: controller,
          decoration: InputDecoration(hintText: hint, border: InputBorder.none),
          keyboardType: TextInputType.name,
          validator: (val) {
            if (val!.isEmpty) {
              return "Vui l??ng nh???p " + text;
            }
            return null;
          },
        ),
      );
  _nameTextFormField() => Container(
        padding: MyStyle().padding_container_tff(),
        decoration: MyStyle().style_decoration_container(),
        child: TextFormField(
          controller: _hostController,
          decoration: MyStyle().style_decoration_tff("?????i di???n cho thu??/b??n"),
          style: MyStyle().style_text_tff(),
        ),
      );
  _textformFieldDisable(
          TextEditingController controller, String hint, String text) =>
      Container(
        padding: MyStyle().padding_container_tff(),
        decoration: MyStyle().style_decoration_container(),
        child: TextFormField(
          style: MyStyle().style_text_tff(),
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
          ),
          keyboardType: TextInputType.name,
          validator: (val) {
            if (val!.isEmpty) {
              return "Vui l??ng nh???p " + text;
            }
            return null;
          },
        ),
      );
  _textformFieldwithIcon(TextEditingController controller, String hint,
          String text, double height, IconData icon) =>
      Container(
        padding: MyStyle().padding_container_tff(),
        decoration: MyStyle().style_decoration_container(),
        child: TextFormField(
          style: MyStyle().style_text_tff(),
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
            suffixIcon: Padding(
              padding: EdgeInsetsDirectional.all(0),
              child: Icon(icon),
            ),
          ),
          keyboardType: TextInputType.datetime,
          validator: (value) {
            if (value!.isEmpty) {
              return "Vui l??ng nh???p " + text;
            } else {
              return null;
            }
          },
        ),
      );
  _title(String text) =>
      Text(text, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold));
  void _gotoPageRoom() async {
    var id = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SelectRoomContract(
                  status: 'Tr???ng',
                )));
    if (id != null) {
      setState(() {
        _roomController.text = id;
        floorInfoFB.collectionReference.doc(id).get().then((value) => {
              categoryApartmentFB.collectionReference
                  .doc(value["categoryid"])
                  .get()
                  .then((data) => {
                        if (_typeController.text == '0')
                          _roomChargeController.text = data["rentalPrice"]
                        else
                          {_roomChargeController.text = data["price"]}
                      })
            });
      });
    }
  }

  void _gotoPageRenter() async {
    var id = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => SelectRenterContract()));
    if (id != null) {
      setState(() {
        _renterController.text = id;
        renterFB.collectionReference
            .doc(id)
            .get()
            .then((value) => {_nameRenter.text = value["name"]});
      });
    }
  }

  void _gotoPageOwner() async {
    var id = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => SelectOwner()));
    if (id != null) {
      setState(() {
        _hostController.text = id;
        ownerFB.collectionReference
            .doc(id)
            .get()
            .then((value) => {_nameOwner.text = value["name"]});
      });
    }
  }

  _ruleField(TextEditingController controller, String hint) {
    return TextFormField(
      minLines: 2,
      maxLines: 5,
      controller: controller,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
            fontWeight: FontWeight.w400, fontSize: 16, color: Colors.grey),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }

  _note() => Container(
        width: double.infinity,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blueGrey.withOpacity(0.2),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _rulesCController,
              maxLines: 10,
              minLines: 3,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "??i???u kho???n chung"),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      );
  _noteA() => Container(
        width: double.infinity,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blueGrey.withOpacity(0.2),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _rulesAController,
              maxLines: 10,
              minLines: 3,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "??i???u kho???n b??n A"),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      );
  _noteB() => Container(
        width: double.infinity,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blueGrey.withOpacity(0.2),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _rulesBController,
              maxLines: 10,
              minLines: 3,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "??i???u kho???n b??n B"),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      );
  _titletext(String text) => Text(
        text,
        style: TextStyle(
            color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.bold),
      );
}
