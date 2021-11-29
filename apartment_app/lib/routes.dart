import 'package:apartment_app/src/pages/home/view/home_page.dart';
import 'package:apartment_app/src/pages/service/view/add_service_page.dart';
import 'package:apartment_app/src/pages/category_apartment/view/category_apartment_page.dart';
import 'package:apartment_app/src/pages/introduction/view/edit_introduction_page.dart';
import 'package:apartment_app/src/pages/introduction/view/introduction_page.dart';
import 'package:apartment_app/src/pages/login/login_page.dart';
import 'package:apartment_app/src/pages/service/view/manage_service_page.dart';
import 'package:apartment_app/src/pages/notification/view/add_notification.dart';
import 'package:apartment_app/src/pages/notification/view/notification_page.dart';
import 'package:apartment_app/src/pages/reset_password/view/reset_password_page.dart';
import 'package:apartment_app/src/pages/splash/splash_page.dart';
import 'package:apartment_app/src/pages/statistic/view/statistic_page.dart';
import 'package:apartment_app/src/pages/tab_pages/tab_page.dart';
import 'package:apartment_app/src/pages/update_password/update_password_page.dart';
import 'package:flutter/material.dart';

final routes = <String, WidgetBuilder>{
  "splash_page": (BuildContext context) => SplashPage(),
  "login_page": (BuildContext context) => LoginPage(),
  "tab_page": (BuildContext context) => TabPage(),
  "category_apartment_page": (BuildContext context) => CategoryApartmentPage(),
  'reset_password_page':(BuildContext context)=>ResetPassWord(),
  'home_page':(BuildContext context)=>HomePage(),

  //Dich vu
  "service_page": (BuildContext context) => ServicePage(),
  "add_service": (BuildContext context) => AddServicPage(),
  //"add_icon": (BuildContext context) => IconList(),

  // Giới thiệu
  "introduction_page":(BuildContext context) =>IntroductionPage(),
  "edit_introduction_page":(BuildContext context) =>EditIntroductionPage(),
  //thong bao
  "notification_page":(BuildContext context) =>NotificationPage(),
  "notification_detail_page":(BuildContext context) =>AddNotificationPage(),
  //doi mat khảu
  "update_password_page":(BuildContext context) =>UpdatePassWordPage(),
  //Hoa don
 
  //Hop dong
  //Thong ke
  'statistic_page':(BuildContext context) =>StatisticPage(),

};
