import 'package:cloud_firestore/cloud_firestore.dart';

class WE {
  String? startE;
  String? endE;
  String? chargeE;
  String? totalE;
  String? startW;
  String? endW;
  String? chargeW;
  String? totalW;
  String? totalWE;
  String? chargeRoom;
  String? deposit;
  String? startDay;
  String? type;
  WE(
      {this.startE,
      this.endE,
      this.chargeE,
      this.totalE,
      this.startW,
      this.endW,
      this.chargeW,
      this.totalW,
      this.totalWE,
      this.chargeRoom,
      this.deposit,
      this.startDay,
      this.type});
}
