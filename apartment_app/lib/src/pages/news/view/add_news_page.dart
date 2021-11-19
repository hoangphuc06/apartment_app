import 'dart:html';

import 'package:apartment_app/src/pages/news/firebase/news_fb.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/appbars/my_app_bar.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:apartment_app/src/widgets/title/title_info_not_null.dart';
import 'package:apartment_app/src/widgets/title/title_info_null.dart';
import 'package:flutter/material.dart';

class AddNewsPage extends StatefulWidget {
  const AddNewsPage({Key? key}) : super(key: key);

  @override
  _AddNewsPageState createState() => _AddNewsPageState();
}

class _AddNewsPageState extends State<AddNewsPage> {

  final _formkey = GlobalKey<FormState>();

  NewsFB newsFB = new NewsFB();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar("Thêm tin tức"),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _title("Thông tin chi tiết"),
                    SizedBox(height: 10,),
                    
                    TitleInfoNotNull(text: "Tiêu đề"),
                    SizedBox(height: 10,),
                    _titleTextField(),

                    SizedBox(height: 10,),
                    TitleInfoNotNull(text: "Miêu tả"),
                    SizedBox(height: 10,),
                    _descriptionTextField(),

                    SizedBox(height: 10,),
                    TitleInfoNull(text: "Hình ảnh"),

                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: MainButton(
                  name: "Thêm",
                  onpressed: (){},
                ),
              ),
              SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }

  _title(String text) => Text(
    text,
    style: TextStyle(
        color: Colors.black.withOpacity(0.5),
        fontWeight: FontWeight.bold
    ),
  );

  _titleTextField() => Container(
    padding: MyStyle().padding_container_tff(),
    decoration: MyStyle().style_decoration_container(),
    child: TextFormField(
      decoration: MyStyle().style_decoration_tff("Nhập tiêu đề"),
      style: MyStyle().style_text_tff(),
      controller: _titleController,
      keyboardType: TextInputType.name,
      minLines: 3,
      maxLines: 5,
    ),
  );

  _descriptionTextField() => Container(
    padding: MyStyle().padding_container_tff(),
    decoration: MyStyle().style_decoration_container(),
    child: TextFormField(
      decoration: MyStyle().style_decoration_tff("Nhập miêu tả"),
      style: MyStyle().style_text_tff(),
      controller: _descriptionController,
      keyboardType: TextInputType.name,
      minLines: 8,
      maxLines: 15,
    ),
  );

}
