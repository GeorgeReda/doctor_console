import 'package:dartz/dartz.dart';
import 'package:doctor_console/core/errors/failures.dart';
import 'package:doctor_console/core/usecases/usecase.dart';
import 'package:doctor_console/features/tables/domain/entities/book_receipt.dart';
import 'package:doctor_console/features/tables/domain/repositories/tables_repository.dart';
import 'package:equatable/equatable.dart';

class GetBookReceipts extends UseCase<List<BookReceipt>, GetBookReceiptsParams> {
  final TablesRepository repository;

  GetBookReceipts(this.repository);

  @override
  Future<Either<Failure, List<BookReceipt>>> call(GetBookReceiptsParams params) async {
    return await repository.getBookReceipts(params);
  }
}

class GetBookReceiptsParams extends Equatable {
  final DateTime day;

  const GetBookReceiptsParams({required this.day});
  @override
  List<Object> get props => [day];
}
