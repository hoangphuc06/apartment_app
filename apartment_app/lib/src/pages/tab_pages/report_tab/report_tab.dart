import 'package:flutter/material.dart';

class ReportTab extends StatefulWidget {
  const ReportTab({ Key? key }) : super(key: key);

  @override
  _ReportTabState createState() => _ReportTabState();
}

class _ReportTabState extends State<ReportTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Thống kê'),
      ),
    );
  }
}