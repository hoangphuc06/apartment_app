import 'dart:io';

import 'package:apartment_app/src/PDF/pdf_api.dart';
import 'package:apartment_app/src/pages/contract/model/contractPdf_model.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class PdFFormContract {
  static Future<File> generate(ContractPdfModel contractPdfModel) async {
    final font1 = await rootBundle.load("assets/OpenSans-Bold.ttf");
    final ttf_bold = Font.ttf(font1);
    final font2 = await rootBundle.load("assets/OpenSans-Regular.ttf");
    final ttf_regular = Font.ttf(font2);
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(
              child: Text('CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM',
                  style: TextStyle(fontSize: 14, font: ttf_bold))),
          SizedBox(height: 10),
          Center(
              child: Text('Độc lập - Tự do - Hạnh phúc',
                  style: TextStyle(fontSize: 13, font: ttf_regular))),
          SizedBox(height: 10),
          Center(
              child: Text('--o0o--',
                  style: TextStyle(fontSize: 14, font: ttf_bold))),
          SizedBox(height: 10),
          Center(
              child: Text('HỢP ĐỒNG THUÊ CĂN HỘ',
                  style: TextStyle(fontSize: 14, font: ttf_bold))),
          SizedBox(height: 20),
          Text('Chúng tôi gồm:',
              style: TextStyle(fontSize: 13, font: ttf_bold)),
          SizedBox(height: 10),
          Text('1. Đại diện bên cho thuê căn hộ(Bên A):',
              style: TextStyle(fontSize: 13, font: ttf_regular)),
          SizedBox(height: 10),
          Text(
              'Ông/bà: ' +
                  contractPdfModel.ownerModel.name! +
                  '. Sinh ngày: ' +
                  contractPdfModel.ownerModel.birthday!,
              style: TextStyle(fontSize: 13, font: ttf_regular)),
          SizedBox(height: 10),
          Text('Nơi đăng ký HK: ' + contractPdfModel.ownerModel.address!,
              style: TextStyle(fontSize: 13, font: ttf_regular)),
          SizedBox(height: 10),
          Text('CMND/CCCD: ' + contractPdfModel.ownerModel.cmnd!,
              style: TextStyle(fontSize: 13, font: ttf_regular)),
          SizedBox(height: 10),
          Text('Số điện thoại: ' + contractPdfModel.ownerModel.phoneNumber!,
              style: TextStyle(fontSize: 13, font: ttf_regular)),
          SizedBox(height: 10),
          Text('2. Bên thuê căn hộ(Bên B):',
              style: TextStyle(fontSize: 13, font: ttf_regular)),
          SizedBox(height: 10),
          Text(
              'Ông/bà: ' +
                  contractPdfModel.renterModel.name! +
                  '. Sinh ngày: ' +
                  contractPdfModel.renterModel.birthday!,
              style: TextStyle(fontSize: 13, font: ttf_regular)),
          SizedBox(height: 10),
          Text('Nơi đăng ký HK: ' + contractPdfModel.renterModel.address!,
              style: TextStyle(fontSize: 13, font: ttf_regular)),
          SizedBox(height: 10),
          Text('CMND/CCCD: ' + contractPdfModel.renterModel.cmnd!,
              style: TextStyle(fontSize: 13, font: ttf_regular)),
          SizedBox(height: 10),
          Text('Số điện thoại: ' + contractPdfModel.renterModel.phoneNumber!,
              style: TextStyle(fontSize: 13, font: ttf_regular)),
          SizedBox(height: 10),
          Text(
              'Sau khi bàn bạc trên tinh thần dân chủ, hai bên cùng có lợi, cùng thống nhất như sau:',
              style: TextStyle(fontSize: 13, font: ttf_bold)),
          SizedBox(height: 10),
          Text(
              'Bên A đồng ý cho bên B thuê 01 căn hộ tại chung cư Dream Building',
              style: TextStyle(fontSize: 13, font: ttf_regular)),
          SizedBox(height: 10),
          Text('Giá thuê: ' + contractPdfModel.contract.roomCharge! + ' đ/tháng',
              style: TextStyle(fontSize: 13, font: ttf_regular)),
          SizedBox(height: 10),
          Text('Tiền cọc: ' + contractPdfModel.contract.deposit! + ' đ',
              style: TextStyle(fontSize: 13, font: ttf_regular)),
          SizedBox(height: 10),
          Text('Hình thức thanh toán: Tiền mặt',
              style: TextStyle(fontSize: 13, font: ttf_regular)),
          SizedBox(height: 10),
          Text(
              'Hợp đồng có giá trị kể từ ngày ' +
                  contractPdfModel.contract.startDay!,
              style: TextStyle(fontSize: 13, font: ttf_regular)),
          SizedBox(height: 10),
          Text('TRÁCH NHIỆM CỦA CÁC BÊN',
              style: TextStyle(fontSize: 13, font: ttf_bold)),
          SizedBox(height: 10),
          Text('*Trách nhiệm của bên A:',
              style: TextStyle(fontSize: 13, font: ttf_bold)),
          SizedBox(height: 10),
          Text(contractPdfModel.contract.rulesA!,
              style: TextStyle(fontSize: 13, font: ttf_regular)),
          SizedBox(height: 10),
          Text('*Trách nhiệm của bên B:',
              style: TextStyle(fontSize: 13, font: ttf_bold)),
          SizedBox(height: 10),
          Text(contractPdfModel.contract.rulesB!,
              style: TextStyle(fontSize: 13, font: ttf_regular)),
          SizedBox(height: 10),
          Text('TRÁCH NHIỆM CHUNG',
              style: TextStyle(fontSize: 13, font: ttf_bold)),
          SizedBox(height: 10),
          Text(contractPdfModel.contract.rulesC!,
              style: TextStyle(fontSize: 13, font: ttf_regular)),
          SizedBox(height: 10),
          Text(
              'Hợp đồng được lập thành 02 bản có giá trị pháp lý như nhau, mỗi bên giữ 1 bản.',
              style: TextStyle(fontSize: 13, font: ttf_regular)),
          SizedBox(height: 30),
          Container(
            width: double.infinity,
            child: Text(
                '...,ngày ' +
                    contractPdfModel.contract.startDay!.substring(0, 2) +
                    ' tháng ' +
                    contractPdfModel.contract.startDay!.substring(3, 5) +
                    ' năm ' +
                    contractPdfModel.contract.startDay!.substring(6),
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 13, font: ttf_regular)),
          ),
          SizedBox(height: 10),
          Container(
              padding: EdgeInsets.only(right: 30, left: 30),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('ĐẠI DIỆN BÊN B',
                        style: TextStyle(fontSize: 13, font: ttf_bold)),
                    Text('ĐẠI DIỆN BÊN A',
                        style: TextStyle(fontSize: 13, font: ttf_bold)),
                  ]))
        ])
      ],
      // footer: (context) => buildFooter(invoice),
    ));

    return PdfApi.saveDocument(name: 'my_contract.pdf', pdf: pdf);
  }
}
