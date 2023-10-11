import 'package:doctor_console/core/constants/enums.dart';
import 'package:equatable/equatable.dart';

class Receipt extends Equatable {
  final String id, name, code, phone;
  final List<Months> monthsNeeded;
  final Year year;

  const Receipt({
    required this.id,
    required this.name,
    required this.code,
    required this.phone,
    required this.year,
    required this.monthsNeeded,
  });

  @override
  List<Object?> get props => [id, name, code, phone,year, monthsNeeded];
}
