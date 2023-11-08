import 'package:dartz/dartz.dart';
import 'package:doctor_console/core/errors/failures.dart';
import 'package:doctor_console/core/usecases/usecase.dart';
import 'package:doctor_console/features/tables/domain/entities/fawry_receipt.dart';
import 'package:equatable/equatable.dart';

import '../repositories/tables_repository.dart';

class Refund extends UseCase<Unit, RefundParams> {
  final TablesRepository repository;

  Refund(this.repository);

  @override
  Future<Either<Failure, Unit>> call(RefundParams params) async {
    return await repository.refund(params);
  }
}

class RefundParams extends Equatable {
  final FawryReceipt refundReceipt;

  const RefundParams({required this.refundReceipt});
  @override
  List<Object> get props => [refundReceipt];
}
