import 'package:dartz/dartz.dart';
import 'package:doctor_console/core/errors/failures.dart';
import 'package:doctor_console/features/tables/domain/entities/book_receipt.dart';
import 'package:doctor_console/features/tables/domain/entities/receipt.dart';
import 'package:doctor_console/features/tables/domain/usecases/get_tables.dart';
import 'package:doctor_console/features/tables/domain/usecases/mark_as_renewed.dart';

import '../usecases/get_book_receipts.dart';
import '../usecases/refund.dart';

abstract class TablesRepository {
  Future<Either<Failure, List<Receipt>>> getTables(GetTablesParams params);
  Future<Either<Failure, List<BookReceipt>>> getBookReceipts(
      GetBookReceiptsParams params);
  Future<Either<Failure, List<Receipt>>> getRenewalReceipts();
  Future<Either<Failure, Unit>> markAsRenewed(MarkAsRenewedParams params);
  Future<Either<Failure, Unit>> refund(RefundParams params);
}
