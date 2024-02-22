import 'package:doctor_console/core/errors/failures.dart';
import 'package:doctor_console/core/usecases/usecase.dart';
import 'package:doctor_console/features/tables/domain/entities/fawry_response.dart';
import 'package:doctor_console/features/tables/domain/usecases/get_book_receipts.dart';
import 'package:doctor_console/features/tables/domain/usecases/get_renewal_receipts.dart';
import 'package:doctor_console/features/tables/domain/usecases/get_tables.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/book_receipt.dart';
import '../../domain/entities/receipt.dart';

part 'tables_state.dart';

class TablesCubit extends Cubit<TablesState> {
  TablesCubit(this.getTables, this.getRenewalReceiptsUseCase,
      this.getBookReceiptsUseCase)
      : super(TablesInitial());
  final GetTables getTables;
  final GetRenewalReceipts getRenewalReceiptsUseCase;
  final GetBookReceipts getBookReceiptsUseCase;
  Future<void> getTablesData(GetTablesParams params) async {
    emit(TablesLoading());
    final failureOrReceipts = await getTables(params);
    failureOrReceipts.fold(
      (failure) => emit(TablesError(
          message: failure is AppwriteFailure
              ? failure.message
              : failure.toString())),
      (response) => emit(TablesSuccess(response: response)),
    );
  }

  Future<void> getBookReceipts(GetBookReceiptsParams params) async {
    emit(TablesLoading());
    final failureOrReceipts = await getBookReceiptsUseCase(params);
    failureOrReceipts.fold(
      (failure) => emit(TablesError(
          message: failure is AppwriteFailure
              ? failure.message
              : failure.toString())),
      (receipts) => emit(BookReceiptsSuccess(receipts: receipts)),
    );
  }

  Future<void> getRenewalReceipts() async {
    emit(TablesLoading());
    final failureOrReceipts = await getRenewalReceiptsUseCase(NoParams());
    failureOrReceipts.fold(
      (failure) => emit(TablesError(
          message: failure is AppwriteFailure
              ? failure.message
              : failure.toString())),
      (receipts) => emit(RenewalSuccess(receipts: receipts)),
    );
  }

  void markAsRenewed(String id) {
    final receipts = (state as RenewalSuccess).receipts;
    emit(TablesLoading());
    // remove receipt from receipts list
    receipts.removeWhere((element) => element.id == id);
    if (receipts.isEmpty) {
      getRenewalReceipts();
    } else {
      emit(RenewalSuccess(receipts: receipts));
    }
  }
}
