
import 'package:flutter/material.dart';
import 'package:apartment_app/src/fire_base/fb_apartment_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ApartmentInfoPage extends StatefulWidget {
  const ApartmentInfoPage({ Key? key }) : super(key: key);

  @override
  _ApartmentInfoPageState createState() => _ApartmentInfoPageState();
}

class _ApartmentInfoPageState extends State<ApartmentInfoPage> {

  ApartmentInfoFB apartmentInfoFB = new ApartmentInfoFB();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SingleChildScrollView(       
        child:StreamBuilder(
          stream: apartmentInfoFB.collectionReference.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
            if (!snapshot.hasData) {
              return Center(child: Text("No Data"),);
            }
            else{
               QueryDocumentSnapshot x = snapshot.data!.docs[0];
              return Column(
        children: [
          Container(
           padding: EdgeInsets.all(20),
            child:Row(
            children: [
              Icon(Icons.arrow_back_ios,size: 20,),
              Text("Quay lại"),
            ],
           ),
         ),
         Container(
          padding: EdgeInsets.only(top: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    'INMA',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 45.0),
                  ),
                ),
                Container(
                  child: Text(
                    'An cư - Lạc nghiệp',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 20.0),
                  ),
                ),
              ],
            ),),
            Container(
              padding: EdgeInsets.only(right: 30,left: 30,top: 10,bottom: 15),
              decoration:  BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey)
                )),
              child: Text(
                "Là dịch vụ quản lí chung trực tuyến cho phép khách hàng thực hiện các thao tác quản lí trên thiết bị di động",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              
            ),
            Container( 
              alignment: Alignment.center,    
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text(
                  "Xem thêm thông tin sản phẩm",
                   textAlign: TextAlign.center,),
                Icon(Icons.arrow_drop_down,color: Colors.grey,),
              ]),),
            Container(
               margin: EdgeInsets.all(15),        
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Icon(Icons.tty) ,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(color: Colors.grey,)
                      )
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left:8),
                    child:  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(
                         "Hotline 24/7",
                         style: TextStyle(
                           fontSize: 14,
                           fontWeight:FontWeight.w800,

                           ),),
                        Text(
                         x["phoneNumber1"],
                          style: TextStyle(
                           fontSize: 16,
                           fontWeight:FontWeight.w400,
                           decoration: TextDecoration.underline,

                           ),
                           ),
                        Text(
                          x["phoneNumber2"],
                          style: TextStyle(
                           fontSize: 16,
                           fontWeight:FontWeight.w400,
                           decoration: TextDecoration.underline,

                           ),),
                         Text(
                          x["linkPage"],
                          style: TextStyle(
                           fontSize: 16,
                           fontWeight:FontWeight.w400,
                           decoration: TextDecoration.underline,

                           ),),
                     ],
                     ),
                  ),
                 
                 
                ],),
            ),
             Container(
               margin: EdgeInsets.all(15),        
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Icon(Icons.location_on_outlined) ,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(color: Colors.grey,)
                      )
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left:8),
                    child:  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(
                         "Trụ sở chính",
                         style: TextStyle(
                           fontSize: 14,
                           fontWeight:FontWeight.w800,

                           ),),
                        Text(
                         x["headquarters"],
                          style: TextStyle(
                           fontSize: 16,
                           fontWeight:FontWeight.w400,
                          

                           ),),
                         Container(
                           child:  Text(
                          x["address"],
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                           fontSize: 16,
                           fontWeight:FontWeight.w400,
                           decoration: TextDecoration.underline,             
                           ),
                           maxLines: 2,
                           
                           ),
                           
                         )
                        
                     ],
                     ),
                  ),
                 
                 
                ],),
            )
        
        ],);
            }
          }
        )
      ),
       floatingActionButton: FloatingActionButton(
          child: Icon(Icons.edit),
          backgroundColor: Colors.amber,
          onPressed: (){
             Navigator.pushNamed(context, "edit_apartment_info_page");
          },

        ),
    );
    
}

}