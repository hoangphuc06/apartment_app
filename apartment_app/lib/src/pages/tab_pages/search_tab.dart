import 'package:flutter/material.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({ Key? key }) : super(key: key);

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text("Search Tab"),
    );
  }
}