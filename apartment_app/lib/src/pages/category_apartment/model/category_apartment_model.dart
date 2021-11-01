
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryApartment {
  String? id;
  String? name;
  String? area;
  String? amountBedroom;
  String? amountWc;
  String? amountDweller;
  String? maxPrice;
  String? minPrice;
  String? maxRentalPrice;
  String? minRentalPrice;

  CategoryApartment({
    this.id,
    this.name,
    this.area,
    this.amountBedroom,
    this.amountWc,
    this.amountDweller,
    this.maxPrice,
    this.minPrice,
    this.maxRentalPrice,
    this.minRentalPrice
  });

  // Không cần viết
  CategoryApartment.fromJson(Map<String, Object?> json)
      : this(
    id: json['id']! as String,
    name: json['name']! as String,
    area: json['area']! as String,
    amountBedroom: json['amountBedroom']! as String,
    amountWc: json['amountWc']! as String,
    amountDweller: json['amountDweller']! as String,
    maxPrice: json['maxPrice']! as String,
    minPrice: json['minPrice']! as String,
    maxRentalPrice: json['maxRentalPrice']! as String,
    minRentalPrice: json['minRentalPrice']! as String,
  );

  // Không cần viết
  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'area': area,
      'amountBedroom': amountBedroom,
      'amountWc': amountWc,
      'amountDweller': amountDweller,
      'maxPrice': maxPrice,
      'minPrice': minPrice,
      'maxRentalPrice': maxRentalPrice,
      'minRentalPrice': minRentalPrice,
    };
  }

  // Cần viết
  factory CategoryApartment.fromDocument(DocumentSnapshot doc) {
    return CategoryApartment(
      id: doc["id"],
      name: doc['name'],
      area: doc['area'],
      amountBedroom: doc['amountBedroom'],
      amountWc: doc['amountWc'],
      amountDweller: doc['amountDweller'],
      maxPrice: doc['maxPrice'],
      minPrice: doc['minPrice'],
      maxRentalPrice: doc['maxRentalPrice'],
      minRentalPrice: doc['minRentalPrice'],
    );
  }
}