import '../../injection_container.dart';
import 'data/datasources/tables_remote_data_source.dart';
import 'data/repositories/tables_repository_impl.dart';
import 'domain/repositories/tables_repository.dart';
import 'domain/usecases/get_tables.dart';
import 'domain/usecases/mark_as_renewed.dart';
import 'presentation/cubits/mark_cubit.dart';
import 'presentation/cubits/tables_cubit.dart';

Future<void> tablesInit() async {
  sl.registerFactory(() => TablesCubit(sl()));
  sl.registerFactory(() => MarkCubit(sl()));

  // Use cases
  sl.registerLazySingleton(() => GetTables(sl()));
  sl.registerLazySingleton(() => MarkAsRenewed(sl()));

  // Repository
  sl.registerLazySingleton<TablesRepository>(
      () => TablesRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  // Data sources
  sl.registerLazySingleton<TablesRemoteDataSource>(
      () => TablesRemoteDataSourceImpl(db: sl()));
}
