import 'package:equatable/equatable.dart';

class Receipt extends Equatable {
  final String id, name, code, phone;

  const Receipt(
      {required this.id,
      required this.name,
      required this.code,
      required this.phone});

  @override
  List<Object?> get props => [id, name, code, phone];
}
