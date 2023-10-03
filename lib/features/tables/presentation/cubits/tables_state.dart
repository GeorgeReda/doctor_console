part of 'tables_cubit.dart';

abstract class TablesState extends Equatable {
  const TablesState();

  @override
  List<Object> get props => [];
}

class TablesInitial extends TablesState {}

class TablesLoading extends TablesState {}

class TablesSuccess extends TablesState {
  final List<Receipt> receipts;

  const TablesSuccess({required this.receipts});

  @override
  List<Object> get props => [receipts];
}

class TablesError extends TablesState {
  final String message;

  const TablesError({required this.message});

  @override
  List<Object> get props => [message];
}
