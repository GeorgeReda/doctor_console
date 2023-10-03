import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  // If the subclasses have some properties, they'll get passed to this constructor
  // so that Equatable can perform value comparison.
  const Failure([List properties = const <dynamic>[]]) : super();
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class DeviceOfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class AppwriteFailure extends Failure {
  final String message;

  const AppwriteFailure({required this.message});
  @override
  List<Object?> get props => [message];
}
