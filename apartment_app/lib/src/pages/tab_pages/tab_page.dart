import 'package:apartment_app/src/pages/tab_pages/home_tab.dart';
import 'package:apartment_app/src/pages/tab_pages/message_tab.dart';
import 'package:apartment_app/src/pages/tab_pages/others_tab.dart';
import 'package:apartment_app/src/pages/tab_pages/report_tab.dart';
import 'package:apartment_app/src/pages/tab_pages/search_tab.dart';
import 'package:flutter/material.dart';

class TabPage extends StatefulWidget {
  const TabPage({Key? key}) : super(key: key);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {

  List<Widget> _widgetOptions=[
    HomeTab(),
    SearchTab(),
    MessageTab(),
    ReportTab(),
    OthersTab(),
  ];

  int _selectedItemIndex = 0;

  void _cambiarWidget(int index) {
    setState(() {
      _selectedItemIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedItemIndex),
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      iconSize: 30.0,
      selectedItemColor: Colors.amber,
      unselectedItemColor: Colors.grey,
      currentIndex: _selectedItemIndex,
      onTap: _cambiarWidget,
      showUnselectedLabels: true,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: "Home"
        ),
         BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: "Home"
        ),
         BottomNavigationBarItem(
          icon: Icon(Icons.report),
          label: "Home"
        ),
         BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz),
          label: "Others"
        ),
      ],
    );
  }

  
}
