import 'package:animated_float_action_button/animated_floating_action_button.dart';
import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/news/firebase/news_fb.dart';
import 'package:apartment_app/src/pages/news/model/news_model.dart';
import 'package:apartment_app/src/pages/news/view/edit_news_page.dart';
import 'package:apartment_app/src/widgets/appbars/my_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailNewsPage extends StatefulWidget {
  final News news;
  const DetailNewsPage({Key? key, required this.news}) : super(key: key);

  @override
  _DetailNewsPageState createState() => _DetailNewsPageState();
}


class _DetailNewsPageState extends State<DetailNewsPage> {

  NewsFB newFB = new NewsFB();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar("Chi tiết tin tức"),
      body: Container(
        //padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Container(
            child: StreamBuilder(
              stream: newFB.collectionReference.where('timestamp', isEqualTo: widget.news.timestamp.toString()).snapshots(),
              builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Text("No Data"),);
                } else {
                  QueryDocumentSnapshot x = snapshot.data!.docs[0];
                  this.widget.news.image = x['image'];
                  this.widget.news.title = x['title'];
                  this.widget.news.description = x['description'];
                  return Column(
                    children: [
                      x['image'] == ""
                          ? Container()
                          : _loadImage(x['image']),
                      Container(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Wrap(
                          runSpacing: 10,
                          children: [
                            Text(
                              x['title'],
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  height: 1.3
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                readDatime(x['timestamp']),
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                            Text(
                              x['description'],
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  height: 1.8
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),

                      ),
                      SizedBox(height: 50,)
                    ],
                  );
                }
              }
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: myGreen,
        child: Icon(Icons.edit, color: Colors.white,),
        onPressed: (){
          edit();
        },
      ),
    );
  }

  Future<void> edit() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditNewsPage(widget.news)));
    // if(n!=null)
    //   setState(() {
    //     this.widget.news = n;
    //   });
  }

  String readDatime(String timestamp) {
    final DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(int.parse(timestamp) * 1000);
    return "${dateTime.day.toString()}/${dateTime.month.toString()}/${dateTime.year.toString()}  ${dateTime.hour.toString()}:${dateTime.minute.toString()}";
  }

  _loadImage(String URL) => Column(
    children: [
      Image.network(
        URL,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
      SizedBox(height: 10,),
    ],
  );

}
