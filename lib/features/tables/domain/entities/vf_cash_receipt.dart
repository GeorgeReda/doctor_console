import 'package:doctor_console/features/tables/domain/entities/receipt.dart';

class VFCashReceipt extends Receipt {
  final String transactionId, phoneSent, phoneRecieved;
  final double amount;
  final bool isUsed, isRenewed;
  final DateTime transactionDate, usedAt;

  const VFCashReceipt(
      {required super.id,
      required super.name,
      required super.code,
      required super.phone,
      required this.transactionId,
      required this.phoneSent,
      required this.phoneRecieved,
      required this.amount,
      required this.isUsed,
      required this.isRenewed,
      required this.transactionDate,
      required this.usedAt});

  @override
  List<Object?> get props => [
        id,
        name,
        code,
        phone,
        transactionId,
        phoneSent,
        phoneRecieved,
        amount,
        isUsed,
        isRenewed,
        transactionDate,
        usedAt
      ];
}
