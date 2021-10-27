import 'package:apartment_app/src/pages/contract/firebase/fb_contract.dart';
import 'package:apartment_app/src/pages/contract/view/liquidation_contract_page.dart';
import 'package:apartment_app/src/pages/contract/view/edit_contract_page.dart';
import 'package:apartment_app/src/widgets/buttons/roundedButton.dart';
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
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 1,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.find_in_page_outlined,
                size: 28,
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
          title: Text("Hợp đồng"),
        ),
        body: StreamBuilder(
            stream: contractFB.collectionReference
                .where('id', isEqualTo: widget.id)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Text("No Data"),
                );
              } else {
                QueryDocumentSnapshot x = snapshot.data!.docs[0];
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 0.5),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 14, bottom: 14, left: 16, right: 16),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: height * 0.015),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(width: 0.5),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    x["id"],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.home_outlined),
                                      SizedBox(
                                        width: width * 0.02,
                                      ),
                                      Text(
                                        x["room"],
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_today_sharp),
                                      SizedBox(
                                        width: width * 0.02,
                                      ),
                                      Text(
                                        "Từ ngày " +
                                            x["startDay"] +
                                            " đến " +
                                            x["expirationDate"],
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.people_alt_outlined),
                                      SizedBox(
                                        width: width * 0.02,
                                      ),
                                      Text(
                                        "Người cho thuê: " + x["host"],
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(
                                    top: height * 0.015,
                                    bottom: height * 0.015),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(width: 0.5),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Tiền phòng:",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          x["roomCharge"],
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Tiền cọc:",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          x["deposit"],
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Kỳ thanh toán:",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          x["roomPaymentPeriod"],
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Container(
                              padding: EdgeInsets.only(
                                  top: height * 0.02,
                                  bottom: height * 0.02 - 14),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(right: 15),
                                    child: RoundedButton(
                                        name: 'Chỉnh sửa',
                                        onpressed: () => {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditContractPage(
                                                              id: widget.id)))
                                            },
                                        color: Colors.amber),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(right: 15),
                                    child: RoundedButton(
                                        name: 'Xóa',
                                        onpressed: () => {_onClick()},
                                        color: Colors.red),
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
                                                              id: widget.id)))
                                            },
                                        color: Colors.green),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 0.5),
                          top: BorderSide(width: 0.5),
                        ),
                      ),
                      padding: EdgeInsets.only(
                          top: 14, bottom: 14, left: 16, right: 16),
                      child: Text(
                        "Dịch vụ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 0.5),
                          top: BorderSide(width: 0.5),
                        ),
                      ),
                      padding: EdgeInsets.only(
                          top: 14, bottom: 14, left: 16, right: 16),
                      child: Text(
                        "Người thuê phòng",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 0.5),
                          top: BorderSide(width: 0.5),
                        ),
                      ),
                      padding: EdgeInsets.only(
                          top: 14, bottom: 14, left: 16, right: 16),
                      child: Text(
                        "Điều khoản",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                );
              }
            }));
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
}
