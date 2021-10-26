import 'package:apartment_app/src/pages/category_apartment/firebase/fb_category_apartment.dart';
import 'package:apartment_app/src/model/categoty_apartment.dart';
import 'package:apartment_app/src/pages/category_apartment/view/add_category_apartment_page.dart';
import 'package:apartment_app/src/pages/category_apartment/view/edit_category_apartment_page.dart';
import 'package:apartment_app/src/widgets/buttons/back_button.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:apartment_app/src/widgets/cards/category_apartment_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryApartmentPage extends StatefulWidget {
  const CategoryApartmentPage({Key? key}) : super(key: key);

  @override
  _CategoryApartmentPageState createState() => _CategoryApartmentPageState();
}

class _CategoryApartmentPageState extends State<CategoryApartmentPage> {

  CategoryApartmentFB categoryApartmentFB = new CategoryApartmentFB();

  bool _isAdd = true;

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();

  void binding(QueryDocumentSnapshot x) {
    _idController.text = x["id"];
    _nameController.text = x["name"];
    _areaController.text = x["area"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loại căn hộ"),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: StreamBuilder(
                        stream: categoryApartmentFB.collectionReference.snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: Text("No Data"),);
                          }
                          else {
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context,i) {
                                  QueryDocumentSnapshot x = snapshot.data!.docs[i];
                                  // return Card(
                                  //   color: Colors.white70,
                                  //   elevation: 1,
                                  //   child: ListTile(
                                  //     onTap: () {
                                  //       Navigator.push(context, MaterialPageRoute(builder: (context) => EditCategoryApartmentPage(x['id'])));
                                  //     },
                                  //     title: Text(x['name'], style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                  //   ),
                                  // );
                                  return CategoryApartmentCard();
                                }
                            );
                          }
                        }
                    )
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Builder(
        builder: (BuildContext context) {
          return FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddCategoryApartmentPage()));
            },
            label: Text("Thêm loại"),
          );
        },
      ),
    );
  }

  void _showOptionPanel() =>
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        context: context,
        builder: (context) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Text("Thông tin loại phòng", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
                SizedBox(height: 15,),
                Row(
                  children: [
                    Text(
                      "Loại căn hộ: ",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      _nameController.text,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text(
                      "Diện tích: ",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      _areaController.text + "m2",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text(
                      "Số người: ",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      "đang cập nhật...",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text(
                      "Dịch vụ: ",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      "đang cập nhật...",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 15,),
                Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: FlatButton(
                    onPressed: () {
                      _isAdd = false;
                      Navigator.pop(context);
                      _showAddOrEditDialog();
                    },
                    child: Text(
                      "Sửa",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10.0)
                ),
                child: FlatButton(
                  onPressed: () {
                    _deleteCategory();
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Xóa",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                ),
              ),
              ],
            ),
          ),
        )
      );


  void _deleteCategory() {
    categoryApartmentFB.delete(_idController.text);
  }

  void _showAddOrEditDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Wrap(
                runSpacing: 10,
                children: <Widget>[
                  Text(
                    _isAdd ? "Thêm loại căn hộ" : "Chi tiết loại căn hộ",
                    style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Vui lòng nhập tên loại căn hộ";
                      }
                      return null;
                    },
                    controller: _nameController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.home_sharp),
                        hintText: 'Tên loại',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )
                    ),
                  ),
                  TextFormField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Vui lòng nhập diện tích căn hộ";
                      }
                      return null;
                    },
                    controller: _areaController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.crop_square_outlined),
                        hintText: 'Diện tích',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )
                    ),
                  ),
                  MainButton(
                    name: _isAdd ? "Thêm" : "Sửa",
                    onpressed: () {
                      //_editCategory();
                    },
                  )
                ],
              )
            ),
          );
        }
    );
  }

}
