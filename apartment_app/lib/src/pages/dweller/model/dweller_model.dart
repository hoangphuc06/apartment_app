import 'package:cloud_firestore/cloud_firestore.dart';

class Dweller {

  String? id;
  String? idApartment;
  String? name;
  String? birthday;
  String? gender;
  String? cmnd;
  String? phoneNumber;
  String? email;
  String? homeTown;
  String? job;
  String? role;

  Dweller({this.id, this.idApartment, this.name, this.birthday, this.gender,
      this.cmnd, this.homeTown, this.job, this.role, this.phoneNumber, this.email});

  factory Dweller.fromDocument(DocumentSnapshot doc) {
    return Dweller(
      id: doc["id"],
      idApartment: doc["idApartment"],
      name: doc['name'],
      birthday: doc['birthday'],
      gender: doc['gender'],
      cmnd: doc['cmnd'],
      phoneNumber: doc['phoneNumber'],
      email: doc['email'],
      homeTown: doc['homeTown'],
      job: doc["job"],
      role: doc["role"],
    );
  }
}