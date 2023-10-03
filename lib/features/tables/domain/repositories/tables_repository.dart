import 'package:dartz/dartz.dart';
import 'package:doctor_console/core/errors/failures.dart';
import 'package:doctor_console/features/tables/domain/entities/receipt.dart';
import 'package:doctor_console/features/tables/domain/usecases/get_tables.dart';
import 'package:doctor_console/features/tables/domain/usecases/mark_as_renewed.dart';

abstract class TablesRepository {
  Future<Either<Failure, List<Receipt>>> getTables(GetTablesParams params);
  Future<Either<Failure, Unit>> markAsRenewed(MarkAsRenewedParams params);
}
