import 'package:apartment_app/src/pages/notification/model/notification_info.dart';
import 'package:apartment_app/src/widgets/buttons/roundedButton.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    Key? key,
    required this.temp,
    required  this.DeletedFunc,
   required  this.ModifyFunc,
  }) : super(key: key);

  final NotificationInfo temp;
  final  DeletedFunc;
  final  ModifyFunc;
  @override
  Widget build(BuildContext context) {
    String timeformt=  temp.date.toString();
    if (temp.icon.toString()==null||temp.icon!.isEmpty){
      temp.icon='assets/notification_icon/megaphone.png';
    }
    // NotificationInfo temp= new NotificationInfo(id: id,icon:path,body: body,title:title);

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        //color:Color.fromARGB(255,251, 248, 235),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: 80,
                    height: 80,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      //   color:Colors.grey.shade50 ,
                        shape: BoxShape.circle
                    ),
                    child: ImageIcon(new AssetImage(temp.icon.toString() ),
                      //   color: Colors.green.shade900
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Container(

                          decoration:BoxDecoration(
                            borderRadius: BorderRadius.circular(3.0),
                          ) ,
                          child: Text('Thông báo:', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold ,color:Color.fromRGBO(37, 129, 57, 1.0)))),
                    ),
                    Text(temp.title.toString(), style: TextStyle(fontSize: 17)),
                  ],
                )
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RoundedButton(name: 'Chi Tiết ',color: Colors.green,  onpressed: this.ModifyFunc,),
                SizedBox(width: 10,),
                RoundedButton(name: 'Xóa',color: Colors.red, onpressed: this.DeletedFunc,),
                SizedBox(width: 30,),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(timeformt, style: TextStyle(fontSize: 14,color: Colors.grey)),
            ),
          ],
        ),
      ),
    );

  }
}
// Widget notificationCard(NotificationInfo temp,){
//   String timeformt=  temp.date.toString();
//   if (temp.icon.toString()==null||temp.icon!.isEmpty){
//     temp.icon='assets/images/notification_icon/megaphone.png';
//   }
//  // NotificationInfo temp= new NotificationInfo(id: id,icon:path,body: body,title:title);
//
//   return Padding(
//     padding: const EdgeInsets.all(5.0),
//     child: Card(
//       shape:  RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20.0),
//       ),
//       //color:Color.fromARGB(255,251, 248, 235),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Container(
//                   width: 80,
//                   height: 80,
//                   padding: EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     //   color:Colors.grey.shade50 ,
//                       shape: BoxShape.circle
//                   ),
//                   child: ImageIcon(new AssetImage(temp.icon.toString() ),
//                     //   color: Colors.green.shade900
//                   ),
//                 ),
//               ),
//               SizedBox(width: 10),
//               Column(
//                 // mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
//                     child: Container(
//
//                         decoration:BoxDecoration(
//                           borderRadius: BorderRadius.circular(3.0),
//                         ) ,
//                         child: Text('Thong bao:', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold ,color:Color.fromRGBO(37, 129, 57, 1.0)))),
//                   ),
//                   Text(temp.title.toString(), style: TextStyle(fontSize: 17)),
//                 ],
//               )
//             ],
//           ),
//
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               RoundedButton(name: 'chi tiet',color: Colors.green, onpressed: ()async{
//                 await this.modifi(temp);
//               },),
//               SizedBox(width: 10,),
//               RoundedButton(name: 'Xoa',color: Colors.red, onpressed: (){delete(temp);},),
//               SizedBox(width: 30,),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.all(6.0),
//             child: Text(timeformt, style: TextStyle(fontSize: 14,color: Colors.grey)),
//           ),
//         ],
//       ),
//     ),
//   );
//
// }