import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_console/core/constants/constants.dart';
import 'package:doctor_console/core/constants/enums.dart';
import 'package:doctor_console/features/tables/domain/entities/book_receipt.dart';
import 'package:doctor_console/features/tables/domain/entities/fawry_receipt.dart';
import 'package:doctor_console/features/tables/presentation/cubits/tables_cubit.dart';
import 'package:doctor_console/features/tables/presentation/widgets/data_cell_copy.dart';
import 'package:doctor_console/features/tables/presentation/widgets/refund_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FawryReceiptsTable extends StatefulWidget {
  const FawryReceiptsTable({super.key});

  @override
  State<FawryReceiptsTable> createState() => _FawryReceiptsTableState();
}

class _FawryReceiptsTableState extends State<FawryReceiptsTable> {
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

  List<DataRow> getRenewalRows(List<FawryReceipt> receipts) {
    return receipts.map<DataRow>((transaction) {
      return DataRow(cells: [
        DataCell(DataCellCopy(data: transaction.name)),
        DataCell(DataCellCopy(data: transaction.code)),
        DataCell(Text(transaction.monthsNeeded.map((e) => e.desc).toString())),
        DataCell(DataCellCopy(data: transaction.phone)),
        DataCell(DataCellCopy(data: transaction.year.desc)),
        DataCell(DataCellCopy(data: transaction.referenceNumber.toString())),
        DataCell(DataCellCopy(
            data: transaction.paidAt?.toIso8601String() ?? 'لسه مدفعش')),
        DataCell(DataCellCopy(data: transaction.status)),
        DataCell(RefundButton(receipt: transaction)),
      ]);
    }).toList();
  }

  List<DataRow> getBooksRows(List<BookReceipt> receipts) {
    return receipts.map<DataRow>((transaction) {
      return DataRow(cells: [
        DataCell(DataCellCopy(data: transaction.name)),
        DataCell(DataCellCopy(data: transaction.address)),
        DataCell(DataCellCopy(data: transaction.phone)),
        DataCell(DataCellCopy(data: transaction.secondPhone)),
        for (int i = 0; i < Books.values.length; i++)
          DataCell(
              DataCellCopy(data: transaction.booksNeeded.tryGet(i).toString())),
        DataCell(DataCellCopy(data: transaction.referenceNumber.toString())),
        DataCell(DataCellCopy(
            data: transaction.paidAt?.toIso8601String() ?? 'لسه مدفعش')),
        DataCell(DataCellCopy(data: transaction.status)),
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
          return Scrollbar(
            scrollbarOrientation: ScrollbarOrientation.top,
            controller: _scrollController,
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  columns: [
                    'الاسم',
                    'الكود',
                    'الشهور المطلوبة',
                    'الهاتف',
                    'السنة الدراسية',
                    'الرقم المرجعي',
                    'تاريخ الدفع',
                    'حالة الدفع',
                    ''
                  ].map((e) => DataColumn(label: Text(e))).toList(),
                  rows: getRenewalRows(state.receipts.cast<FawryReceipt>())),
            ),
          );
        } else if (state is BookReceiptsSuccess) {
          return Scrollbar(
            scrollbarOrientation: ScrollbarOrientation.top,
            controller: _scrollController,
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  columns: [
                    'الاسم',
                    'العنوان',
                    'رقم الموبايل',
                    'رقم الموبايل احتياطي',
                    for (Books book in Books.values) book.desc,
                    'الرقم المرجعي',
                    'تاريخ الدفع',
                    'حالة الدفع',
                  ].map((e) => DataColumn(label: Text(e))).toList(),
                  rows: getBooksRows(state.receipts.cast<BookReceipt>())),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
