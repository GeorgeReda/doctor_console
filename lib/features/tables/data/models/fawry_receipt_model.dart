import 'package:appwrite/models.dart';
import 'package:doctor_console/core/constants/enums.dart';
import 'package:doctor_console/features/tables/domain/entities/fawry_receipt.dart';

class FawryReciptModel extends FawryReceipt {
  const FawryReciptModel(
      {required super.id,
      required super.name,
      required super.code,
      required super.phone,
      required super.year,
      required super.monthsNeeded,
      required super.amount,
      required super.paidAt,
      required super.status,
      required super.referenceNumber,
      required super.isRenewed,
      required super.isRefunded});

  factory FawryReciptModel.fromJson(Document doc) {
    return FawryReciptModel(
      id: doc.$id,
      name: doc.data['name'],
      code: doc.data['code'],
      phone: doc.data['phone'],
      year:
          Year.values.firstWhere((element) => element.name == doc.data['year']),
      monthsNeeded: Months.values
          .where((element) => doc.data['monthsNeeded'].contains(element.name))
          .toList(),
      amount: doc.data['amount'],
      paidAt: DateTime.parse(doc.data['paidAt']),
      status: doc.data['status'],
      referenceNumber: doc.data['referenceNumber'],
      isRenewed: doc.data['isRenewed'],
      isRefunded: doc.data['isRefunded'],
    );
  }
}
