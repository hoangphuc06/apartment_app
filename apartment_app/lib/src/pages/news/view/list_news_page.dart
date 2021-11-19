import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/news/firebase/news_fb.dart';
import 'package:apartment_app/src/pages/news/model/news_model.dart';
import 'package:apartment_app/src/pages/news/view/add_news_page.dart';
import 'package:apartment_app/src/pages/news/view/detail_news_page.dart';
import 'package:apartment_app/src/widgets/appbars/my_app_bar.dart';
import 'package:apartment_app/src/widgets/cards/news_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListNewsPage extends StatefulWidget {
  const ListNewsPage({Key? key}) : super(key: key);

  @override
  _ListNewsPageState createState() => _ListNewsPageState();
}

class _ListNewsPageState extends State<ListNewsPage> {

  NewsFB newsFB = new NewsFB();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar("Tin tức"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: _title("Danh sách tin tức"),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: StreamBuilder(
                  stream: newsFB.collectionReference.snapshots(),
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
                            News news = News.fromDocument(x);
                            return NewsCard(
                              news: news,
                              function: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailNewsPage(news: news,)));
                              },
                            );
                          });
                    }
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: myGreen,
        child: Icon(Icons.add, color: Colors.white,),
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddNewsPage()));
        },
      ),
    );
  }

  _title(String text) => Text(
    text,
    style: TextStyle(
        color: Colors.black.withOpacity(0.5),
        fontWeight: FontWeight.bold
    ),
  );
}
