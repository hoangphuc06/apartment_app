import 'dart:io';

import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/news/firebase/news_fb.dart';
import 'package:apartment_app/src/pages/news/model/news_model.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/appbars/my_app_bar.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:apartment_app/src/widgets/buttons/roundedButton.dart';
import 'package:apartment_app/src/widgets/dialog/loading_dialog.dart';
import 'package:apartment_app/src/widgets/title/title_info_not_null.dart';
import 'package:apartment_app/src/widgets/title/title_info_null.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class EditNewsPage extends StatefulWidget {
  final News news;
  EditNewsPage(this.news);

  @override
  _EditNewsPageState createState() => _EditNewsPageState();
}

class _EditNewsPageState extends State<EditNewsPage> {

  final _formkey = GlobalKey<FormState>();
  File? file;
  String URL = "";
  NewsFB newsFB = new NewsFB();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void initState() {
    // TODO: implement initState
    super.initState();
    initInfo();
  }

  void initInfo() {
    _titleController.text = this.widget.news.title.toString();
    _descriptionController.text = this.widget.news.description.toString();
    URL = this.widget.news.image.toString();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar("Chỉnh sửa tin tức"),
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
                    SizedBox(height: 10,),
                    GestureDetector(
                      onTap: (){
                        _selectImage();
                      },
                      child: widget.news.image.toString()  == "" && file==null ? Container(
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.blueGrey.withOpacity(0.2),
                        ),
                        child: Center(
                          child: Text("Chọn hình ảnh"),
                        ),
                      ) : file == null ? Image.network(widget.news.image.toString())
                        : Image.file(file!),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: MainButton(
                  name: "Sửa",
                  onpressed: (){
                    if(file != null)
                      _upload();
                    else _EditNews();
                  },
                ),
              ),
              SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _EditNews() async {
      String title = _titleController.text.trim();
      String des = _descriptionController.text.trim();
      newsFB.edit(widget.news.timestamp.toString(),URL, _descriptionController.text, _titleController.text)
          .then((value) => {
      Navigator.pop(context,News(
        title: title,
        description: des,
        image: URL,
        timestamp: widget.news.timestamp.toString()
      ))
      });
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
  Future _selectImage() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if(result == null) return;
    final path = result.files.single.path!;

    setState(() {
      file = File(path);
    });
  }
  Future _upload() async{
    String filename = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance.ref().child("news").child("post_$filename");
    LoadingDialog.showLoadingDialog(context, "Đang chỉnh sửa bài viết...");
    await ref.putFile(file!);
    URL = await ref.getDownloadURL();
    LoadingDialog.hideLoadingDialog(context);
    await _EditNews();
  }

}