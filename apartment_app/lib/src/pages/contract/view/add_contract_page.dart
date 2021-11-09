import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/fire_base/fb_floor_info.dart';
import 'package:apartment_app/src/pages/category_apartment/firebase/fb_category_apartment.dart';
import 'package:apartment_app/src/pages/category_apartment/model/category_apartment_model.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_contract.dart';
import 'package:apartment_app/src/model/task.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_renter.dart';
import 'package:apartment_app/src/pages/contract/view/selectRenter.dart';
import 'package:apartment_app/src/pages/contract/view/selectRoom.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:apartment_app/src/widgets/title/title_info_not_null.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddContractPage extends StatefulWidget {
  // const AddContractPage({Key? key}) : super(key: key);
  late String id;

  AddContractPage({required this.id});

  @override
  _AddContractPageState createState() => _AddContractPageState();
}

class _AddContractPageState extends State<AddContractPage> {
  ContractFB contractFB = new ContractFB();
  RenterFB renterFB = new RenterFB();
  FloorInfoFB floorInfoFB = new FloorInfoFB();
  CategoryApartmentFB categoryApartmentFB = new CategoryApartmentFB();
  CategoryApartment? categoryApartment;
  String? _roomPaymentPeriodController = "1 Tháng";

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
  final TextEditingController _rulesController = TextEditingController();
  final TextEditingController _serviceController = TextEditingController();

  final TextEditingController _nameRenter = TextEditingController();


  final _formKey = GlobalKey<FormState>();
  Task task = new Task();
  DateTime selectedDate = DateTime.now();

  //Chọn ngày
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
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: myGreen,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Thêm hợp đồng",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
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
                        _title("THÔNG TIN"),
                        SizedBox(
                          height: 20,
                        ),
                        //Đại diện cho thuê
                        TitleInfoNotNull(text: "Đại diện cho thuê"),
                        _textformField(_hostController, "Đại diện cho thuê...",
                            "đại diện cho thuê"),
                        SizedBox(
                          height: 20,
                        ),

