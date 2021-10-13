import 'package:flutter/material.dart';
import 'package:apartment_app/src/fire_base/fb_optionsmanager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class OthersTab extends StatefulWidget {
  const OthersTab({Key? key}) : super(key: key);

  @override
  _OthersTabState createState() => _OthersTabState();
}

class _OthersTabState extends State<OthersTab> {

  OptionsManagerFB optionsManagerFB = new OptionsManagerFB();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Khác",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(       
        child:StreamBuilder(
          stream: optionsManagerFB.collectionReference.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
            if (!snapshot.hasData) {
              return Center(child: Text("No Data"),);
            }
            else{
               return ListView.builder(
                 shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,i) {
                    QueryDocumentSnapshot x = snapshot.data!.docs[i];
                     return InkWell(
                      splashColor: Colors.amber,
                      onTap: ()=>{Navigator.pushNamed(context, x["ontap"])},
                      child: Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(color: Colors.grey))
                                      ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(                      
                                        child:  
                                          Row(                         
                                            children: [
                                            Container(
                                              padding: EdgeInsets.only(right: 20),
                                              child:Icon(
                                                Icons.credit_card,
                                                color: Colors.grey,
                                                size: 30,
                                              ),
                                            ), 
                                              Text(
                                                x["title"],
                                                style: TextStyle(
                                                fontSize: 14, 
                                                fontWeight:FontWeight.w400,
                                                color: Colors.grey[600],
                                              ),
                                        ),
                                            ],
                                          ),
                                          ),   
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.grey,
                                        size: 15,
                                        ),
                                    ],
                                  ),
                        ),
                    );
                  }
               );
            }
          },)
        
        
     
      )
      
      
    );
  }
}


