import 'package:appwrite/appwrite.dart';
import 'package:dartz/dartz.dart';

import 'package:doctor_console/core/errors/failures.dart';
import 'package:doctor_console/core/network/network_info.dart';

import '../../domain/repositories/login_repository.dart';
import '../datasources/login_remote_data_source.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  LoginRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Unit>> login(String username, String password) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteOldSession();
        final user = await remoteDataSource.login(username, password);
        return Right(user);
      } on AppwriteException catch (e) {
        return Left(
          AppwriteFailure(message: e.message ?? 'Something went wrong'),
        );
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }
}
