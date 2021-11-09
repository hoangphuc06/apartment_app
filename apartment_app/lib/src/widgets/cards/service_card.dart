import 'package:apartment_app/src/pages/service/model/service_info.dart';
import 'package:apartment_app/src/pages/service/model/service_model.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final ServiceModel serviceInfo;
  const ServiceCard({
    Key? key,
    required  this.onPressed, required this.serviceInfo,
  }) : super(key: key);

   final  onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        elevation: 2,
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(serviceInfo.name.toString(), style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Row(
                children: [
                  Icon(Icons.attach_money ),
                  SizedBox(width: 5,),
                  Text("Phí dịch vụ", style: TextStyle(fontSize: 15),),
                  Spacer(),
                  Text(serviceInfo.charge.toString()+" VNĐ", style: TextStyle(fontSize: 15),),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Icon(Icons.credit_card),
                  SizedBox(width: 5,),
                  Text("Đơn vị", style: TextStyle(fontSize: 15),),
                  Spacer(),
                  Text(serviceInfo.type.toString(), style: TextStyle(fontSize: 15),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   print('Icon Path:${info.iconPath.toString()}');
  //   String pathAsset = info.iconPath != null
  //       ? info.iconPath.toString()
  //       :  'assets/images/add_icon.png';
  //   String temp1 = '/';
  //   temp1 = info.type != null ? temp1 + info.type.toString() : '';
  //
  //   String detail = (info.charge != null && info.charge!.contains(new RegExp(r'[0-9]'))
  //       ? info.charge.toString() + 'VND'
  //       : '0vnd');
  //   print(detail);
  //   print(temp1);
  //   if(temp1.contains('Lũy tiền theo chỉ số đồng hồ')) temp1='';
  //   return GestureDetector(
  //     onTap: onPressed,
  //     child: Card(
  //       child: Padding(
  //         padding: const EdgeInsets.all(10.0),
  //         child: Column(
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.fromLTRB(0, 4, 0, 10),
  //               child: SizedBox(height: 125,child: Image.asset(pathAsset, fit: BoxFit.fill)),
  //             ),
  //             Text(
  //               info.name.toString(),
  //               style: TextStyle(fontSize: 18),
  //             ),
  //             SizedBox.fromSize(size: Size(0,4),),
  //             Text(detail + temp1, style: MyStyle().style_text_tff(),)
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  //
  // }
}