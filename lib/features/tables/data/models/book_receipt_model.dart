import 'package:doctor_console/features/tables/domain/entities/book_receipt.dart';

class BookReceiptModel extends BookReceipt {
  const BookReceiptModel(
      {required super.name,
      required super.address,
      required super.phone,
      required super.secondPhone,
      required super.booksNeeded,
      required super.status,
      required super.referenceNumber,
      required super.paidAt,
      required super.amount});

  factory BookReceiptModel.fromJson(Map<String, dynamic> json) {
    return BookReceiptModel(
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      secondPhone: json['secondPhone'],
      booksNeeded: json['booksNeeded'].cast<int>(),
      status: json['status'],
      referenceNumber: json['referenceNumber'],
      paidAt: DateTime.parse(json['paidAt']),
      amount: json['amount'],
    );
  }
}
