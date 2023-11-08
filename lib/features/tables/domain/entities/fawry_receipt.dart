import 'receipt.dart';

class FawryReceipt extends Receipt {
  const FawryReceipt({
    required super.id,
    required super.name,
    required super.code,
    required super.phone,
    required super.year,
    required super.monthsNeeded,
    required super.amount,
    required super.isRenewed,
    required super.isRefunded,
    required this.paidAt,
    required this.status,
    required this.referenceNumber,
  });

  final DateTime? paidAt;
  final String status;
  final String referenceNumber;
}
