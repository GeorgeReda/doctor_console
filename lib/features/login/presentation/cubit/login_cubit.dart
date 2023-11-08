import 'package:appwrite/models.dart';
import 'package:doctor_console/core/errors/failures.dart';
import 'package:doctor_console/features/login/domain/usecases/login.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginUsecase) : super(LoginInitial());

  final Login loginUsecase;

  login(String username, String password) async {
    emit(LoginLoading());
    final result =
        await loginUsecase(LoginParams(username: username, password: password));
    result.fold(
      (failure) => emit(LoginError(
          failure is AppwriteFailure ? failure.message : failure.toString())),
      (user) => emit(LoginSuccess(user: user)),
    );
  }
}
