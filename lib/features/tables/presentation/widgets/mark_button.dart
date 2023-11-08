import 'package:doctor_console/features/tables/presentation/cubits/tables_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Marks a receipt as renewed
class MarkButton extends StatelessWidget {
  const MarkButton({super.key, required this.id, required this.isEnabled});
  final String id;
  final bool isEnabled;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: isEnabled
            ? () => context.read<TablesCubit>().markAsRenewed(id)
            : null,
        icon: const Icon(Icons.check));
  }
}
