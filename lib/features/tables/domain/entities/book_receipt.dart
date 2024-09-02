import 'package:equatable/equatable.dart';

class BookReceipt extends Equatable {
  final String name, address, phone, secondPhone, status, referenceNumber;
  final int book1, book2, book3, book4;
  final DateTime? paidAt;
  final double amount;

  const BookReceipt(
      {required this.name,
      required this.address,
      required this.phone,
      required this.secondPhone,
      required this.book1,
      required this.book2,
      required this.book3,
      required this.book4,
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
        book1,
        book2,
        book3,
        book4,
        status,
        referenceNumber,
        paidAt,
        amount
      ];
}
