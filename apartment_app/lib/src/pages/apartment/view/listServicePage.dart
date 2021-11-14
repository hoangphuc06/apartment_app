import 'package:flutter/material.dart';

class ListServicePage extends StatefulWidget {
  // const ListServicePage({ Key? key }) : super(key: key);
  final String id;
  ListServicePage({required this.id});
  @override
  _ListServicePageState createState() => _ListServicePageState();
}

class _ListServicePageState extends State<ListServicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(this.widget.id.toString()),
    );
  }
}