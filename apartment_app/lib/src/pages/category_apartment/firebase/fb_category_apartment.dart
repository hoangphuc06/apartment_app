import 'package:cloud_firestore/cloud_firestore.dart';


class CategoryApartmentFB {

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference collectionReference = FirebaseFirestore.instance.collection("category_apartment");

  Future<void> add(String name, String area, String amountBedroom, String amountWc, String ammountDweller,
      String minPrice, String maxPrice, String minRentalPrice, String maxRentalPrice) async {
    String id = (new DateTime.now().millisecondsSinceEpoch).toString();
    return FirebaseFirestore.instance.collection("category_apartment").doc(id).set({
      "id": id,
      "name": name,
      "area": area,
      "amountBedroom": amountBedroom,
      "amountWc": amountWc,
      "amountDweller": ammountDweller,
      "minPrice": minPrice,
      "maxPrice": maxPrice,
      "minRentalPrice": minRentalPrice,
      "maxRentalPrice": maxRentalPrice,
    })
        .then((value) => print("completed"))
        .catchError((error)=>print("fail"));
  }

  Future<void> update(String id, String name, String area, String amountBedroom, String amountWc, String ammountDweller,
      String minPrice, String maxPrice, String minRentalPrice, String maxRentalPrice) async {
    return FirebaseFirestore.instance.collection("category_apartment").doc(id).update({
      "name": name,
      "area": area,
      "amountBedroom": amountBedroom,
      "amountWc": amountWc,
      "amountDweller": ammountDweller,
      "minPrice": minPrice,
      "maxPrice": maxPrice,
      "minRentalPrice": minRentalPrice,
      "maxRentalPrice": maxRentalPrice,
    })
        .then((value) => print("completed"))
        .catchError((error)=>print("fail"));
  }

  Future<void> delete(String id) async {
    return FirebaseFirestore.instance.collection("category_apartment").doc(id).delete();
  }

}