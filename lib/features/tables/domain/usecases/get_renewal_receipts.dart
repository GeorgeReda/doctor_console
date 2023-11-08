import 'package:dartz/dartz.dart';
import 'package:doctor_console/core/errors/failures.dart';
import 'package:doctor_console/core/usecases/usecase.dart';
import 'package:doctor_console/features/tables/domain/entities/receipt.dart';
import 'package:doctor_console/features/tables/domain/repositories/tables_repository.dart';

class GetRenewalReceipts extends UseCase<List<Receipt>, NoParams> {
  final TablesRepository repository;

  GetRenewalReceipts(this.repository);

  @override
  Future<Either<Failure, List<Receipt>>> call(NoParams params) async {
    return await repository.getRenewalReceipts();
  }
}
