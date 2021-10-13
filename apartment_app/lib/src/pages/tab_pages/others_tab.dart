import 'package:flutter/material.dart';

class OthersTab extends StatefulWidget {
  const OthersTab({Key? key}) : super(key: key);

  @override
  _OthersTabState createState() => _OthersTabState();
}

class _OthersTabState extends State<OthersTab> {
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
      body: Column(
        children: [
          buildManagerOptions("Tài khoản của bạn"),
          buildManagerOptions("Dịch vụ"),
          buildManagerOptions("Tài khoản của bạn"),
        ],
      ),
    );
  }
}



  
  Padding buildManagerOptions(String title) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
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
                            Icon(
                              Icons.credit_card,
                              color: Colors.grey,
                              
                            ),
                            Text(
                              title,
                              style: TextStyle(
                              fontSize: 18, 
                              fontWeight:FontWeight.w500,
                              color: Colors.grey[600],
                            ),
                      ),
                          ],
                        ),
                        ),   
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      
                      ),
                  ],
                ),
      ),
    );
}