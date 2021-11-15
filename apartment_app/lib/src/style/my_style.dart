import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyStyle {

    style_text_tff() => TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
    );

    style_text_lg() => TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
    );

    style_text_lg_hint() => TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w300,
    );

    style_decoration_container() => BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.grey.withOpacity(0.1)
    );

    style_decoration_tff(String hint) => InputDecoration(
        border: InputBorder.none,
        hintText: hint
    );

    padding_container_tff() => EdgeInsets.only(left: 16, right: 16, bottom: 4, top: 4);
}

