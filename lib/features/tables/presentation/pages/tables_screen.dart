import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_console/features/tables/presentation/cubits/receipt_cubit.dart';
import 'package:doctor_console/features/tables/presentation/cubits/tables_cubit.dart';
import 'package:doctor_console/features/tables/presentation/widgets/fawry_receipts_table.dart';
import 'package:doctor_console/features/tables/presentation/widgets/filter_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TablesScreen extends StatelessWidget {
  TablesScreen({super.key});
  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ReceiptCubit, MarkState>(
        listener: (context, state) {
          if (state is ReceiptLoading) {
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
          } else if (state is ReceiptError) {
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
            FiltersRow(formKey: formKey),
            BlocBuilder<TablesCubit, TablesState>(
              builder: (context, state) {
                if (state is TablesSuccess) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'عدد الفواتير : ${state.response.total}',
                      style: context.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            const SizedBox(height: 20),
            const FawryReceiptsTable(),
          ],
        ),
      ),
    );
  }
}
