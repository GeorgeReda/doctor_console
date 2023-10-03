import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_console/features/tables/presentation/cubits/mark_cubit.dart';
import 'package:doctor_console/features/tables/presentation/cubits/tables_cubit.dart';
import 'package:doctor_console/features/tables/presentation/widgets/filter_row.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../widgets/receipts_table.dart';

class TablesScreen extends StatelessWidget {
  const TablesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<MarkCubit, MarkState>(
        listener: (context, state) {
          if (state is MarkLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => Dialog(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  child: Center(
                      child: LoadingAnimationWidget.beat(
                          color: context.primaryColor, size: 50.0))),
            );
          } else if (state is MarkSuccess) {
            context.read<TablesCubit>().markAsRenewed(state.id);
            //remove the circular progress indicator
            context.pop();
            Fluttertoast.showToast(
              msg: 'تم التجديد بنجاح !',
              webPosition: 'center',
              webBgColor: context.primaryColor.hex,
              toastLength: Toast.LENGTH_LONG,
            );
          } else if (state is MarkError) {
            //remove the circular progress indicator
            context.pop();
            Fluttertoast.showToast(
              msg: state.message,
              webPosition: 'center',
              webBgColor: context.primaryColor.hex,
              toastLength: Toast.LENGTH_LONG,
            );
          }
        },
        child: ListView(
          children: [
            SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'تجديد الشهر',
                      style: context.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(child: Image.asset("assets/logo.png")),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const FiltersRow(),
            const SizedBox(height: 20),
            const ReceiptsTable(),
          ],
        ),
      ),
    );
  }
}
