part of 'receipt_cubit.dart';

sealed class MarkState extends Equatable {
  const MarkState();

  @override
  List<Object> get props => [];
}

final class ReceiptInitial extends MarkState {}

final class ReceiptLoading extends MarkState {}

final class MarkSuccess extends MarkState {
  final String id;

  const MarkSuccess({required this.id});
}

final class RefundSuccess extends MarkState {}

final class ReceiptError extends MarkState {
  final String message;

  const ReceiptError({required this.message});

  @override
  List<Object> get props => [message];
}
