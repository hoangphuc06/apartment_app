
import 'package:apartment_app/src/pages/add_icon_page.dart';
import 'package:apartment_app/src/pages/add_service_page.dart';
import 'package:apartment_app/src/pages/apartment_info_page.dart';
import 'package:apartment_app/src/pages/category_apartment_page.dart';
import 'package:apartment_app/src/pages/floor_page.dart';
import 'package:apartment_app/src/pages/login_page.dart';
import 'package:apartment_app/src/pages/manage_service_page.dart';
import 'package:apartment_app/src/pages/register_page.dart';
import 'package:apartment_app/src/pages/reset_password_page.dart';
import 'package:apartment_app/src/pages/splash_page.dart';
import 'package:apartment_app/src/pages/tab_page.dart';
import 'package:flutter/material.dart';

final routes = <String,WidgetBuilder>{
  "register_page": (BuildContext context) => RegisterPage(),
  "splash_page": (BuildContext context) => SplashPage(),
  "login_page": (BuildContext context) => LoginPage(),
  "tab_page": (BuildContext context) => TabPage(),
  "category_apartment_page": (BuildContext context) => CategoryApartmentPage(),
  "apartment_page": (BuildContext context) => ApartmentPage(),
  "apartment_info_page": (BuildContext context) => ApartmentInfoPage(),
  "service_page":(BuildContext context) =>ServicePage(),
  "add_service":(BuildContext context) =>AddServicPage(),
  "add_icon":(BuildContext context) =>IconList(),
  "category_apartment_page": (BuildContext context) => CategoryApartmentPage(),
  "apartment_page": (BuildContext context) => ApartmentPage(),
  "apartment_info_page": (BuildContext context) => ApartmentInfoPage(),
  "service_page":(BuildContext context) =>ServicePage(),
  "add_service":(BuildContext context) =>AddServicPage(),
  "add_icon":(BuildContext context) =>IconList(),
  'reset_password_page':(BuildContext context)=>ResetPassWord()
};