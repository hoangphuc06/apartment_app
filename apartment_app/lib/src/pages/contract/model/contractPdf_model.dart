import 'package:apartment_app/src/pages/contract/model/contract_model.dart';
import 'package:apartment_app/src/pages/contract/model/owner_model.dart';
import 'package:apartment_app/src/pages/contract/model/renter_model.dart';

class ContractPdfModel {
  final Contract contract;
  final RenterModel renterModel;
  final OwnerModel ownerModel;

  const ContractPdfModel({
    required this.contract,
    required this.renterModel,
    required this.ownerModel,
  });
}
