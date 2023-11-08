import 'package:doctor_console/features/tables/domain/usecases/get_renewal_receipts.dart';

import '../../injection_container.dart';
import 'data/datasources/tables_local_data_source.dart';
import 'data/datasources/tables_remote_data_source.dart';
import 'data/repositories/tables_repository_impl.dart';
import 'domain/repositories/tables_repository.dart';
import 'domain/usecases/get_book_receipts.dart';
import 'domain/usecases/get_tables.dart';
import 'domain/usecases/mark_as_renewed.dart';
import 'domain/usecases/refund.dart';
import 'presentation/cubits/receipt_cubit.dart';
import 'presentation/cubits/tables_cubit.dart';

Future<void> tablesInit() async {
  sl.registerFactory(() => TablesCubit(sl(), sl(), sl()));
  sl.registerFactory(() => ReceiptCubit(sl(), sl()));

  // Use cases
  sl.registerLazySingleton(() => GetTables(sl()));
  sl.registerLazySingleton(() => GetBookReceipts(sl()));
  sl.registerLazySingleton(() => GetRenewalReceipts(sl()));
  sl.registerLazySingleton(() => MarkAsRenewed(sl()));
  sl.registerLazySingleton(() => Refund(sl()));

  // Repository
  sl.registerLazySingleton<TablesRepository>(() => TablesRepositoryImpl(
      remoteDataSource: sl(), networkInfo: sl(), localDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<TablesRemoteDataSource>(
      () => TablesRemoteDataSourceImpl(db: sl()));
  sl.registerLazySingleton<TablesLocalDataSource>(
      () => TablesLocalDataSourceImpl());
}
