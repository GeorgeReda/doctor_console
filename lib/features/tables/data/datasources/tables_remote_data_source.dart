import 'package:appwrite/appwrite.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_console/core/constants/enums.dart';
import 'package:doctor_console/features/tables/data/models/vf_cash_receipt_model.dart';
import 'package:doctor_console/features/tables/domain/entities/receipt.dart';
import 'package:doctor_console/features/tables/domain/usecases/get_tables.dart';

import '../../domain/usecases/mark_as_renewed.dart';

abstract class TablesRemoteDataSource {
  Future<List<Receipt>> getTables(GetTablesParams params);
  Future<Unit> markAsRenewed(MarkAsRenewedParams params);
}

class TablesRemoteDataSourceImpl implements TablesRemoteDataSource {
  final Databases db;

  TablesRemoteDataSourceImpl({required this.db});

  @override
  Future<List<Receipt>> getTables(GetTablesParams params) async {
    try {
      if (params.paymentMethod == PaymentMethod.vodafoneCash) {
        final docs = await db.listDocuments(
            databaseId: 'main',
            collectionId: 'VF-Cash',
            queries: [
              Query.equal('phoneRecieved', params.phoneReceived),
              Query.equal('isUsed', params.isUsed),
              Query.equal('isRenewed', params.isRenewed),
              Query.startsWith('transactionDate',
                  params.day.toIso8601String().split('T')[0]),
              if (params.year != Year.none)
                Query.equal('year', params.year.name),
            ]);

        return docs.documents
            .map((doc) => VFCashReceiptModel.fromJson(doc))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> markAsRenewed(MarkAsRenewedParams params) async {
    try {
      if (params.paymentMethod == PaymentMethod.vodafoneCash) {
        await db.updateDocument(
            databaseId: 'main',
            collectionId: 'VF-Cash',
            documentId: params.id,
            data: {
              'isRenewed': true,
            });
      } else {
        // TODO implement fawry
      }
      return unit;
    } catch (e) {
      rethrow;
    }
  }
}
