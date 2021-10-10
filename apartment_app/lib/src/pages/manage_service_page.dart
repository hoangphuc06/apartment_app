import 'package:flutter/material.dart';

import 'add_service_page.dart';
class ServicePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateServicePage();
    throw UnimplementedError();
  }


}

class StateServicePage extends State<ServicePage>{

  void addButtonOnPressed(){
    Route route = MaterialPageRoute(builder: (context) => AddServicPage());
    Navigator.push(this.context, route);
  }
  late List<Widget> items=  <Widget>[];
  void createListCard(){
    int i=0;
    items.clear();
    while(i<16)
    {
      i++;
      items.add(this.ServiceBox());
    }

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    createListCard();
    return Scaffold(
      floatingActionButton:FloatingActionButton(onPressed: addButtonOnPressed,) ,
      appBar: AppBar(title: Row(
        children: [
          SizedBox( width: 150,),
          Text("DICH VU",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold))
        ],
      ),),

      body:

      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(

          mainAxisAlignment:  MainAxisAlignment.start,
          crossAxisAlignment:  CrossAxisAlignment.start,
          children: [
            Container(

              decoration: BoxDecoration(
                  color: Colors.white70,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: TextField(
                style: TextStyle(fontSize: 18),
                cursorColor: Colors.red,
                decoration: InputDecoration(

                  hintText: 'Tim kiem theo ten',
                  hintStyle: TextStyle(color:Colors.grey.shade400,fontSize: 18),
                  icon: const Icon(Icons.search,size: 35,color: Colors.grey,),

                ),
              ),
            ),
            SizedBox(height: 20),
            Text("Dich Vu Co Phi",style: TextStyle(fontSize: 22,color: Colors.grey.shade700),),
            SizedBox(height: 18),
            Expanded(
              child: GridView.count(crossAxisCount: 3,mainAxisSpacing: 5,crossAxisSpacing: 5,
                children: items,
              ),
            ),

          ],
        ),
      ),


    );
    throw UnimplementedError();
  }
  Widget ServiceBox () {
    return Card(
      color: Colors.blue,
      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.account_balance_sharp,size:16,color: Colors.deepOrange,),
                SizedBox(
                  width: 10,
                )
              ],
            ),
            Icon(Icons.access_alarm,color: Colors.amber,size: 40.0,),
            SizedBox(height: 10,),
            Text("Name",),
            SizedBox(height: 8),
            Text('Detail'),

          ],
        ),
      ),

    );
  }



}