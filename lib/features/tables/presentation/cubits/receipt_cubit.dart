import 'package:doctor_console/core/errors/failures.dart';
import 'package:doctor_console/features/tables/domain/usecases/mark_as_renewed.dart';
import 'package:doctor_console/features/tables/domain/usecases/refund.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'receipt_state.dart';

class ReceiptCubit extends Cubit<MarkState> {
  ReceiptCubit(this.markAsRenewedUseCase, this.refundUseCase)
      : super(ReceiptInitial());

  final MarkAsRenewed markAsRenewedUseCase;
  final Refund refundUseCase;

  Future<void> markAsRenewed(MarkAsRenewedParams params) async {
    emit(ReceiptLoading());
    final failureOrUnit = await markAsRenewedUseCase(params);
    failureOrUnit.fold(
      (failure) => emit(ReceiptError(
          message: failure is AppwriteFailure
              ? failure.message
              : failure.toString())),
      (_) => emit(MarkSuccess(id: params.id)),
    );
    emit(ReceiptInitial());
  }

  Future<void> refund(RefundParams params) async {
    emit(ReceiptLoading());
    final failureOrUnit = await refundUseCase(params);
    failureOrUnit.fold(
      (failure) => emit(ReceiptError(
          message: failure is AppwriteFailure
              ? failure.message
              : failure.toString())),
      (_) => emit(RefundSuccess()),
    );
    emit(ReceiptInitial());
  }
}
