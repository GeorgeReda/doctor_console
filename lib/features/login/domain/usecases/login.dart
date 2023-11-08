import 'package:appwrite/models.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_console/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/login_repository.dart';

class Login extends UseCase<User, LoginParams> {
  final LoginRepository loginRepository;

  Login(this.loginRepository);

  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    return await loginRepository.login(params.username, params.password);
  }
}

class LoginParams extends Equatable {
  final String username, password;

  const LoginParams({required this.username, required this.password});

  @override
  List<Object?> get props => [username, password];
}
