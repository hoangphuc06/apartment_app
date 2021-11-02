import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/category_apartment/firebase/fb_category_apartment.dart';
import 'package:apartment_app/src/pages/category_apartment/model/category_apartment_model.dart';
import 'package:apartment_app/src/pages/category_apartment/view/add_category_apartment_page.dart';
import 'package:apartment_app/src/pages/category_apartment/view/category_apartment_detail_page.dart';
import 'package:apartment_app/src/widgets/cards/category_apartment_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryApartmentPage extends StatefulWidget {
  const CategoryApartmentPage({Key? key}) : super(key: key);

  @override
  _CategoryApartmentPageState createState() => _CategoryApartmentPageState();
}

class _CategoryApartmentPageState extends State<CategoryApartmentPage> {

  CategoryApartmentFB categoryApartmentFB = new CategoryApartmentFB();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: myGreen,
        elevation: 0,
        centerTitle: true,
        title:  Text(
          "Loại căn hộ",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: StreamBuilder(
              stream: categoryApartmentFB.collectionReference.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Text("No Data"));
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, i) {
                        QueryDocumentSnapshot x = snapshot.data!.docs[i];
                        CategoryApartment categoryApartment = CategoryApartment.fromDocument(x);
                        return CategoryApartmentCard(
                          categoryApartment: categoryApartment,
                          funtion: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CategotyApartmentDetailPage(categoryApartment: categoryApartment)));
                          },
                        );
                      }
                  );
                }
              }
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: myGreen,
        child: Icon(Icons.add, color: Colors.white,),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddCategoryApartmentPage()));
        }
      ),
    );
  }
}
