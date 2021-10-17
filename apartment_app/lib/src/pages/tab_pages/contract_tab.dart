import 'package:apartment_app/src/fire_base/fb_contract.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ContractTab extends StatefulWidget {
  const ContractTab({Key? key}) : super(key: key);

  @override
  _ContractTabState createState() => _ContractTabState();
}

class _ContractTabState extends State<ContractTab> {
  @override
  Widget build(BuildContext context) {

    ContractFB contractFB = new ContractFB();
    
    final double height= MediaQuery.of(context).size.height;
    final double width= MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder(
           stream: contractFB.collectionReference.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
            if (!snapshot.hasData) {
              return Center(child: Text("No Data"),);
            }
            else{
              return ListView.builder(
                 shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,i){
                    QueryDocumentSnapshot x = snapshot.data!.docs[i];
                     return InkWell(
                      splashColor: Colors.amber,
                      onTap: ()=>{Navigator.pushNamed(context, "contract_details_page")},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            border: Border.all(),
                          ),
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          
                            Text(
                              "#"+x["id"].toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w700,

                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.home_outlined),
                                  SizedBox(width: width*0.02,),
                                Text(
                                  x["room"]
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.calendar_today_sharp),
                                  SizedBox(width: width*0.02,),
                                Text(
                                  "Từ ngày " + x["startDay"].toString() +" đến "+x["expirationDate"].toString(),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.people_alt_outlined),
                                SizedBox(width: width*0.02,),
                                Text(
                                  "Người cho thuê: "+x["host"].toString(),
                                )
                              ],
                            ),
                          ],),
                        ),
                      ),
                     );
                  }
              );
                
            }
          }),
      ),
      floatingActionButton:  FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.amber,
          onPressed: (){
             Navigator.pushNamed(context, "add_contract_page");
          },
      ),
    );
  }
}




