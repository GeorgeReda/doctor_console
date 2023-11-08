import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_console/features/tables/domain/entities/book_receipt.dart';
import 'package:doctor_console/features/tables/domain/usecases/get_book_receipts.dart';
import 'package:http/http.dart' as http;

import 'package:doctor_console/core/constants/enums.dart';
import 'package:doctor_console/features/tables/data/models/fawry_receipt_model.dart';
import 'package:doctor_console/features/tables/domain/entities/receipt.dart';
import 'package:doctor_console/features/tables/domain/usecases/get_tables.dart';

import '../../domain/usecases/mark_as_renewed.dart';
import '../../domain/usecases/refund.dart';
import '../models/book_receipt_model.dart';

abstract class TablesRemoteDataSource {
  Future<List<Receipt>> getTables(GetTablesParams params);
  Future<List<Receipt>> getRenewalReceipts();
  Future<List<BookReceipt>> getBookReceipts(GetBookReceiptsParams params);
  Future<Unit> markAsRenewed(MarkAsRenewedParams params);
  Future<Unit> refund(RefundParams params);
}

class TablesRemoteDataSourceImpl implements TablesRemoteDataSource {
  final Databases db;

  TablesRemoteDataSourceImpl({required this.db});

  @override
  Future<List<Receipt>> getTables(GetTablesParams params) async {
    try {
      final docs = await db
          .listDocuments(databaseId: 'main', collectionId: 'Fawry', queries: [
        Query.startsWith('paidAt', params.day.toIso8601String().split('T')[0]),
        if (params.year != Year.none) Query.equal('year', params.year.name),
        if (params.isRenewed != null)
          Query.equal('isRenewed', params.isRenewed),
      ]);

      return docs.documents
          .map((doc) => FawryReciptModel.fromJson(doc))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> markAsRenewed(MarkAsRenewedParams params) async {
    try {
      await db.updateDocument(
          databaseId: 'main',
          collectionId: 'Fawry',
          documentId: params.id,
          data: {
            'isRenewed': true,
          });

      return unit;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> refund(RefundParams params) async {
    try {
      const String merchantCode = '770000016638';

      final response = await http.post(
          Uri.dataFromString(
              'https://www.atfawry.com/ECommerceWeb/Fawry/payments/refund'),
          body: jsonEncode({
            'merchantCode': merchantCode,
            'referenceNumber': params.refundReceipt.referenceNumber,
            'refundAmount': params.refundReceipt.amount,
            'signature': sha256
                .convert(utf8.encode(
                    '$merchantCode${params.refundReceipt.referenceNumber}${params.refundReceipt.amount}c550be95-8aa2-4433-a882-85ffe4ca8b05'))
                .toString(),
          }),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          });

      if (response.statusCode == 200) {
        // update DB
        await db.updateDocument(
            databaseId: 'main',
            collectionId: 'renewal',
            documentId: params.refundReceipt.id,
            data: {'isRefunded': true, 'status': 'REFUNDED'});
        throw AppwriteException('Refund failed');
      }
      return unit;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Receipt>> getRenewalReceipts() async {
    try {
      final docs = await db.listDocuments(
          databaseId: 'main',
          collectionId: 'renewal',
          queries: [
            Query.equal('isRenewed', false),
            Query.isNotNull('paidAt'),
            Query.limit(5)
          ]);

      for (var doc in docs.documents) {
        await markAsRenewed(MarkAsRenewedParams(id: doc.$id));
      }

      return docs.documents
          .map((doc) => FawryReciptModel.fromJson(doc))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<BookReceipt>> getBookReceipts(
      GetBookReceiptsParams params) async {
    try {
      final docs = await db
          .listDocuments(databaseId: 'main', collectionId: 'books', queries: [
        Query.startsWith('paidAt', params.day.toIso8601String().split('T')[0]),
      ]);

      return docs.documents
          .map((doc) => BookReceiptModel.fromJson(doc.data))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
