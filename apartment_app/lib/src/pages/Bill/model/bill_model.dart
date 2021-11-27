import 'package:cloud_firestore/cloud_firestore.dart';

class BillModel {
  final String? id;
  final String? idRoom;
  final String? billDate;
  final String? monthBill;
  final String? yearBill;
  final String? paymentTerm;
  final String? deposit;
  final String? discount;
  final String? fine;
  final String? note;
  final String? roomCharge;
  final String? serviceFee;
  final String? status;
  final String? startE;
  final String? endE;
  final String? chargeE;
  final String? totalE;
  final String? startW;
  final String? endW;
  final String? chargeW;
  final String? totalW;
  final String? total;
  final String? startBill;
  final String? endBill;
  final String? idContract;

  const BillModel(
      {this.id,
      this.idRoom,
      this.billDate,
      this.monthBill,
      this.yearBill,
      this.paymentTerm,
      this.deposit,
      this.discount,
      this.fine,
      this.note,
      this.roomCharge,
      this.serviceFee,
      this.status,
      this.startE,
      this.endE,
      this.chargeE,
      this.totalE,
      this.startW,
      this.endW,
      this.chargeW,
      this.totalW,
      this.total,
      this.startBill,
      this.endBill,
      this.idContract});
  factory BillModel.fromDocument(DocumentSnapshot doc) {
    return BillModel(
      id: doc["idBillInfo"],
      idRoom: doc["idRoom"],
      billDate: doc["billDate"],
      monthBill: doc["monthBill"],
      yearBill: doc["yearBill"],
      paymentTerm: doc["paymentTerm"],
      deposit: doc["deposit"],
      discount: doc["discount"],
      fine: doc["fine"],
      note: doc["note"],
      roomCharge: doc["roomCharge"],
      serviceFee: doc["serviceFee"],
      status: doc["status"],
      startE: doc["startE"],
      endE: doc["endE"],
      chargeE: doc["chargeE"],
      totalE: doc["totalE"],
      startW: doc["startW"],
      endW: doc["endW"],
      chargeW: doc["chargeW"],
      totalW: doc["totalW"],
      total: doc["total"],
      startBill: doc["startBill"],
      endBill: doc["endBill"],
      idContract: doc["idContract"],
    );
  }
}
