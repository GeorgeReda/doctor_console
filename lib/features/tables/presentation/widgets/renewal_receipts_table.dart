import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_console/core/constants/enums.dart';
import 'package:doctor_console/features/tables/domain/entities/fawry_receipt.dart';
import 'package:doctor_console/features/tables/presentation/cubits/tables_cubit.dart';
import 'package:doctor_console/features/tables/presentation/widgets/data_cell_copy.dart';
import 'package:doctor_console/features/tables/presentation/widgets/mark_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RenewalReceiptsTable extends StatefulWidget {
  const RenewalReceiptsTable({super.key});

  @override
  State<RenewalReceiptsTable> createState() => _RenewalReceiptsTableState();
}

class _RenewalReceiptsTableState extends State<RenewalReceiptsTable> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<DataRow> getRows(List<FawryReceipt> receipts) {
    return receipts.map<DataRow>((transaction) {
      return DataRow(cells: [
        DataCell(
            MarkButton(id: transaction.id, isEnabled: !transaction.isRenewed)),
        DataCell(DataCellCopy(data: transaction.name)),
        DataCell(Text(transaction.months
            .map((e) =>
                transaction.year == Year.second ? e.secondDesc : e.thirdDesc)
            .toString())),
        DataCell(DataCellCopy(data: transaction.phone)),
        DataCell(Chip(
            color: WidgetStatePropertyAll(
                transaction.year == Year.second ? Colors.green : Colors.amber),
            label: DataCellCopy(data: transaction.year.desc))),
      ]);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TablesCubit, TablesState>(
      builder: (context, state) {
        if (state is TablesInitial) {
          return const Center(child: Text('حدد الفلاتر لعرض البيانات'));
        } else if (state is TablesLoading) {
          return Center(
            child: LoadingAnimationWidget.prograssiveDots(
                color: context.primaryColor, size: 50.0),
          );
        } else if (state is TablesError) {
          return Center(child: Text(state.message));
        } else if (state is RenewalSuccess) {
          if (state.receipts.isEmpty) {
            return ElevatedButton(
              onPressed: () => context.read<TablesCubit>().getRenewalReceipts(),
              child: const Text('تحديث'),
            );
          } else {
            return Scrollbar(
              scrollbarOrientation: ScrollbarOrientation.top,
              controller: _scrollController,
              child: SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: DataTable(
                    columns: [
                      '',
                      'الاسم',
                      'الشهور المطلوبة',
                      'الهاتف',
                      'السنة الدراسية',
                    ].map((e) => DataColumn(label: Text(e))).toList(),
                    rows: getRows(state.receipts.cast<FawryReceipt>())),
              ),
            );
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
