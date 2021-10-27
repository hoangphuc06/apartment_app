import 'package:apartment_app/src/blocs/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../routes.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: "login_page",
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
    );
  }
}