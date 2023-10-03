import 'package:doctor_console/core/constants/enums.dart';
import 'package:doctor_console/features/tables/domain/usecases/mark_as_renewed.dart';
import 'package:doctor_console/features/tables/presentation/cubits/mark_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Marks a receipt as renewed
class MarkButton extends StatelessWidget {
  const MarkButton(
      {super.key,
      required this.id,
      required this.paymentMethod,
      required this.isEnabled});
  final String id;
  final PaymentMethod paymentMethod;
  final bool isEnabled;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: isEnabled
            ? () => context.read<MarkCubit>().markAsRenewed(
                MarkAsRenewedParams(paymentMethod: paymentMethod, id: id))
            : null,
        icon: const Icon(Icons.check));
  }
}
