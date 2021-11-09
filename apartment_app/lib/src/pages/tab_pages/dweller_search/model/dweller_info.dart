import 'package:apartment_app/src/pages/dweller/firebase/fb_dweller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DwellerModel {
  DwellersFB categoryApartmentFB = new DwellersFB();
  String? cmnd;
  String? birthday;
  String? email;
  String?id;
  String? gender;
  String? hometown;
  String? idApartment;
  String? job;
  String?name;
  String?phone;
  String? role;
  bool check(){
    if(this.name!.isEmpty||this.phone!.isEmpty||this.cmnd!.isEmpty||
        this.birthday!.isEmpty||this.hometown!.isEmpty||this.gender!.isEmpty)
      return false;
    return true;
  }

  DwellerModel({
    this.id,
    this.name,
    this.birthday,
    this.email,
    this.cmnd,
    this.gender,
    this.hometown,
    this.idApartment,
    this.job,
    this.phone,
    this.role
  });

  // Cần viết
  factory DwellerModel.fromDocument(DocumentSnapshot doc) {

    final temp=   DwellerModel(
        id: doc["id"],
        name: doc['name'],
        birthday: doc['birthday'],
        email: doc['email'],
        cmnd: doc['cmnd'],
        role: doc['role'],
        phone: doc['phoneNumber'],
        gender: doc['gender'],
        idApartment: doc['idApartment'],
        hometown: doc['homeTown'],
        job: doc['job']

    );
    return temp;
  }
}