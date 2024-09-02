import 'package:appwrite/appwrite.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_console/features/tables/domain/entities/book_receipt.dart';
import 'package:doctor_console/features/tables/domain/entities/fawry_response.dart';
import 'package:doctor_console/features/tables/domain/usecases/get_book_receipts.dart';

import 'package:doctor_console/core/constants/enums.dart';
import 'package:doctor_console/features/tables/data/models/fawry_receipt_model.dart';
import 'package:doctor_console/features/tables/domain/entities/receipt.dart';
import 'package:doctor_console/features/tables/domain/usecases/get_tables.dart';

import '../../domain/usecases/mark_as_renewed.dart';
import '../../domain/usecases/refund.dart';
import '../models/book_receipt_model.dart';

abstract class TablesRemoteDataSource {
  Future<FawryResponse> getTables(GetTablesParams params);
  Future<List<Receipt>> getRenewalReceipts();
  Future<List<BookReceipt>> getBookReceipts(GetBookReceiptsParams params);
  Future<Unit> markAsRenewed(MarkAsRenewedParams params);
  Future<Unit> refund(RefundParams params);
}

class TablesRemoteDataSourceImpl implements TablesRemoteDataSource {
  final Databases db;

  TablesRemoteDataSourceImpl({required this.db});

  @override
  Future<FawryResponse> getTables(GetTablesParams params) async {
    try {
      var queries2 = [
        if (params.day != null)
          Query.startsWith(
              'paidAt', params.day!.toIso8601String().split('T')[0]),
        if (params.day == null) Query.isNotNull('paidAt'),
        if (params.year != Year.none) Query.equal('year', params.year.name),
        if (params.isRenewed != null)
          Query.equal('isRenewed', params.isRenewed),
        if (!params.query.isNumericOnly && params.query.isNotEmpty)
          Query.startsWith('name', params.query),
        if (params.query.isNumericOnly)
          Query.startsWith(
              params.query.startsWith('01') ? 'phone' : 'code', params.query),
      ];

      final docs = await db.listDocuments(
          databaseId: 'main', collectionId: 'receipts', queries: queries2);

      return FawryResponse(
          receipts: docs.documents
              .map((doc) => FawryReciptModel.fromJson(doc))
              .toList(),
          total: docs.total);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> markAsRenewed(MarkAsRenewedParams params) async {
    try {
      await db.updateDocument(
          databaseId: 'main',
          collectionId: 'receipts',
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
          collectionId: 'receipts',
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
      final docs = await db.listDocuments(
          databaseId: 'main',
          collectionId: '66af6a07000ef3c8b648',
          queries: [
            Query.startsWith(
                'paidAt', params.day.toIso8601String().split('T')[0]),
            Query.limit(1000)
          ]);

      return docs.documents
          .map((doc) => BookReceiptModel.fromJson(doc.data))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
