
import 'package:flutter/material.dart';

class MessageTab extends StatefulWidget {
  const MessageTab({Key? key}) : super(key: key);

  @override
  _MessageTabState createState() => _MessageTabState();
}

class _MessageTabState extends State<MessageTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Tin nhắn",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: Column(),
    );
  }
}
