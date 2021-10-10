
import 'package:flutter/material.dart';

class MessageTab extends StatefulWidget {
  const MessageTab({ Key? key }) : super(key: key);

  @override
  _MessageTabState createState() => _MessageTabState();
}

class _MessageTabState extends State<MessageTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text("Message Tab"),
    );
  }
}