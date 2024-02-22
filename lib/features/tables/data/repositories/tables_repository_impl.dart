import 'package:dartz/dartz.dart';
import 'package:doctor_console/core/errors/failures.dart';
import 'package:doctor_console/core/network/network_info.dart';
import 'package:doctor_console/features/tables/data/datasources/tables_local_data_source.dart';
import 'package:doctor_console/features/tables/domain/entities/book_receipt.dart';
import 'package:doctor_console/features/tables/domain/entities/receipt.dart';
import 'package:doctor_console/features/tables/domain/repositories/tables_repository.dart';
import 'package:doctor_console/features/tables/domain/usecases/get_book_receipts.dart';
import 'package:doctor_console/features/tables/domain/usecases/get_tables.dart';
import 'package:doctor_console/features/tables/domain/usecases/mark_as_renewed.dart';
import 'package:doctor_console/features/tables/domain/usecases/refund.dart';

import '../../domain/entities/fawry_response.dart';
import '../datasources/tables_remote_data_source.dart';

class TablesRepositoryImpl implements TablesRepository {
  final NetworkInfo networkInfo;
  final TablesRemoteDataSource remoteDataSource;
  final TablesLocalDataSource localDataSource;

  TablesRepositoryImpl(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.localDataSource});

  @override
  Future<Either<Failure, FawryResponse>> getTables(
      GetTablesParams params) async {
    if (await networkInfo.isConnected) {
      try {
        FawryResponse receipts = await remoteDataSource.getTables(params);
        return Right(receipts);
      } on Exception catch (e) {
        return Left(
          AppwriteFailure(message: e.toString()),
        );
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> markAsRenewed(
      MarkAsRenewedParams params) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.markAsRenewed(params);
        return const Right(unit);
      } on Exception catch (e) {
        return Left(
          AppwriteFailure(message: e.toString()),
        );
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> refund(RefundParams params) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.refund(params);
        return const Right(unit);
      } on Exception catch (e) {
        return Left(AppwriteFailure(message: e.toString()));
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<Receipt>>> getRenewalReceipts() async {
    if (await networkInfo.isConnected) {
      try {
        List<Receipt> receipts = await remoteDataSource.getRenewalReceipts();
        return Right(receipts);
      } on Exception catch (e) {
        return Left(
          AppwriteFailure(message: e.toString()),
        );
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<BookReceipt>>> getBookReceipts(
      GetBookReceiptsParams params) async {
    if (await networkInfo.isConnected) {
      try {
        List<BookReceipt> receipts =
            await remoteDataSource.getBookReceipts(params);

        await localDataSource.downloadBookExcel(receipts, params.day);
        return Right(receipts);
      } on Exception catch (e) {
        return Left(
          AppwriteFailure(message: e.toString()),
        );
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }
}
