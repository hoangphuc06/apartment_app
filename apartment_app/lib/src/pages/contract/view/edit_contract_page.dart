import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/fire_base/fb_floor_info.dart';
import 'package:apartment_app/src/pages/category_apartment/firebase/fb_category_apartment.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_contract.dart';
import 'package:apartment_app/src/model/task.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_rentedRoom.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_renter.dart';

import 'package:apartment_app/src/pages/contract/model/contract_model.dart';
import 'package:apartment_app/src/pages/contract/view/selectRenter.dart';
import 'package:apartment_app/src/pages/contract/view/selectRoom.dart';
import 'package:apartment_app/src/pages/dweller/firebase/fb_dweller.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:apartment_app/src/widgets/title/title_info_not_null.dart';
import 'package:apartment_app/src/widgets/title/title_info_null.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditContractPage extends StatefulWidget {
  // const EditContractPage({ Key? key }) : super(key: key);
  final Contract contract;
  EditContractPage({required this.contract});

  @override
  _EditContractPageState createState() => _EditContractPageState();
}

class _EditContractPageState extends State<EditContractPage> {
  ContractFB contractFB = new ContractFB();
  RentedRoomFB rentedRoomFB = new RentedRoomFB();
  RenterFB renterFB = new RenterFB();
  DwellersFB dwellersFB = new DwellersFB();
  FloorInfoFB floorInfoFB = new FloorInfoFB();
  CategoryApartmentFB categoryApartmentFB = new CategoryApartmentFB();
  String? _roomPaymentPeriodController;
  int numDweller=0;
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
  final TextEditingController _serviceController = TextEditingController();

  final TextEditingController _nameRenter = TextEditingController();

  final TextEditingController _temp = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  Task task = new Task();
  DateTime selectedDate = DateTime.now();

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

