import 'package:cloud_firestore/cloud_firestore.dart';

class RenterModel {
  final String? name;
  final String? address;
  final String? birthday;
  final String? cmnd;
  final String? email;
  final String? gender;
  final String? job;
  final String? phoneNumber;

  const RenterModel({
    this.name,
    this.address,
    this.birthday,
    this.cmnd,
    this.email,
    this.gender,
    this.job,
    this.phoneNumber,
  });
  factory RenterModel.fromDocument(DocumentSnapshot doc) {
    return RenterModel(
      name: doc["name"],
      address: doc["homeTown"],
      birthday: doc['birthday'],
      cmnd: doc['cmnd'],
      email: doc['email'],
      gender: doc['gender'],
      job: doc['job'],
      phoneNumber: doc['phoneNumber'],
    );
  }
}
