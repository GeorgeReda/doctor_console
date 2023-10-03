import 'package:dartz/dartz.dart';
import 'package:doctor_console/core/errors/failures.dart';

abstract class LoginRepository {
  Future<Either<Failure, Unit>> login(String username, String password);
}
