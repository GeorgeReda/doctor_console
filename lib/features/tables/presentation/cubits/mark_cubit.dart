import 'package:doctor_console/core/errors/failures.dart';
import 'package:doctor_console/features/tables/domain/usecases/mark_as_renewed.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'mark_state.dart';

class MarkCubit extends Cubit<MarkState> {
  MarkCubit(this.markAsRenewedUseCase) : super(MarkInitial());

  final MarkAsRenewed markAsRenewedUseCase;

  Future<void> markAsRenewed(MarkAsRenewedParams params) async {
    emit(MarkLoading());
    final failureOrUnit = await markAsRenewedUseCase(params);
    failureOrUnit.fold(
      (failure) => emit(MarkError(
          message: failure is AppwriteFailure
              ? failure.message
              : failure.toString())),
      (_) => emit(MarkSuccess(id: params.id)),
    );
    emit(MarkInitial());
  }
}
