import 'package:apartment_app/src/pages/contract/firebase/fb_contract.dart';
import 'package:apartment_app/src/model/task.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:apartment_app/src/widgets/title/title_info_not_null.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditContractPage extends StatefulWidget {
  // const EditContractPage({ Key? key }) : super(key: key);
  final String id;
  EditContractPage({required this.id});

  @override
  _EditContractPageState createState() => _EditContractPageState();
}

class _EditContractPageState extends State<EditContractPage> {
  ContractFB contractFB = new ContractFB();

  String? _roomPaymentPeriodController;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    binding();
  }

  void binding() {
    setState(() {
      contractFB.collectionReference.doc(widget.id).get().then((value) => {
            _hostController.text = value["host"],
            _roomController.text = value["room"],
            _startDayController.text = value["startDay"],
            _expirationDateController.text = value["expirationDate"],
            _billingStartDateController.text = value["billingStartDate"],
            _roomPaymentPeriodController = value["roomPaymentPeriod"],
            _roomChargeController.text = value["roomCharge"],
            _depositController.text = value["deposit"],
            _renterController.text = value["renter"],
            _rulesController.text = value["rules"]
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text("Chỉnh sửa hợp đồng"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: height * 0.01,
              ),
              _title("Thông tin", width, height),
              Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      //Đại diện cho thuê
                      TitleInfoNotNull(text: "Đại diện cho thuê"),
                      _textformField(_hostController, "Đại diện cho thuê...",
                          "đại diện cho thuê"),
                      SizedBox(
                        height: 30,
                      ),

                      //Chọn phòng
                      TitleInfoNotNull(text: "Chọn phòng"),
                      _textformField(
                          _roomController, "A18-312...", "chọn phòng"),
                      SizedBox(
                        height: 30,
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
                        height: height * 0.03,
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
                                      "Ngày bắt đầu tính tiền",
                                      height,
                                      Icons.calendar_today_outlined),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      //Chọn kỳ thanh toán tiền phòng
                      TitleInfoNotNull(text: "Kỳ thanh toán tiền phòng"),
                      StreamBuilder(
                          stream: contractFB.collectionReference.where('id',isEqualTo: widget.id).snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: Text("No Data"),
                              );
                            } else {
                              QueryDocumentSnapshot x = snapshot.data!.docs[0];
                              _roomPaymentPeriodController=x["roomPaymentPeriod"];
                              return Container(
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
                              );
                            }
                          }),
                    ],
                  )),
              _title("Tiền thuê nhà", width, height),
              Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      //tiền nhà
                      TitleInfoNotNull(text: "Tiền nhà"),
                      _textformField(
                          _roomChargeController, "100000000...", "tiền nhà"),
                      SizedBox(
                        height: 30,
                      ),
                      //tiền cọc
                      TitleInfoNotNull(text: "Tiền cọc"),
                      _textformField(
                          _depositController, "10000000...", "tiền cọc"),
                    ],
                  )),
              _title("Người thuê", width, height),
              Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      //người thuê nhà
                      TitleInfoNotNull(text: "Người thuê nhà"),
                      _textformField(_renterController, "Lê Hoàng Phúc...",
                          "người thuê nhà"),
                    ],
                  )),
              _title("Dịch vụ", width, height),
              SizedBox(
                height: height * 0.01,
              ),
              _title("Điều khoản", width, height),
              Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      // dịch vụ
                      TitleInfoNotNull(text: "Điều khoản"),
                      _textformField(_rulesController, "Giảm tiền nhà...",
                          "điều khoản thuê nhà"),
                    ],
                  )),
              SizedBox(
                height: height * 0.05,
              ),
              //tạo hợp đồng
              Container(
                padding: EdgeInsets.only(right: 20, left: 20),
                child:
                    MainButton(name: "Chỉnh sửa hợp đồng", onpressed: _onClick),
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
    contractFB
        .update(
            widget.id,
            _hostController.text,
            _roomController.text,
            _startDayController.text,
            _expirationDateController.text,
            _billingStartDateController.text,
            _roomPaymentPeriodController!,
            _roomChargeController.text,
            _depositController.text,
            _renterController.text,
            _rulesController.text)
        .then((value) => {
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
  _title(String text, double width, double height) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                topLeft: Radius.circular(10.0)),
            color: Colors.grey),
        padding: EdgeInsets.only(left: 15),
        alignment: Alignment.centerLeft,
        width: width,
        height: height * 0.05,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
}
