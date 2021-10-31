
import 'package:apartment_app/src/pages/add_icon_page.dart';
import 'package:apartment_app/src/pages/service/view/add_service_page.dart';
import 'package:apartment_app/src/pages/dweller/view/add_dweller_page.dart';
import 'package:apartment_app/src/pages/dweller/view/list_dwellers_page.dart';
import 'package:apartment_app/src/pages/add_contract_page.dart';
import 'package:apartment_app/src/pages/contract_details_page.dart';
import 'package:apartment_app/src/pages/floor_page.dart';
import 'package:apartment_app/src/pages/category_apartment/view/category_apartment_page.dart';
import 'package:apartment_app/src/pages/introduction/view/edit_introduction_page.dart';
import 'package:apartment_app/src/pages/introduction/view/introduction_page.dart';
import 'package:apartment_app/src/pages/login_page.dart';
import 'package:apartment_app/src/pages/service/view/manage_service_page.dart';
import 'package:apartment_app/src/pages/notification/view/notification_detail.dart';
import 'package:apartment_app/src/pages/notification/view/notification_page.dart';
import 'package:apartment_app/src/pages/register_page.dart';
import 'package:apartment_app/src/pages/reset_password/view/reset_password_page.dart';
import 'package:apartment_app/src/pages/splash_page.dart';
import 'package:apartment_app/src/pages/tab_pages/tab_page.dart';
import 'package:apartment_app/src/pages/update_password/view/update_password_page.dart';
import 'package:flutter/material.dart';

final routes = <String,WidgetBuilder>{
  "register_page": (BuildContext context) => RegisterPage(),
  "splash_page": (BuildContext context) => SplashPage(),
  "login_page": (BuildContext context) => LoginPage(),
  "tab_page": (BuildContext context) => TabPage(),
  "category_apartment_page": (BuildContext context) => CategoryApartmentPage(),
  "apartment_page": (BuildContext context) => ApartmentPage(),
  //"apartment_info_page": (BuildContext context) => ApartmentInfoPage(),
  "category_apartment_page": (BuildContext context) => CategoryApartmentPage(),
  "apartment_page": (BuildContext context) => ApartmentPage(),
  //"apartment_info_page": (BuildContext context) => ApartmentInfoPage(),
  'reset_password_page':(BuildContext context)=>ResetPassWord(),
 // "tab_page_with_email": (BuildContext context) => TabPage( email),

  // Dân cư
  //"list_dwellers_page": (BuildContext context) => ListDwellersPage(),
  //"add_dweller_page": (BuildContext context) => AddDwellerPage(),

  //"edit_apartment_info_page": (BuildContext context) => EditApartmentInfo(),
  "add_contract_page": (BuildContext context) => AddContractPage(),

  //Dich vu
  "service_page":(BuildContext context) =>ServicePage(),
  "add_service":(BuildContext context) =>AddServicPage(),
  "add_icon":(BuildContext context) =>IconList(),

  // Giới thiệu
  "introduction_page":(BuildContext context) =>IntroductionPage(),
  "edit_introduction_page":(BuildContext context) =>EditIntroductionPage(),
  //thong bao
  "notification_page":(BuildContext context) =>NotificationPage(),
  "notification_detail_page":(BuildContext context) =>NotificationDetailPage(),
  //doi mat khảu
  "update_password_page":(BuildContext context) =>UpdatePassWordPage(),
};