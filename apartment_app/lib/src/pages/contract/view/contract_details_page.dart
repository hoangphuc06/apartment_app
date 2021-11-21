import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/Bill/firebase/fb_billinfo.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_contract.dart';
import 'package:apartment_app/src/pages/contract/model/contract_model.dart';
import 'package:apartment_app/src/pages/contract/view/liquidation_contract_page.dart';
import 'package:apartment_app/src/pages/contract/view/edit_contract_page.dart';
import 'package:apartment_app/src/widgets/buttons/roundedButton.dart';
import 'package:apartment_app/src/widgets/title/title_info_null.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ContractDetails extends StatefulWidget {
  // const ContractDetails({ Key? key }) : super(key: key);
  final String id;
  final String flag;
  final String idRoom;
  ContractDetails({required this.id, required this.idRoom, required this.flag});

  @override
  _ContractDetailsState createState() => _ContractDetailsState();
}

class _ContractDetailsState extends State<ContractDetails> {
  ContractFB contractFB = new ContractFB();
  BillInfoFB billInfoFB = new BillInfoFB();
  final TextEditingController _rulesAController = TextEditingController();
  final TextEditingController _rulesBController = TextEditingController();
  final TextEditingController _rulesCController = TextEditingController();
  final TextEditingController _check = TextEditingController();
  final TextEditingController _idBill = TextEditingController();
  @override
  void initState() {
    print(widget.idRoom);
    _check.text = '0';
    _idBill.text = 's';
    var now = DateTime.now();
    billInfoFB.collectionReference
        .where('idRoom', isEqualTo: this.widget.idRoom)
        .where('monthBill', isEqualTo: (now.toLocal().month).toString())
        .where('yearBill', isEqualTo: now.toLocal().year.toString())
        .get()
        .then((value) => {
              print(value.docs.length),
              if (value.docs.length != 0)
                {
                  _check.text = '1',
                  _idBill.text = value.docs[0]['idBillInfo'],
                }
            });
    super.initState();
    binding();
  }

  void binding() {
    setState(() {
      contractFB.collectionReference.doc(this.widget.id).get().then((value) => {
            _rulesAController.text = value["rulesA"],
            _rulesBController.text = value["rulesB"],
            _rulesCController.text = value["rulesC"]
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: myGreen, //change your color here
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.find_in_page_outlined,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.share),
            ),
          ],
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            "Hợp đồng",
            style: TextStyle(
              color: myGreen,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: StreamBuilder(
              stream: contractFB.collectionReference
                  .where('id', isEqualTo: this.widget.id)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Text("No Data"),
                  );
                } else {
                  QueryDocumentSnapshot x = snapshot.data!.docs[0];
                  Contract contract = Contract.fromDocument(x);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //thông tin hợp đồng
                      _title("Hợp đồng"),
                      SizedBox(
                        height: 10,
                      ),
                      _detail("Số hợp đồng", x["id"]),
                      SizedBox(
                        height: 10,
                      ),
                      _detail("Phòng", x["room"]),
                      SizedBox(
                        height: 10,
                      ),
                      _detail("Ngày bắt đầu", x["startDay"]),
                      SizedBox(
                        height: 10,
                      ),
                      // _detail("Đến ngày", x["expirationDate"]),
                      // SizedBox(height: 10,),
                      _detail("Người cho thuê", x["host"]),
                      SizedBox(
                        height: 10,
                      ),
                      _detail("Tiền phòng", x["roomCharge"]),
                      SizedBox(
                        height: 10,
                      ),
                      _detail("Tiền cọc", x["deposit"]),
                      SizedBox(
                        height: 10,
                      ),
                      // _detail("Kỳ thanh toán", x["roomPaymentPeriod"]),
                      // SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Container(
                          //   padding:
                          //   EdgeInsets.only(right: 8,),
                          //   child: RoundedButton(
                          //       name: 'Chỉnh sửa',
                          //       onpressed: () => {
                          //         Navigator.push(
                          //             context,
                          //             MaterialPageRoute(
                          //                 builder: (context) =>
                          //                     EditContractPage(
                          //                         contract:
                          //                         contract)))
                          //       },
                          //       color: myYellow),
                          // ),
                          Container(
                            padding: EdgeInsets.only(right: 8),
                            child: RoundedButton(
                                name: 'Xóa',
                                onpressed: () => {_onClick()},
                                color: myRed),
                          ),
                          widget.flag == '0'
                              ? Container(
                                  child: RoundedButton(
                                      name: 'Thanh lý',
                                      onpressed: () => {
                                            print(_check.text),
                                            print(_idBill.text),
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LiquidationContractPage(
                                                            idBill:
                                                                _idBill.text,
                                                            flag: _check.text,
                                                            id: widget.id)))
                                          },
                                      color: myGreen),
                                )
                              : Container(),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      _title("Điều khoản"),
                      SizedBox(
                        height: 10,
                      ),
                      TitleInfoNull(text: "Điều khoản bên A"),
                      SizedBox(
                        height: 10,
                      ),
                      _note(_rulesAController),
                      SizedBox(
                        height: 10,
                      ),
                      TitleInfoNull(text: "Điều khoản bên B"),
                      SizedBox(
                        height: 10,
                      ),
                      _note(_rulesBController),
                      SizedBox(
                        height: 10,
                      ),
                      TitleInfoNull(text: "Điều khoản chung"),
                      SizedBox(
                        height: 10,
                      ),
                      _note(_rulesCController),
                    ],
                  );
                }
              }),
        ));
  }

  void _onClick() {
    contractFB
        .delete(
          widget.id,
        )
        .then((value) => {
              Navigator.pop(context),
            });
  }

  _items(String text, TextEditingController controller, String init) {
    controller.text = init;
    return Column(
      children: [
        TitleInfoNull(text: text),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          minLines: 2,
          maxLines: 7,
          enabled: false,
          controller: controller,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.black, width: 1, style: BorderStyle.solid),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }

  _title(String text) => Text(
        text,
        style: TextStyle(
            color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.bold),
      );

  _detail(String name, String detail) => Container(
        padding: EdgeInsets.all(8),
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.blueGrey.withOpacity(0.2)),
        child: Row(
          children: [
            Text(
              name,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Text(
              detail,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );

  _note(TextEditingController controller) => Container(
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
              controller: controller,
              maxLines: 10,
              minLines: 3,
              decoration: InputDecoration(
                  enabled: false,
                  border: InputBorder.none,
                  hintText: "[Trống]"),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      );
}
