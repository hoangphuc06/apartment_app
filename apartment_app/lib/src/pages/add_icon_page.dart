import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IconList extends StatefulWidget{
  String ?path='images/service_icon/';
  IconList({this.path ,Key? key}): super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    IconListState temp= new IconListState();
    if(!path!.isEmpty||path!=null){
      temp.path=this.path;
    }

    return temp;
    throw UnimplementedError();
  }

  
}
/*class IconListState extends State<IconList>{
 List<String> pathIcon= [];
 String? SelectedIcon=null;
 void afterSelectIcon(){

   Navigator.pop(this.context);
 }
 Future _initImages() async {
   // >> To get paths you need these 2 lines
   final manifestContent = await rootBundle.loadString('AssetManifest.json');

   final Map<String, dynamic> manifestMap = json.decode(manifestContent);
   // >> To get paths you need these 2 lines

   final imagePaths = manifestMap.keys
       .where((String key) => key.contains('images/service_icon/'))
       .toList();
   setState(() {
     pathIcon = imagePaths;
   });
 }
 void ImageList(){


 }
=======


}*/
class IconListState extends State<IconList> {
  List<String> pathIcon = [];
  String? SelectedIcon = null;
  String? path='images/service_icon/';
  void afterSelectIcon(String path) {
    if(!path.isEmpty)
    Navigator.pop(this.context, path);
    else Navigator.pop(context);
  }

  Future _initImages() async {
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains(path.toString()))
        .toList();
    setState(() {
      pathIcon = imagePaths;
    });
  }

  void ImageList() {


  }

  @override
  void initState() {
    // TODO: implement initState
    _initImages();
    super.initState();
  }

  Widget IconWidget(String path) {
    return
      GestureDetector(
          onTap: () => this.afterSelectIcon(path),
          child: Image.asset(path, fit: BoxFit.fill,));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text('Tao Icon'),),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: GridView.builder(itemCount: this.pathIcon.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 6.0,
                  mainAxisSpacing: 6.0
              ),
              itemBuilder: (BuildContext context, int index) {
                return IconWidget(pathIcon[index]);
              },)
        )
    );
    throw UnimplementedError();
  }
}
