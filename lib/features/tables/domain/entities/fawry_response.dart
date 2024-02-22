import 'package:doctor_console/features/tables/domain/entities/receipt.dart';
import 'package:equatable/equatable.dart';

class FawryResponse extends Equatable {
  final List<Receipt> receipts;
  final int total;

  const FawryResponse({required this.receipts, required this.total});

  @override
  List<Object?> get props => [receipts, total];
}
