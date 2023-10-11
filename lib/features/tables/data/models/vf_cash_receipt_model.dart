import 'package:appwrite/models.dart';
import 'package:doctor_console/core/constants/enums.dart';

import '../../domain/entities/vf_cash_receipt.dart';

class VFCashReceiptModel extends VFCashReceipt {
  const VFCashReceiptModel(
      {required super.id,
      required super.name,
      required super.code,
      required super.phone,
      required super.year,
      required super.monthsNeeded,
      required super.transactionId,
      required super.phoneSent,
      required super.phoneRecieved,
      required super.amount,
      required super.isUsed,
      required super.isRenewed,
      required super.transactionDate,
      required super.usedAt});

  factory VFCashReceiptModel.fromJson(Document doc) {
    return VFCashReceiptModel(
      id: doc.$id,
      name: doc.data['name'] ?? 'Unknown',
      code: doc.data['code'] ?? '---',
      phone: doc.data['phone'] ?? '---',
      year: Year.values
          .firstWhere((element) => element.name == doc.data['year']),
      monthsNeeded: Months.values
          .where((element) => doc.data['monthsNeeded'].contains(element.name))
          .toList(),
      transactionId: doc.data['transactionId'],
      phoneSent: doc.data['phoneSent'],
      phoneRecieved: doc.data['phoneRecieved'],
      amount: doc.data['amount'],
      isUsed: doc.data['isUsed'],
      isRenewed: doc.data['isRenewed'],
      transactionDate: DateTime.parse(doc.data['transactionDate']),
      usedAt: DateTime.parse(doc.data['usedAt'] ?? '2003-05-03'),
    );
  }
}
