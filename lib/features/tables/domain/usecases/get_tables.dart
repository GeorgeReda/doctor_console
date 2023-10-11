import 'package:dartz/dartz.dart';
import 'package:doctor_console/core/constants/enums.dart';
import 'package:doctor_console/core/errors/failures.dart';
import 'package:doctor_console/core/usecases/usecase.dart';
import 'package:doctor_console/features/tables/domain/entities/receipt.dart';
import 'package:doctor_console/features/tables/domain/repositories/tables_repository.dart';
import 'package:equatable/equatable.dart';

class GetTables extends UseCase<List<Receipt>, GetTablesParams> {
  final TablesRepository repository;

  GetTables(this.repository);

  @override
  Future<Either<Failure, List<Receipt>>> call(GetTablesParams params) async {
    return await repository.getTables(params);
  }
}

class GetTablesParams extends Equatable {
  final PaymentMethod paymentMethod;
  final String? phoneReceived;
  final bool? isUsed, isRenewed;
  final DateTime day;
  final Year year;

  const GetTablesParams(
      {required this.paymentMethod,
      this.phoneReceived,
      this.isUsed = true,
      this.isRenewed = false,
      required this.year,
      required this.day});
  @override
  List<Object> get props => [
        paymentMethod,
        day,
      ];
}
