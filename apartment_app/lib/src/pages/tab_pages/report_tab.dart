import 'package:flutter/material.dart';

class ReportTab extends StatefulWidget {
  const ReportTab({Key? key}) : super(key: key);

  @override
  _ReportTabState createState() => _ReportTabState();
}

class _ReportTabState extends State<ReportTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Báo cáo",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: Column(),
    );
  }
}
