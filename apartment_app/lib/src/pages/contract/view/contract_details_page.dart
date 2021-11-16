import 'package:apartment_app/src/colors/colors.dart';
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
  ContractDetails({required this.id});

  @override
  _ContractDetailsState createState() => _ContractDetailsState();
}

class _ContractDetailsState extends State<ContractDetails> {
  ContractFB contractFB = new ContractFB();
  final TextEditingController _rulesAController = TextEditingController();
  final TextEditingController _rulesBController = TextEditingController();
  final TextEditingController _rulesCController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
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
          backgroundColor:Colors.white,
          centerTitle: true,
          elevation: 1,
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
          title: Text("Hợp đồng", style: TextStyle(color: myGreen,),),
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
                      SizedBox(height: 10,),
                      _detail("Số hợp đồng", x["id"]),
                      SizedBox(height: 10,),
                      _detail("Phòng",x["room"]),
                      SizedBox(height: 10,),
                      _detail("Từ ngày", x["startDay"]),
                      SizedBox(height: 10,),
                      _detail("Đến ngày", x["expirationDate"]),
                      SizedBox(height: 10,),
                      _detail("Người cho thuê", x["host"]),
                      SizedBox(height: 10,),
                      _detail("Tiền phòng", x["roomCharge"]),
                      SizedBox(height: 10,),
                      _detail("Tiền cọc", x["deposit"]),
                      SizedBox(height: 10,),
                      _detail("Kỳ thanh toán", x["roomPaymentPeriod"]),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.end,
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
                            padding:
                            EdgeInsets.only(right: 8),
                            child: RoundedButton(
                                name: 'Xóa',
                                onpressed: () => {_onClick()},
                                color: myRed),
                          ),
                          Container(
                            child: RoundedButton(
                                name: 'Thanh lý',
                                onpressed: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LiquidationContractPage(
                                                  id: widget
                                                      .id)))
                                },
                                color: myGreen),
                          ),
                        ],
                      ),
                      SizedBox(height: 30,),
                      _title("Điều khoản"),
                      SizedBox(height: 10,),
                      TitleInfoNull(text: "Điều khoản bên A"),
                      SizedBox(height: 10,),
                      _noteA(),
                      SizedBox(height: 10,),
                      TitleInfoNull(text: "Điều khoản bên B"),
                      SizedBox(height: 10,),
                      _noteB(),
                      SizedBox(height: 10,),
                      TitleInfoNull(text: "Điều khoản chung"),
                      SizedBox(height: 10,),
                      _note(),
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

  _items(String text, TextEditingController controller,String init) {
    controller.text=init;
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
              hintText: "Nhập ghi chú"
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
              hintText: "Nhập ghi chú"
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
              hintText: "Nhập ghi chú"
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

}
