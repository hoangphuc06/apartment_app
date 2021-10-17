import 'package:apartment_app/src/pages/add_contract_page.dart';
import 'package:apartment_app/src/pages/apartment_info/edit_apartment_info.dart';
import 'package:apartment_app/src/pages/contract_details_page.dart';
import 'package:apartment_app/src/pages/floor_page.dart';
import 'package:apartment_app/src/pages/category_apartment_page.dart';
import 'package:apartment_app/src/pages/login_page.dart';
import 'package:apartment_app/src/pages/register_page.dart';
import 'package:apartment_app/src/pages/splash_page.dart';
import 'package:apartment_app/src/pages/tab_pages/tab_page.dart';
import 'package:apartment_app/src/pages/apartment_info/apartment_info_page.dart';
import 'package:flutter/material.dart';

final routes = <String,WidgetBuilder>{
  "register_page": (BuildContext context) => RegisterPage(),
  "splash_page": (BuildContext context) => SplashPage(),
  "login_page": (BuildContext context) => LoginPage(),
  "tab_page": (BuildContext context) => TabPage(),
  "category_apartment_page": (BuildContext context) => CategoryApartmentPage(),
  "apartment_page": (BuildContext context) => ApartmentPage(),
  "apartment_info_page": (BuildContext context) => ApartmentInfoPage(),
  "edit_apartment_info_page": (BuildContext context) => EditApartmentInfo(),
  "add_contract_page": (BuildContext context) => AddContractPage(),
  "contract_details_page": (BuildContext context) => ContractDetails(),
};