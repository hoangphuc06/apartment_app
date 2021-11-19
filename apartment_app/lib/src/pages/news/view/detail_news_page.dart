import 'package:apartment_app/src/pages/news/model/news_model.dart';
import 'package:apartment_app/src/widgets/appbars/my_app_bar.dart';
import 'package:flutter/material.dart';

class DetailNewsPage extends StatefulWidget {
  final News news;
  const DetailNewsPage({Key? key, required this.news}) : super(key: key);

  @override
  _DetailNewsPageState createState() => _DetailNewsPageState();
}

class _DetailNewsPageState extends State<DetailNewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar("Chi tiết tin tức"),
      body: Container(
        //padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              widget.news.image.toString() == ""? Container() : _loadImage(),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Wrap(
                  runSpacing: 10,
                  children: [
                    Text(
                      widget.news.title.toString(),
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
                        readDatime(widget.news.timestamp.toString()),
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    Text(
                      widget.news.description.toString(),
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
          ),
        ),
      ),
    );
  }

  String readDatime(String timestamp) {
    final DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(int.parse(timestamp) * 1000);
    return "${dateTime.day.toString()}/${dateTime.month.toString()}/${dateTime.year.toString()}  ${dateTime.hour.toString()}:${dateTime.minute.toString()}";
  }

  _loadImage() => Column(
    children: [
      Image.network(
        widget.news.image.toString(),
        width: double.infinity,
        fit: BoxFit.cover,
      ),
      SizedBox(height: 10,),
    ],
  );
}
