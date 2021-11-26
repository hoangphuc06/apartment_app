
import 'package:apartment_app/src/pages/fix/firebase/fb_fix.dart';
import 'package:apartment_app/src/pages/fix/model/fix_model.dart';
import 'package:apartment_app/src/pages/fix/view/fix_detail_page.dart';
import 'package:apartment_app/src/widgets/appbars/my_app_bar.dart';
import 'package:apartment_app/src/widgets/cards/fix_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FixPage extends StatefulWidget {
  const FixPage({Key? key}) : super(key: key);

  @override
  _FixPageState createState() => _FixPageState();
}

class _FixPageState extends State<FixPage> {

  FixFB fixFB = new FixFB();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: myAppBar("Sửa chữa"),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: StreamBuilder(
                      stream: fixFB.collectionReference.orderBy("timestamp",descending: true).snapshots(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: Text("No Data"));
                        } else {
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, i) {
                                QueryDocumentSnapshot x = snapshot.data!.docs[i];
                                Fix fix = Fix.fromDocument(x);
                                return FixCard(
                                    fix: fix,
                                    funtion: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> FixInfoPage(fix)));
                                    });
                              });
                        }
                      }
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}