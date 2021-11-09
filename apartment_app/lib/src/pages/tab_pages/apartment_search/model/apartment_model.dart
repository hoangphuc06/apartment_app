import 'package:apartment_app/src/fire_base/fb_floor_info.dart';
import 'package:apartment_app/src/pages/category_apartment/firebase/fb_category_apartment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:apartment_app/src/pages/category_apartment/model/category_apartment_model.dart';
import 'package:flutter/cupertino.dart';

class ApartmentModel {
  CategoryApartmentFB categoryApartmentFB = new CategoryApartmentFB();
  CategoryApartment? category ;
  String? categoryid;
  String? floorid;
  String?id;
  String? note;
  String? numOfDweller;
  String? status;

  Future<void> setInfo() async{
    final ref   =  categoryApartmentFB.collectionReference;
    QuerySnapshot eventsQuery = await ref.where('id',isEqualTo: categoryid.toString()).get();
    if(eventsQuery.docs.isNotEmpty){
       final doc =eventsQuery.docs.first;
      this.category=CategoryApartment.fromDocument(doc);
    }
  }
  ApartmentModel({
    this.id,
    this.categoryid,
    this.floorid,
    this.note,
    this.status,
    this.numOfDweller,

  });

  // Cần viết
  factory ApartmentModel.fromDocument(DocumentSnapshot doc) {

   final temp=   ApartmentModel(
      id: doc["id"],
      categoryid: doc['categoryid'],
      floorid: doc['floorid'],
      note: doc['note'],
      status: doc['status'],
      numOfDweller: doc['numOfDweller']
    );
   return temp;
  }
}