  Future<void> getNumdweller() async {
    DwellersFB dwellersFB = new DwellersFB();
    Stream<QuerySnapshot> query = dwellersFB.collectionReference
        .where('idApartment', isEqualTo: _roomController)
        .snapshots();
    await query.forEach((x) {
      x.docs.asMap().forEach((key, value) {
        setState(() {
          numDweller++;
        });
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    binding();
  }

  void binding() {
    setState(() {
      _hostController.text = this.widget.contract.host.toString();
      _roomController.text = this.widget.contract.room.toString();
      _startDayController.text = this.widget.contract.startDay.toString();
      _expirationDateController.text =
          this.widget.contract.expirationDate.toString();
      _billingStartDateController.text =
          this.widget.contract.billingStartDate.toString();
      _roomPaymentPeriodController =
          this.widget.contract.roomPaymentPeriod.toString();
      _roomChargeController.text = this.widget.contract.roomCharge.toString();
      _depositController.text = this.widget.contract.deposit.toString();
      _renterController.text = this.widget.contract.renter.toString();
      _rulesAController.text = this.widget.contract.rulesA.toString();
      _rulesBController.text = this.widget.contract.rulesB.toString();
      _rulesCController.text = this.widget.contract.rulesC.toString();
      renterFB.collectionReference
          .doc(_renterController.text)
          .get()
          .then((value) => {_nameRenter.text = value["name"]});
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: myGreen,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Ch???nh s???a h???p ?????ng",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
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
                        _title("TH??NG TIN"),
                        SizedBox(
                          height: 20,
                        ),
                        //?????i di???n cho thu??
                        TitleInfoNotNull(text: "?????i di???n cho thu??"),
                        _textformField(_hostController, "?????i di???n cho thu??...",
                            "?????i di???n cho thu??"),
                        SizedBox(
                          height: 20,
                        ),

                        //Ch???n ph??ng
                        TitleInfoNotNull(text: "Ch???n ph??ng"),
                        GestureDetector(
                            onTap: () {
                              _gotoPageRoom();
                            },
                            child: AbsorbPointer(
                                child: _textformField(
                              _roomController,
                              "312_A18...",
                              "Ch???n ph??ng",
                            ))),
                        SizedBox(
                          height: 20,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //Ch???n ng??y b???t ?????u
                            Container(
                              width: width * 0.4,
                              child: Column(
                                children: [
                                  TitleInfoNotNull(text: "Ng??y b???t ?????u"),
                                  GestureDetector(
                                      onTap: () => _selectDate(
                                          context, _startDayController),
                                      child: AbsorbPointer(
                                        child: _textformFieldwithIcon(
                                            _startDayController,
                                            "20/04/2021...",
                                            "ng??y b???t ?????u",
                                            height,
                                            Icons.calendar_today_outlined),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //Ch???n ng??y k???t th??c
                            Container(
                              width: width * 0.4,
                              child: Column(
                                children: [
                                  TitleInfoNotNull(text: "Ng??y k???t th??c"),
                                  GestureDetector(
                                      onTap: () => _selectDate(
                                          context, _expirationDateController),
                                      child: AbsorbPointer(
                                        child: _textformFieldwithIcon(
                                            _expirationDateController,
                                            "20/04/2021...",
                                            "ng??y k???t th??c",
                                            height,
                                            Icons.calendar_today_outlined),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //Ch???n ng??y b???t ?????u t??nh ti???n
                        Container(
                          child: Column(
                            children: [
                              TitleInfoNotNull(text: "Ng??y b???t ?????u t??nh ti???n"),
                              GestureDetector(
                                  onTap: () => _selectDate(
                                      context, _billingStartDateController),
                                  child: AbsorbPointer(
                                    child: _textformFieldwithIcon(
                                        _billingStartDateController,
                                        "20/04/2021...",
                                        "Ng??y b???t ?????u t??nh ti???n",
                                        height,
                                        Icons.calendar_today_outlined),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //Ch???n k??? thanh to??n ti???n ph??ng
                        TitleInfoNotNull(text: "K??? thanh to??n ti???n ph??ng"),
                        Container(
                          child: DropdownButtonFormField<String>(
                            value: _roomPaymentPeriodController,
                            items: [
                              "1 Th??ng",
                              "2 Th??ng",
                              "3 Th??ng",
                              "4 Th??ng",
                              "5 Th??ng",
                              "6 Th??ng",
                              "7 Th??ng",
                              "8 Th??ng",
                              "9 Th??ng",
                              "10 Th??ng",
                              "11 Th??ng",
                              "12 Th??ng"
                            ]
                                .map((label) => DropdownMenuItem(
                                      child: Text(label),
                                      value: label,
                                    ))
                                .toList(),
                            hint: Text('K??? thanh to??n'),
                            onChanged: (value) {
                              setState(() {
                                _roomPaymentPeriodController = value;
                              });
                            },
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        )
                      ],
                    )),
              ),

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
                        _title("TI???N THU?? NH??"),
                        SizedBox(
                          height: 20,
                        ),

                        //ti???n nh??
                        TitleInfoNotNull(text: "Ti???n nh??"),
                        _textformField(
                            _roomChargeController, "100000000...", "ti???n nh??"),
                        SizedBox(
                          height: 20,
                        ),
                        //ti???n c???c
                        TitleInfoNotNull(text: "Ti???n c???c"),
                        _textformField(
                            _depositController, "10000000...", "ti???n c???c"),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    )),
              ),

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
                        _title("NG?????I THU??"),
                        SizedBox(
                          height: 20,
                        ),

                        //ng?????i thu?? nh??
                        TitleInfoNotNull(text: "Ng?????i thu?? nh??"),
                        GestureDetector(
                            onTap: () {},
                            child: AbsorbPointer(
                                child: _textformField(_nameRenter,
                                    "L?? Ho??ng Ph??c...", "ng?????i thu?? nh??"))),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    )),
              ),

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
                        _title("??I???U KHO???N"),
                        SizedBox(
                          height: 20,
                        ),
                        // d???ch v???
                        TitleInfoNull(
                            text: "??i???u kho???n b??n A(Ng?????i cho thu??/b??n)"),
                        SizedBox(
                          height: 10,
                        ),
                        _ruleField(_rulesAController, "??i???u kho???n b??n A"),

                        SizedBox(
                          height: 20,
                        ),
                        TitleInfoNull(
                            text: "??i???u kho???n b??n B(Ng?????i thu??/mua)"),
                        SizedBox(
                          height: 10,
                        ),
                        _ruleField(_rulesBController, "??i???u kho???n b??n B"),
                        SizedBox(
                          height: 20,
                        ),
                        TitleInfoNull(text: "??i???u kho???n chung"),
                        SizedBox(
                          height: 10,
                        ),
                        _ruleField(_rulesCController, "??i???u kho???n chung"),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    )),
              ),

              SizedBox(
                height: height * 0.05,
              ),
              //ch???nh s???a h???p ?????ng
              Container(
                padding: EdgeInsets.only(right: 20, left: 20),
                child:
                    MainButton(name: "Ch???nh s???a h???p ?????ng", onpressed: _onClick),
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
    if (_formKey.currentState!.validate()) _updateContract();
  }

  void _updateContract() {
    if (_roomController.text != this.widget.contract.room) {
      floorInfoFB.updateStatus(this.widget.contract.room!, "Tr???ng");
      floorInfoFB.updateStatus(_roomController.text, "??ang thu??");
      _upDateDweler(this.widget.contract.room!, _roomController.text);
      getNumdweller();
      floorInfoFB.updateDweller(this.widget.contract.room!, '0');
      floorInfoFB.updateDweller(_roomController.text, numDweller.toString());
      _upDateRoom(this.widget.contract.room!, _roomController.text);
    }
    if (_renterController.text != this.widget.contract.renter) {
      _upDateRenter(this.widget.contract.renter!, _renterController.text);
    }

    contractFB
        .update(
            widget.contract.id!,
            _hostController.text,
            _roomController.text,
            _startDayController.text,
            _expirationDateController.text,
            _billingStartDateController.text,
            _roomPaymentPeriodController!,
            _roomChargeController.text,
            _depositController.text,
            _renterController.text,
            _rulesAController.text,
            _rulesBController.text,
            _rulesCController.text)
        .then((value) => {
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

  void _upDateDweler(String idBefore, String idAfter) async {
    var result = await dwellersFB.collectionReference
        .where("idApartment", isEqualTo: idBefore)
        .get();
    result.docs.forEach((res) {
      dwellersFB.updateIdApartment(res.id, idAfter);
    });
  }

  void _upDateRenter(String idBefore, String idAfter) async {
    var result = await rentedRoomFB.collectionReference
        .where("idRenter", isEqualTo: idBefore)
        .get();
    result.docs.forEach((res) {
      rentedRoomFB.updateIdRenter(res.id, idAfter);
    });
  }

  void _upDateRoom(String idBefore, String idAfter) async {
    var result = await rentedRoomFB.collectionReference
        .where("idRoom", isEqualTo: idBefore)
        .get();
    result.docs.forEach((res) {
      rentedRoomFB.updateIdRoom(res.id, idAfter);
    });
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
            return "Vui l??ng nh???p " + text;
          }
          return null;
        },
      );
  _textformFieldwithIcon(TextEditingController controller, String hint,
          String text, double height, IconData icon) =>
      TextFormField(
        style: MyStyle().style_text_tff(),
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
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
      );
  _title(String text) => Text(
        text,
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      );
  void _gotoPageRoom() async {
    var id = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => SelectRoomContract(status: 'Tr???ng',)));
    if (id != null) {
      setState(() {
        _roomController.text = id;
        floorInfoFB.collectionReference.doc(id).get().then((value) => {
              categoryApartmentFB.collectionReference
                  .doc(value["categoryid"])
                  .get()
                  .then(
                      (data) => {_roomChargeController.text = data["minPrice"]})
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
        dwellersFB.collectionReference
            .doc(id)
            .get()
            .then((value) => {_nameRenter.text = value["name"]});
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
}
