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
      TextCellValue('الاسم'),
      TextCellValue('العنوان'),
      TextCellValue('التليفون'),
      TextCellValue('التليفون الثاني'),
      for (Books book in Books.values) TextCellValue(book.desc),
    ]);

    for (BookReceipt receipt in receipts) {
      sheetObject.appendRow([
        TextCellValue(receipt.name),
        TextCellValue(receipt.address),
        TextCellValue(receipt.phone),
        TextCellValue(receipt.secondPhone),
        IntCellValue(receipt.book1),
        IntCellValue(receipt.book2),
        IntCellValue(receipt.book3),
        IntCellValue(receipt.book4),
      ]);
    }

    excel.save(
        fileName:
            'مذكرات تاريخ ${date.toIso8601String().split('T').first}.xlsx');

    return unit;
  }
}
