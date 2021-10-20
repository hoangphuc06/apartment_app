import 'dart:convert';
import 'dart:io';
import 'dart:ui';
<<<<<<< Updated upstream

=======
import 'package:apartment_app/src/blocs/auth_bloc.dart';
>>>>>>> Stashed changes
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IconList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return IconListState();
    throw UnimplementedError();
  }
<<<<<<< Updated upstream
  
  
}
class IconListState extends State<IconList>{
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


}
class IconListState extends State<IconList>{
  List<String> pathIcon= [];
  String? SelectedIcon=null;

  void afterSelectIcon(String path){

    Navigator.pop(this.context,path);
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
>>>>>>> Stashed changes
  @override
  void initState() {
    // TODO: implement initState
    _initImages();
    super.initState();
  }
  Widget IconWidget (String path){

<<<<<<< Updated upstream
   return
     GestureDetector(
        onTap:afterSelectIcon ,
   child:  Image.asset(path,fit: BoxFit.fill,));
=======
    return
      GestureDetector(
          onTap:()=>this.afterSelectIcon(path) ,
          child:  Image.asset(path,fit: BoxFit.fill,));
>>>>>>> Stashed changes
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
<<<<<<< Updated upstream
      appBar: AppBar(title: Text('Tao Icon'),),
      body :Padding(
        padding: EdgeInsets.all(10),
          child: GridView.builder(itemCount: this.pathIcon.length,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 6.0,
          mainAxisSpacing: 6.0
      ),   itemBuilder:  (BuildContext context, int index){
        return IconWidget(pathIcon[index]);
      },  )
      )
=======
        appBar: AppBar(title: Text('Tao Icon'),),
        body :Padding(
            padding: EdgeInsets.all(10),
            child: GridView.builder(itemCount: this.pathIcon.length,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 6.0,
                mainAxisSpacing: 6.0
            ),   itemBuilder:  (BuildContext context, int index){
              return IconWidget(pathIcon[index]);
            },  )
        )
>>>>>>> Stashed changes

    );
    throw UnimplementedError();
  }
<<<<<<< Updated upstream
  
  
=======


>>>>>>> Stashed changes
}