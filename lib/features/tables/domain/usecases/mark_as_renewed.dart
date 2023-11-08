import 'package:dartz/dartz.dart';
import 'package:doctor_console/core/errors/failures.dart';
import 'package:doctor_console/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';

import '../repositories/tables_repository.dart';

class MarkAsRenewed extends UseCase<Unit, MarkAsRenewedParams> {
  final TablesRepository repository;

  MarkAsRenewed(this.repository);

  @override
  Future<Either<Failure, Unit>> call(MarkAsRenewedParams params) async {
    return await repository.markAsRenewed(params);
  }
}

class MarkAsRenewedParams extends Equatable {
  final String id;

  const MarkAsRenewedParams({required this.id});
  @override
  List<Object> get props => [id];
}
