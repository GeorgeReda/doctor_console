import 'package:dartz/dartz.dart';
import 'package:doctor_console/core/constants/enums.dart';
import 'package:doctor_console/core/errors/failures.dart';
import 'package:doctor_console/core/usecases/usecase.dart';
import 'package:doctor_console/features/tables/domain/repositories/tables_repository.dart';
import 'package:equatable/equatable.dart';

import '../entities/fawry_response.dart';

class GetTables extends UseCase<FawryResponse, GetTablesParams> {
  final TablesRepository repository;

  GetTables(this.repository);

  @override
  Future<Either<Failure, FawryResponse>> call(GetTablesParams params) async {
    return await repository.getTables(params);
  }
}

class GetTablesParams extends Equatable {
  final bool? isRenewed;
  final DateTime? day;
  final Year year;
  final String query;

  const GetTablesParams(
      {this.isRenewed,
      this.year = Year.none,
      required this.day,
      required this.query});
  @override
  List<Object> get props => [year, query];
}
