import 'package:flutter/material.dart';

class ContractTab extends StatefulWidget {
  const ContractTab({Key? key}) : super(key: key);

  @override
  _ContractTabState createState() => _ContractTabState();
}

class _ContractTabState extends State<ContractTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Tab 2"),),
    );
  }
}
