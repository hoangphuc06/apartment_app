import 'dart:io';

import 'package:apartment_app/src/PDF/pdf_api.dart';
import 'package:apartment_app/src/pages/Bill/model/billService_model.dart';
import 'package:apartment_app/src/pages/Bill/model/bill_model.dart';
import 'package:apartment_app/src/pages/contract/model/contractPdf_model.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class PdFFormBill {
  static Future<File> generate(
      BillModel billModel, List<BillService> listService) async {
    final font1 = await rootBundle.load("assets/OpenSans-Bold.ttf");
    final ttf_bold = Font.ttf(font1);
    final font2 = await rootBundle.load("assets/OpenSans-Regular.ttf");
    final ttf_regular = Font.ttf(font2);
    final font3 = await rootBundle.load("assets/OpenSans-Italic.ttf");
    final ttf_italic = Font.ttf(font3);
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('HÓA ĐƠN TIỀN NHÀ',
                      style: TextStyle(fontSize: 17, font: ttf_bold)),
                  Text('Tòa nhà X - phòng ' + billModel.idRoom!,
                      style: TextStyle(fontSize: 13, font: ttf_regular)),
                  Text('Từ' + billModel.startBill! + '-' + billModel.endBill!,
                      style: TextStyle(fontSize: 13, font: ttf_regular)),
                ],
              ),
              Container(
                height: 50,
                width: 50,
                child: BarcodeWidget(
                  barcode: Barcode.qrCode(),
                  data:
                      'https://cafetaichinh.com/wp-content/uploads/2021/02/cachdoino.jpg',
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(flex: 9, child: Container()),
            Expanded(
                flex: 10,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Mã hóa đơn:',
                                style: TextStyle(fontSize: 13, font: ttf_bold)),
                            SizedBox(width: 10),
                            Text(billModel.id!,
                                style:
                                    TextStyle(fontSize: 13, font: ttf_regular)),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Ngày lập hóa đơn:',
                                style: TextStyle(fontSize: 13, font: ttf_bold)),
                            SizedBox(width: 10),
                            Text(billModel.billDate!,
                                style:
                                    TextStyle(fontSize: 13, font: ttf_regular)),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Hạn thanh toán:',
                                style: TextStyle(fontSize: 13, font: ttf_bold)),
                            SizedBox(width: 10),
                            Text(billModel.paymentTerm!,
                                style:
                                    TextStyle(fontSize: 13, font: ttf_regular)),
                          ]),
                    ]))
          ]),
          SizedBox(height: 30),
          Text('Dịch vụ ', style: TextStyle(fontSize: 14, font: ttf_bold)),
          SizedBox(height: 10),
          Container(
              padding: EdgeInsets.only(left: 70, right: 70),
              child: Column(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Dịch vụ',
                          style: TextStyle(fontSize: 13, font: ttf_bold)),
                      Text('Thành tiền',
                          style: TextStyle(fontSize: 13, font: ttf_bold)),
                    ]),
                ListView.builder(
                    itemCount: listService.length,
                    itemBuilder: (context, i) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(listService[i].name!,
                                    style: TextStyle(
                                        fontSize: 13, font: ttf_regular)),
                                Text(listService[i].charge! + ' đ',
                                    style: TextStyle(
                                        fontSize: 13, font: ttf_regular)),
                              ])
                        ],
                      );
                    })
              ])),
          SizedBox(height: 10),
          Text('Điện ', style: TextStyle(fontSize: 14, font: ttf_bold)),
          SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Chỉ số đầu',
                style: TextStyle(fontSize: 13, font: ttf_regular)),
            Text('Chỉ số cuối',
                style: TextStyle(fontSize: 13, font: ttf_regular)),
            Text('Thành tiền',
                style: TextStyle(fontSize: 13, font: ttf_regular)),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(billModel.startE!,
                style: TextStyle(fontSize: 13, font: ttf_regular)),
            Text(billModel.endE!,
                style: TextStyle(fontSize: 13, font: ttf_regular)),
            Text(billModel.totalE!,
                style: TextStyle(fontSize: 13, font: ttf_regular)),
          ]),
          SizedBox(height: 10),
          Text('Nước ', style: TextStyle(fontSize: 14, font: ttf_bold)),
          SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Chỉ số đầu',
                style: TextStyle(fontSize: 13, font: ttf_regular)),
            Text('Chỉ số cuối',
                style: TextStyle(fontSize: 13, font: ttf_regular)),
            Text('Thành tiền',
                style: TextStyle(fontSize: 13, font: ttf_regular)),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(billModel.startW!,
                style: TextStyle(fontSize: 13, font: ttf_regular),
                textAlign: TextAlign.center),
            Text(billModel.endW!,
                style: TextStyle(fontSize: 13, font: ttf_regular),
                textAlign: TextAlign.center),
            Text(billModel.totalW!,
                style: TextStyle(fontSize: 13, font: ttf_regular),
                textAlign: TextAlign.center),
          ]),
          SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Tiền cọc hợp đồng: ',
                  style: TextStyle(fontSize: 13, font: ttf_bold)),
              SizedBox(width: 10),
              Text(billModel.deposit! + ' đ',
                  style: TextStyle(fontSize: 13, font: ttf_regular)),
            ]),
            Expanded(
              flex: 9,
              child: Container(),
            ),
          ]),
          SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              flex: 5,
              child: Container(),
            ),
            Expanded(
                flex: 3,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tổng tiền: ',
                                style: TextStyle(fontSize: 13, font: ttf_bold)),
                            SizedBox(width: 10),
                            Text(billModel.total! + ' đ',
                                style:
                                    TextStyle(fontSize: 13, font: ttf_regular)),
                          ]),
                    ]))
          ]),
          SizedBox(height: 10),
          Text('Lưu ý: '+billModel.note!, style: TextStyle(fontSize: 13, font: ttf_italic)),
          SizedBox(height: 30),
          Container(
            width: double.infinity,
            child: Text(
                'Ngày....tháng....năm.... ',
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 13, font: ttf_regular)),
          ),
          SizedBox(height: 10),
          Container(
              padding: EdgeInsets.only(right: 30, left: 30),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Người lập phiếu',
                        style: TextStyle(fontSize: 13, font: ttf_regular)),
                    Text('Khách hàng',
                        style: TextStyle(fontSize: 13, font: ttf_regular)),
                  ]))
        ])
      ],
      // footer: (context) => buildFooter(invoice),
    ));

    return PdfApi.saveDocument(name: 'my_contract.pdf', pdf: pdf);
  }
}
