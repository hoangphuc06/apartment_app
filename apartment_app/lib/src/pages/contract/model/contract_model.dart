import 'package:cloud_firestore/cloud_firestore.dart';

class Contract {
  String? id;
  String? host;
  String? room;
  String? startDay;
  String? expirationDate;
  String? billingStartDate;
  String? roomPaymentPeriod;
  String? roomCharge;
  String? deposit;
  String? renter;
  String? rules;
  bool? isVisible;
  Contract({
    this.id,
    this.host,
    this.room,
    this.startDay,
    this.expirationDate,
    this.billingStartDate,
    this.roomPaymentPeriod,
    this.roomCharge,
    this.deposit,
    this.renter,
    this.rules,
    this.isVisible,
  });

  factory Contract.fromDocument(DocumentSnapshot doc) {
    return Contract(
      id: doc["id"],
      host: doc["host"],
      room: doc['room'],
      startDay: doc['startDay'],
      expirationDate: doc['expirationDate'],
      billingStartDate: doc['billingStartDate'],
      roomPaymentPeriod: doc['roomPaymentPeriod'],
      roomCharge: doc['roomCharge'],
      deposit: doc['deposit'],
      renter: doc["renter"],
      rules:  doc["rules"],
      isVisible: doc["isVisible"],
    );
  }
}
