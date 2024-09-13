import 'package:dartz/dartz.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart' as html;

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

    final pdf = pw.Document();

    // for (var receipt in receipts) {
    var receipt = receipts.first;
    final bytes = await rootBundle.load('assets/card.png');
    var template = img.decodeImage(bytes.buffer.asUint8List())!;

    img.drawString(template, receipt.name,
        font: img.arial24, x: 300, y: 85, rightJustify: true);
    final addressWords = receipt.address.split(' ');
    if (addressWords.length > 6) {
      img.drawString(template, addressWords.sublist(0, 6).join(' '),
          font: img.arial24, x: 300, y: 130, rightJustify: true);
      img.drawString(template, addressWords.sublist(6).join(' '),
          font: img.arial24, x: 300, y: 160, rightJustify: true);
    } else {
      img.drawString(template, receipt.address,
          font: img.arial24, x: 300, y: 130, rightJustify: true);
    }
    img.drawString(template, receipt.phone,
        font: img.arial24, x: 300, y: 180, rightJustify: true);
    img.drawString(template, receipt.secondPhone,
        font: img.arial24, x: 300, y: 230, rightJustify: true);
    img.drawString(template, receipt.book1.toString(),
        font: img.arial24, x: 263, y: 50, rightJustify: true);
    img.drawString(template, receipt.book2.toString(),
        font: img.arial24, x: 199, y: 50, rightJustify: true);
    img.drawString(template, receipt.book3.toString(),
        font: img.arial24, x: 134, y: 50, rightJustify: true);
    img.drawString(template, receipt.book4.toString(),
        font: img.arial24, x: 70, y: 50, rightJustify: true);

    final pdfImage = pw.MemoryImage(img.encodePng(template));

    // Add the image to the PDF
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a5.landscape,
        build: (context) {
          return pw.Center(
            child: pw.Image(
              pdfImage,
            ),
          );
        },
      ),
    );
    // }
    // Save the PDF in-memory and trigger download in the browser
    final pdfBytes = await pdf.save();

    // Create a download link and trigger it
    final blob = html.Blob([pdfBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', 'مذكرات.pdf')
      ..click();
    html.Url.revokeObjectUrl(url);
    return unit;
  }
}