                        //Chọn phòng
                        TitleInfoNotNull(text: "Chọn phòng"),
                        GestureDetector(
                            onTap: () {
                              _gotoPageRoom();
                            },
                            child: AbsorbPointer(
                                child: _textformField(
                              _roomController,
                              "312_A18...",
                              "Chọn phòng",
                            ))),
                        SizedBox(
                          height: 20,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //Chọn ngày bắt đầu
                            Container(
                              width: width * 0.4,
                              child: Column(
                                children: [
                                  TitleInfoNotNull(text: "Ngày bắt đầu"),
                                  GestureDetector(
                                      onTap: () => _selectDate(
                                          context, _startDayController),
                                      child: AbsorbPointer(
                                        child: _textformFieldwithIcon(
                                            _startDayController,
                                            "20/04/2021...",
                                            "ngày bắt đầu",
                                            height,
                                            Icons.calendar_today_outlined),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //Chọn ngày kết thúc
                            Container(
                              width: width * 0.4,
                              child: Column(
                                children: [
                                  TitleInfoNotNull(text: "Ngày kết thúc"),
                                  GestureDetector(
                                      onTap: () => _selectDate(
                                          context, _expirationDateController),
                                      child: AbsorbPointer(
                                        child: _textformFieldwithIcon(
                                            _expirationDateController,
                                            "20/04/2021...",
                                            "ngày kết thúc",
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
                        //Chọn ngày bắt đầu tính tiền
                        Container(
                          child: Column(
                            children: [
                              TitleInfoNotNull(text: "Ngày bắt đầu tính tiền"),
                              GestureDetector(
                                  onTap: () => _selectDate(
                                      context, _billingStartDateController),
                                  child: AbsorbPointer(
                                    child: _textformFieldwithIcon(
                                        _billingStartDateController,
                                        "20/04/2021...",
                                        "ngày bắt đầu tính tiền",
                                        height,
                                        Icons.calendar_today_outlined),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //Chọn kỳ thanh toán tiền phòng
                        TitleInfoNotNull(text: "Kỳ thanh toán tiền phòng"),
                        Container(
                          child: DropdownButtonFormField<String>(
                            value: _roomPaymentPeriodController,
                            items: [
                              "1 Tháng",
                              "2 Tháng",
                              "3 Tháng",
                              "4 Tháng",
                              "5 Tháng",
                              "6 Tháng",
                              "7 Tháng",
                              "8 Tháng",
                              "9 Tháng",
                              "10 Tháng",
                              "11 Tháng",
                              "12 Tháng"
                            ]
                                .map((label) => DropdownMenuItem(
                                      child: Text(label),
                                      value: label,
                                    ))
                                .toList(),
                            hint: Text('Kỳ thanh toán'),
                            onChanged: (value) {
                              setState(() {
                                _roomPaymentPeriodController = value;
                              });
                            },
                          ),
                        ),
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
                        _title("TIỀN THUÊ NHÀ"),
                        SizedBox(
                          height: 20,
                        ),
                        //tiền nhà
                        TitleInfoNotNull(text: "Tiền nhà"),
                        _textformFieldDisable(
                            _roomChargeController, "100000000...", "tiền nhà"),

                        SizedBox(
                          height: 20,
                        ),
                        //tiền cọc
                        TitleInfoNotNull(text: "Tiền cọc"),
                        _textformField(
                            _depositController, "10000000...", "tiền cọc"),
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
                        _title("NGƯỜI THUÊ"),
                        SizedBox(
                          height: 20,
                        ),
                        //người thuê nhà
                        TitleInfoNotNull(text: "Người thuê nhà"),
                        GestureDetector(
                            onTap: () {
                              _gotoPageRenter();
                            },
                            child: AbsorbPointer(
                                child: _textformField(_nameRenter,
                                    "Lê Hoàng Phúc...", "người thuê nhà"))),

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
                        _title("DỊCH VỤ "),
                        SizedBox(
                          height: 20,
                        ),

                        // dịch vụ
                        TitleInfoNotNull(text: "Dịch vụ"),
                        _textformField(
                            _serviceController, "Giặt ủi...", "dịch vụ"),
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
                        _title("ĐIỂU KHOẢN"),
                        SizedBox(
                          height: 20,
                        ),
                        // dịch vụ
                        TitleInfoNotNull(text: "Điều khoản"),
                        _textformField(_rulesController, "Giảm tiền nhà...",
                            "điều khoản thuê nhà"),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    )),
              ),

              SizedBox(
                height: height * 0.05,
              ),
              //tạo hợp đồng
              Container(
                padding: EdgeInsets.only(right: 20, left: 20),
                child: MainButton(name: "Tạo hợp đồng", onpressed: _onClick),
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
            _roomController.text,
            _startDayController.text,
            _expirationDateController.text,
            _billingStartDateController.text,
            _roomPaymentPeriodController!,
            _roomChargeController.text,
            _depositController.text,
            _renterController.text,
            _rulesController.text,
            true)
        .then((value) => {
              floorInfoFB.updateStatus(_roomController.text, "Đang thuê"),
              _hostController.clear(),
              _roomController.clear(),
              _startDayController.clear(),
              _expirationDateController.clear(),
              _billingStartDateController.clear(),
              _roomChargeController.clear(),
              _depositController.clear(),
              _renterController.clear(),
              _rulesController.clear(),
              Navigator.pop(context),
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
            return "Vui lòng nhập " + text;
          }
          return null;
        },
      );
  _textformFieldDisable(
          TextEditingController controller, String hint, String text) =>
      TextFormField(
        style: MyStyle().style_text_tff(),
        controller: controller,
        readOnly: true,
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
            return "Vui lòng nhập " + text;
          } else {
            return null;
          }
        },
      );
  _title(String text) =>
      Text(text, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold));
  void _gotoPageRoom() async {
    var id = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => SelectRoomContract()));
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
        renterFB.collectionReference
            .doc(id)
            .get()
            .then((value) => {_nameRenter.text = value["name"]});
      });
    }
  }
}
