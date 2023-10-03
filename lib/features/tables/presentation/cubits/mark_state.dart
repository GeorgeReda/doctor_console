part of 'mark_cubit.dart';

sealed class MarkState extends Equatable {
  const MarkState();

  @override
  List<Object> get props => [];
}

final class MarkInitial extends MarkState {}

final class MarkLoading extends MarkState {}

final class MarkSuccess extends MarkState {
  final String id;

  const MarkSuccess({required this.id});
}

final class MarkError extends MarkState {
  final String message;

  const MarkError({required this.message});

  @override
  List<Object> get props => [message];
}
