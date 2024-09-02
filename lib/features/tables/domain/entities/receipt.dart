import 'package:doctor_console/core/constants/enums.dart';
import 'package:equatable/equatable.dart';

class Receipt extends Equatable {
  final String id, name, phone;
  final List<Months> months;
  final Year year;
  final bool isRenewed, isRefunded;
  final double amount;

  const Receipt({
    required this.id,
    required this.name,
    required this.phone,
    required this.year,
    required this.months,
    required this.amount,
    required this.isRenewed,
    required this.isRefunded,
  });

  @override
  List<Object?> get props => [id, name, phone, year, months, amount, isRenewed];
}
