import 'package:doctor_console/features/tables/domain/entities/fawry_receipt.dart';
import 'package:doctor_console/features/tables/presentation/cubits/receipt_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/refund.dart';

class RefundButton extends StatelessWidget {
  const RefundButton({super.key, required this.receipt});
  final FawryReceipt receipt;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        label: const Text('استرجاع'),
        onPressed: receipt.isRefunded
            ? null
            : () => context
                .read<ReceiptCubit>()
                .refund(RefundParams(refundReceipt: receipt)),
        icon: const Icon(Icons.replay));
  }
}
