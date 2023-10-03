import 'package:doctor_console/core/errors/failures.dart';
import 'package:doctor_console/features/tables/domain/usecases/get_tables.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/receipt.dart';

part 'tables_state.dart';

class TablesCubit extends Cubit<TablesState> {
  TablesCubit(this.getTables) : super(TablesInitial());
  final GetTables getTables;
  Future<void> getTablesData(GetTablesParams params) async {
    emit(TablesLoading());
    final failureOrReceipts = await getTables(params);
    failureOrReceipts.fold(
      (failure) => emit(TablesError(
          message: failure is AppwriteFailure
              ? failure.message
              : failure.toString())),
      (receipts) => emit(TablesSuccess(receipts: receipts)),
    );
  }

  void markAsRenewed(String id) {
    final receipts = (state as TablesSuccess).receipts;
    emit(TablesLoading());
    // remove receipt from receipts list
    receipts.removeWhere((element) => element.id == id);
    emit(TablesSuccess(receipts: receipts));
  }
}
