import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_console/core/constants/enums.dart';
import 'package:doctor_console/features/tables/domain/entities/vf_cash_receipt.dart';
import 'package:doctor_console/features/tables/presentation/cubits/tables_cubit.dart';
import 'package:doctor_console/features/tables/presentation/widgets/data_cell_copy.dart';
import 'package:doctor_console/features/tables/presentation/widgets/mark_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ReceiptsTable extends StatefulWidget {
  const ReceiptsTable({super.key});

  @override
  State<ReceiptsTable> createState() => _ReceiptsTableState();
}

class _ReceiptsTableState extends State<ReceiptsTable> {
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

  List<DataRow> getRows(List<VFCashReceipt> receipts) {
    return receipts.map<DataRow>((transaction) {
      return DataRow(cells: [
        DataCell(MarkButton(
          id: transaction.id,
          paymentMethod: PaymentMethod.vodafoneCash,
          isEnabled: transaction.isUsed && !transaction.isRenewed,
        )),
        DataCell(DataCellCopy(data: transaction.name)),
        DataCell(DataCellCopy(data: transaction.code)),
        DataCell(DataCellCopy(data: transaction.phone)),
        DataCell(DataCellCopy(data: transaction.year.desc)),
        DataCell(Text(transaction.monthsNeeded.map((e) => e.desc).toString())),
        DataCell(DataCellCopy(data: transaction.transactionId)),
        DataCell(DataCellCopy(data: transaction.phoneSent)),
        DataCell(DataCellCopy(data: transaction.phoneRecieved)),
        DataCell(DataCellCopy(data: transaction.amount.toString())),
        DataCell(transaction.isUsed == true
            ? const Icon(
                Icons.check,
                color: Colors.green,
              )
            : const Icon(Icons.close, color: Colors.red)),
        DataCell(transaction.isRenewed == true
            ? const Icon(
                Icons.check,
                color: Colors.green,
              )
            : const Icon(Icons.close, color: Colors.red)),
        DataCell(DataCellCopy(data: transaction.transactionDate.toString())),
        DataCell(DataCellCopy(data: transaction.usedAt.toString())),
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
        } else if (state is TablesSuccess) {
          // Todo implement fawry table
          return Scrollbar(
            scrollbarOrientation: ScrollbarOrientation.top,
            controller: _scrollController,
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  columns: [
                    'الترتيب',
                    'الاسم',
                    'الكود',
                    'الهاتف',
                    'السنة الدراسية',
                    'الشهور المطلوبة',
                    'رقم العملية',
                    'الهاتف المُحول منه',
                    'الهاتف المُحول إليه',
                    'المبلغ',
                    'تم الاستخدام',
                    'تم التجديد',
                    'تاريخ التحويل',
                    'تاريخ الاستخدام',
                  ].map((e) => DataColumn(label: Text(e))).toList(),
                  rows: getRows(state.receipts.cast<VFCashReceipt>())),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
