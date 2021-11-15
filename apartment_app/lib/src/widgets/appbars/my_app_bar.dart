import 'package:apartment_app/src/colors/colors.dart';
import 'package:flutter/material.dart';

  myAppBar(String title) => AppBar(
    iconTheme: IconThemeData(
      color: myGreen, //change your color here
    ),
    backgroundColor: Colors.white,
    elevation: 0,
    title: Text(title, style: TextStyle(color: myGreen,),),
    centerTitle: true,
  );
