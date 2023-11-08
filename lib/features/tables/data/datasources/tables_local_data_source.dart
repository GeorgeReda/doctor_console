import 'package:dartz/dartz.dart';
import 'package:excel/excel.dart';

import 'package:doctor_console/core/constants/enums.dart';

import '../../domain/entities/book_receipt.dart';

abstract class TablesLocalDataSource {
  Future<Unit> downloadBookExcel(List<BookReceipt> receipts, DateTime date);
}

class TablesLocalDataSourceImpl implements TablesLocalDataSource {
  @override
  Future<Unit> downloadBookExcel(
      List<BookReceipt> receipts, DateTime date) async {
    var excel = Excel.createExcel();

    Sheet sheetObject = excel['Sheet1'];

    sheetObject.isRTL = true;

    sheetObject.appendRow([
      'الاسم',
      'العنوان',
      'التليفون',
      'التليفون الثاني',
      for (Books book in Books.values) book.desc,
    ]);

    for (BookReceipt receipt in receipts) {
      sheetObject.appendRow([
        receipt.name,
        receipt.address,
        receipt.phone,
        receipt.secondPhone,
        for (int i in receipt.booksNeeded) i.toString(),
      ]);
    }

    excel.save(
        fileName:
            'مذكرات تاريخ ${date.toIso8601String().split('T').first}.xlsx');

    return unit;
  }
}
