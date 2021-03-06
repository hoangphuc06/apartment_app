import 'package:apartment_app/src/PDF/pdf_api.dart';
import 'package:apartment_app/src/PDF/pdf_form_contract.dart';
import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/fire_base/fb_floor_info.dart';
import 'package:apartment_app/src/pages/Bill/firebase/fb_billinfo.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_contract.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_owner.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_rentedRoom.dart';
import 'package:apartment_app/src/pages/contract/firebase/fb_renter.dart';
import 'package:apartment_app/src/pages/contract/model/contractPdf_model.dart';
import 'package:apartment_app/src/pages/contract/model/contract_model.dart';
import 'package:apartment_app/src/pages/contract/model/owner_model.dart';
import 'package:apartment_app/src/pages/contract/model/renter_model.dart';
import 'package:apartment_app/src/pages/contract/view/liquidation_contract_page.dart';
import 'package:apartment_app/src/pages/dweller/firebase/fb_dweller.dart';
import 'package:apartment_app/src/pages/dweller/model/dweller_model.dart';
import 'package:apartment_app/src/widgets/buttons/roundedButton.dart';
import 'package:apartment_app/src/widgets/title/title_info_null.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class ContractDetails extends StatefulWidget {
  // const ContractDetails({ Key? key }) : super(key: key);
  final String id;
  final String flag;
  final String idRoom;
  List<String> listContract;
  ContractDetails(
      {required this.id,
      required this.idRoom,
      required this.flag,
      required this.listContract});

  @override
  _ContractDetailsState createState() => _ContractDetailsState();
}

class _ContractDetailsState extends State<ContractDetails> {
  ContractFB contractFB = new ContractFB();
  BillInfoFB billInfoFB = new BillInfoFB();
  bool _isAdd = false;
  RenterFB renterFB = new RenterFB();
  RentedRoomFB rentedRoomFB = new RentedRoomFB();
  DwellersFB dwellersFB = new DwellersFB();
  OwnerFB ownerFB = new OwnerFB();
  FloorInfoFB floorInfoFB = new FloorInfoFB();
  final TextEditingController _rulesAController = TextEditingController();
  final TextEditingController _rulesBController = TextEditingController();
  final TextEditingController _rulesCController = TextEditingController();
  final TextEditingController _check = TextEditingController();
  final TextEditingController _idBill = TextEditingController();
  final TextEditingController _beforeBill = TextEditingController();
  final TextEditingController _deposit1 = TextEditingController();
  final TextEditingController _deposit2 = TextEditingController();
  final TextEditingController _total = TextEditingController();
  final TextEditingController _statusBill = TextEditingController();
  Contract contract = new Contract();
  OwnerModel ownerModel = new OwnerModel();
  RenterModel renterModel = new RenterModel();
  @override
  void initState() {
  
    contractFB.collectionReference.doc(widget.id).get().then((value) => {
          contract = Contract.fromDocument(value),
          renterFB.collectionReference
              .doc(value['renter'])
              .get()
              .then((x) => {renterModel = RenterModel.fromDocument(x)}),
          ownerFB.collectionReference
              .doc(value['host'])
              .get()
              .then((y) => {ownerModel = OwnerModel.fromDocument(y)})
        });
    print(widget.idRoom);
    _check.text = '0';
    _idBill.text = 's';
    _beforeBill.text = '0';
    _statusBill.text = '0';
    var now = DateTime.now();
    billInfoFB.collectionReference
        .where('idRoom', isEqualTo: this.widget.idRoom)
        .where('monthBill', isEqualTo: (now.toLocal().month).toString())
        .where('yearBill', isEqualTo: now.toLocal().year.toString())
        .where('idContract', whereIn: widget.listContract)
        .get()
        .then((value) => {
              print(value.docs.length),
              if (value.docs.length != 0)
                {
                  _check.text = '1',
                  _idBill.text = value.docs[0]['idBillInfo'],
                  _total.text = value.docs[0]["total"],
                  _deposit2.text = value.docs[0]["deposit"],
                  print(value.docs[0]['status']),
                  if (value.docs[0]['status'] == '???? thanh to??n')
                    {_statusBill.text = '1'}
                }
            });
    billInfoFB.collectionReference
        .where('idRoom', isEqualTo: this.widget.idRoom)
        .where('monthBill', isEqualTo: (now.toLocal().month - 1).toString())
        .where('yearBill', isEqualTo: now.toLocal().year.toString())
        .get()
        .then((value) => {
              print(value.docs.length),
              if (value.docs.length != 0) {_beforeBill.text = '1'}
            });
    super.initState();
    binding();
  }

