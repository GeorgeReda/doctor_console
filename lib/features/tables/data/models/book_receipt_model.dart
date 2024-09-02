import 'package:doctor_console/features/tables/domain/entities/book_receipt.dart';

class BookReceiptModel extends BookReceipt {
  const BookReceiptModel(
      {required super.name,
      required super.address,
      required super.phone,
      required super.secondPhone,
      required super.book1,
      required super.book2,
      required super.book3,
      required super.book4,
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
      book1: json['book1'],
      book2: json['book2'],
      book3: json['book3'],
      book4: json['book4'],
      status: json['status'],
      referenceNumber: json['referenceNumber'],
      paidAt: DateTime.parse(json['paidAt']),
      amount: json['amount'],
    );
  }
}
