import 'package:apartment_app/src/pages/add_icon_page.dart';
import 'package:apartment_app/src/pages/add_service_page.dart';
import 'package:apartment_app/src/pages/login_page.dart';
import 'package:apartment_app/src/pages/manage_service_page.dart';
import 'package:apartment_app/src/pages/register_page.dart';
import 'package:apartment_app/src/pages/splash_page.dart';
import 'package:apartment_app/src/pages/tab_page.dart';
import 'package:flutter/material.dart';

final routes = <String,WidgetBuilder>{
  "register_page": (BuildContext context) => RegisterPage(),
  "splash_page": (BuildContext context) => SplashPage(),
  "login_page": (BuildContext context) => LoginPage(),
  "tab_page": (BuildContext context) => TabPage(),
  "service_page":(BuildContext context) =>ServicePage(),
  "add_service":(BuildContext context) =>AddServicPage(),
  "add_icon":(BuildContext context) =>IconList(),
};