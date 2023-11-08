import 'package:equatable/equatable.dart';

class BookReceipt extends Equatable {
  final String name, address, phone, secondPhone, status, referenceNumber;
  final List<int> booksNeeded;
  final DateTime? paidAt;
  final double amount;

  const BookReceipt(
      {required this.name,
      required this.address,
      required this.phone,
      required this.secondPhone,
      required this.booksNeeded,
      required this.status,
      required this.referenceNumber,
      required this.paidAt,
      required this.amount});

  @override
  List<Object?> get props => [
        name,
        address,
        phone,
        secondPhone,
        booksNeeded,
        status,
        referenceNumber,
        paidAt,
        amount
      ];
}