  void binding() {
    setState(() {
      contractFB.collectionReference.doc(this.widget.id).get().then((value) => {
            _rulesAController.text = value["rulesA"],
            _rulesBController.text = value["rulesB"],
            _rulesCController.text = value["rulesC"],
            _deposit1.text = value["deposit"],
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
              onPressed: () async {
                final ContractPdfModel contractPdfModel = new ContractPdfModel(
                    contract: contract,
                    renterModel: renterModel,
                    ownerModel: ownerModel);

                final pdfFile =
                    await PdFFormContract.generate(contractPdfModel);

                PdfApi.openFile(pdfFile);
              },
              icon: Icon(
                Icons.find_in_page_outlined,
                size: 30,
              ),
            ),
          ],
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            "H???p ?????ng",
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

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //th??ng tin h???p ?????ng
                      _title("H???p ?????ng"),
                      SizedBox(
                        height: 10,
                      ),
                      _detail("S??? h???p ?????ng", x["id"]),
                      SizedBox(
                        height: 10,
                      ),
                      _detail("Ph??ng", x["room"]),
                      SizedBox(
                        height: 10,
                      ),
                      _detail("Ng??y b???t ?????u", x["startDay"]),
                      SizedBox(
                        height: 10,
                      ),
                      // _detail("?????n ng??y", x["expirationDate"]),
                      // SizedBox(height: 10,),
                      _detail("Ng?????i cho thu??/b??n", x["nameHost"]),
                      SizedBox(
                        height: 10,
                      ),
                      _detail("Ng?????i thu??/mua", x["nameRenter"]),
                      SizedBox(
                        height: 10,
                      ),
                      _detail("Ti???n nh??", x["roomCharge"]),
                      SizedBox(
                        height: 10,
                      ),
                      _detail("Ti???n c???c", x["deposit"]),
                      SizedBox(
                        height: 10,
                      ),
                      // _detail("K??? thanh to??n", x["roomPaymentPeriod"]),
                      // SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Container(
                          //   padding:
                          //   EdgeInsets.only(right: 8,),
                          //   child: RoundedButton(
                          //       name: 'Ch???nh s???a',
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
                                name: 'X??a',
                                onpressed: _isAdd == false ? () => _AddConfirm(context) : null,
                                color: myRed),
                          ),
                          widget.flag == '0'
                              ? Container(
                                  child: RoundedButton(
                                      name: 'Thanh l??',
                                      onpressed: _isAdd == false ? () => _LiquidConfirm(context) : null,
                                      color: myGreen),
                                )
                              : Container(),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      _title("??i???u kho???n"),
                      SizedBox(
                        height: 10,
                      ),
                      TitleInfoNull(text: "??i???u kho???n b??n A"),
                      SizedBox(
                        height: 10,
                      ),
                      _note(_rulesAController),
                      SizedBox(
                        height: 10,
                      ),
                      TitleInfoNull(text: "??i???u kho???n b??n B"),
                      SizedBox(
                        height: 10,
                      ),
                      _note(_rulesBController),
                      SizedBox(
                        height: 10,
                      ),
                      TitleInfoNull(text: "??i???u kho???n chung"),
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
              rentedRoomFB.collectionReference
                  .where('idRoom', isEqualTo: widget.idRoom)
                  .where('expired', isEqualTo: false)
                  .get()
                  .then((value) => {
                        print(value.docs[0]['id']),
                        rentedRoomFB.liquidation(value.docs[0]['id'])
                      }),
              deleteDweller(),
              floorInfoFB.updateStatus(widget.idRoom, 'Tr???ng'),
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
                  hintText: "[Tr???ng]"),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      );
  void _AddConfirm(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('X??C NH???N'),
            content: Text('B???n c?? ch???c mu???n x??a h???p ?????ng n??y?'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    // Remove the box
                    setState(() {
                      _isAdd = false;
                    });

                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: Text('C??')),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: Text('Kh??ng'))
            ],
          );
        });
  }
  void _LiquidConfirm(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('X??C NH???N'),
            content: Text('B???n c?? ch???c mu???n thanh l?? h???p ?????ng n??y?'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    // Remove the box
                    setState(() {
                      _isAdd = false;
                    });
                    print(_check.text);
                    print(_idBill.text);
                    Navigator.of(context).pop();
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) =>
                    LiquidationContractPage(
                    total: _total.text,
                    statusBill:
                    _statusBill
                        .text,
                    deposit1:
                    _deposit1.text,
                    deposit2:
                    _deposit2.text,
                    idRoom:
                    widget.idRoom,
                    beforeBill:
                    _beforeBill
                        .text,
                    idBill:
                    _idBill.text,
                    flag: _check.text,
                    id: widget.id)
                    )
                    );
                    // Close the dialog
                  },
                  child: Text('C??')),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: Text('Kh??ng'))
            ],
          );
        });
  }
  Future<void> deleteDweller() async {
    Stream<QuerySnapshot> query = dwellersFB.collectionReference
        .where('idApartment', isEqualTo: widget.idRoom)
        .snapshots();
    await query.forEach((x) {
      x.docs.asMap().forEach((key, value) {
        var t = x.docs[key];
        dwellersFB.delete(t['idRealTime']);
      });
    });
  }
}
