import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/fire_base/fb_floor_info.dart';
import 'package:apartment_app/src/pages/category_apartment/firebase/fb_category_apartment.dart';
import 'package:apartment_app/src/pages/category_apartment/model/category_apartment_model.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_contract.dart';
import 'package:apartment_app/src/model/task.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_rentedRoom.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_renter.dart';

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
  final TextEditingController _rulesAController = TextEditingController();
  final TextEditingController _rulesBController = TextEditingController();
  final TextEditingController _rulesCController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();

  final TextEditingController _nameRenter = TextEditingController();
  final List<Map<String, dynamic>> _items = [
    {
      'value': '0',
      'label': 'Hợp đồng cho thuê',
    },
    {
      'value': '1',
      'label': 'Hợp đồng bán',
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
    _typeController.text='0';
  }

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
      backgroundColor: Colors.white,
      appBar: myAppBar("Thêm hợp đồng"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titletext("Thông tin hợp đồng"),
              SizedBox(height: 10,),
              TitleInfoNotNull(text: "Loại hợp đồng"),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.blueGrey.withOpacity(0.2)
                ),
                child: SelectFormField(
                  decoration: InputDecoration(
                      border: InputBorder.none
                  ),
                  hintText: "Chọn loại hợp đồng",
                  initialValue: _typeController.text,
                  type:
                  SelectFormFieldType.dropdown, // or can be dialog
                  items: _items,
                  onChanged: (val) => _typeController.text = val,
                  onSaved: (val) => _typeController.text = val!,
                ),
              ),
              SizedBox(height: 10,),
              TitleInfoNotNull(text: "Đại diện cho thuê/bán"),
              SizedBox(height: 10,),
              _nameTextFormField(),
              SizedBox(height: 10,),
              TitleInfoNotNull(text: "Chọn phòng"),
              SizedBox(height: 10,),
              GestureDetector(
                  onTap: () {
                    _gotoPageRoom();
                  },
                  child: AbsorbPointer(
                      child: _textformField(
                        _roomController,
                        "Chọn phòng",
                        "Chọn phòng",
                      ))),
              SizedBox(height: 10,),
              TitleInfoNotNull(text: "Ngày bắt đầu"),
              SizedBox(height: 10,),
              GestureDetector(
                  onTap: () => _selectDate(
                      context, _startDayController),
                  child: AbsorbPointer(
                    child: _textformFieldwithIcon(
                        _startDayController,
                        _startDayController.text,
                        "ngày bắt đầu",
                        height,
                        Icons.calendar_today_outlined),
                  )
              ),
              SizedBox(height: 10,),
              TitleInfoNotNull(text: "Ngày kết thúc"),
              SizedBox(height: 10,),
              GestureDetector(
                  onTap: () => _selectDate(
                      context, _expirationDateController),
                  child: AbsorbPointer(
                    child: _textformFieldwithIcon(
                        _expirationDateController,
                        "Chọn ngày",
                        "ngày kết thúc",
                        height,
                        Icons.calendar_today_outlined),
                  )
              ),
              SizedBox(height: 10,),
              TitleInfoNotNull(text: "Ngày bắt đầu tính tiền"),
              SizedBox(height: 10,),
              GestureDetector(
                  onTap: () => _selectDate(
                      context, _billingStartDateController),
                  child: AbsorbPointer(
                    child: _textformFieldwithIcon(
                        _billingStartDateController,
                        "Chọn ngày bắt đầu tính tiền",
                        "ngày bắt đầu tính tiền",
                        height,
                        Icons.calendar_today_outlined),
                  )
              ),
              SizedBox(height: 10,),
              TitleInfoNotNull(text: "Kỳ thanh toán tiền phòng"),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.blueGrey.withOpacity(0.2)
                ),
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
                  decoration: InputDecoration(
                      border: InputBorder.none
                  ),
                  hint: Text('Kỳ thanh toán'),
                  onChanged: (value) {
                    setState(() {
                      _roomPaymentPeriodController = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 30,),
              _titletext("Tiền thuê, mua nhà"),
              SizedBox(height: 10,),
              TitleInfoNotNull(text: "Tiền nhà"),
              SizedBox(height: 10,),
              _textformFieldDisable(
                  _roomChargeController, "Nhập tiền nhà", "tiền nhà"),
              SizedBox(height: 10,),
              TitleInfoNotNull(text: "Tiền cọc"),
              SizedBox(height: 10,),
              _textformField(
                  _depositController, "Nhập tiền cọc", "tiền cọc"),
              SizedBox(height: 30,),
              _titletext("Người thuê/mua"),
              SizedBox(height: 10,),
              TitleInfoNotNull(text: "Người thuê/mua nhà"),
              SizedBox(height: 10,),
              GestureDetector(
                  onTap: () {
                    _gotoPageRenter();
                  },
                  child: AbsorbPointer(
                      child: _textformField(_nameRenter,
                          "Chọn người thuê nhà", "người thuê nhà")
                  )
              ),
              SizedBox(height: 30,),
              _titletext("Điều khoản"),
              SizedBox(height: 10,),
              TitleInfoNull(text: "Điều khoản bên A(Người cho thuê/bán)"),
              SizedBox(height: 10,),
              _noteA(),
              SizedBox(height: 10,),
              TitleInfoNull(text: "Điều khoản bên B(Người thuê/mua)"),
              SizedBox(height: 10,),
              _noteB(),
              SizedBox(height: 10,),
              TitleInfoNull(text: "Điều khoản chung"),
              SizedBox(height: 10,),
              _note(),
              SizedBox(height: 30,),

              //tạo hợp đồng
              Container(
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
          _rulesAController.text,
          _rulesBController.text,
          _rulesCController.text,
          _typeController.text,
          false,
          true,
        )
        .then((value) => {
              _typeController.text == '0'
                  ? floorInfoFB.updateStatus(_roomController.text, "Đang thuê")
                  : floorInfoFB.updateStatus(_roomController.text, "Đã bán"),
              rentedRoomFB.add(
                  _renterController.text, _roomController.text, false),
              renterFB.updateIdApartment(
                  _renterController.text, _roomController.text),
              renterFB.collectionReference
                  .doc(_renterController.text)
                  .get()
                  .then((value) => {
                        dwellersFB.add(
                            value['idApartment'],
                            value['name'],
                            value['birthday'],
                            value['gender'],
                            value['cmnd'],
                            value['homeTown'],
                            value['job'],
                            value['role'],
                            value['role'],
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
          decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none
          ),
          keyboardType: TextInputType.name,
          validator: (val) {
            if (val!.isEmpty) {
              return "Vui lòng nhập " + text;
            }
            return null;
          },
        ),
      );
  _nameTextFormField() => Container(
    padding: MyStyle().padding_container_tff(),
    decoration: MyStyle().style_decoration_container(),
    child: TextFormField(
      controller: _nameRenter,
      decoration: MyStyle().style_decoration_tff("Đại diện cho thuê/bán"),
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
              return "Vui lòng nhập " + text;
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
              return "Vui lòng nhập " + text;
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
        context, MaterialPageRoute(builder: (context) => SelectRoomContract(status: 'Trống',)));
    if (id != null) {
      setState(() {
        _roomController.text = id;
        floorInfoFB.collectionReference.doc(id).get().then((value) => {
              categoryApartmentFB.collectionReference
                  .doc(value["categoryid"])
                  .get()
                  .then((data) =>
                      {_roomChargeController.text = data["rentalPrice"]})
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
              border: InputBorder.none,
              hintText: "Điều khoản chung"
          ),
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400
          ),
        ),
        SizedBox(height: 10,),
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
              border: InputBorder.none,
              hintText: "Điều khoản bên A"
          ),
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400
          ),
        ),
        SizedBox(height: 10,),
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
              border: InputBorder.none,
              hintText: "Điều khoản bên B"
          ),
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400
          ),
        ),
        SizedBox(height: 10,),
      ],
    ),
  );
  _titletext(String text) => Text(
    text,
    style: TextStyle(
        color: Colors.black.withOpacity(0.5),
        fontWeight: FontWeight.bold
    ),
  );
}
