import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), (){
      Navigator.pushNamed(context, "login_page");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/welcome.png')
                )
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    'INMA',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 45.0),
                  ),
                ),
                Container(
                  child: Text(
                    'An cư - Lạc nghiệp',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
