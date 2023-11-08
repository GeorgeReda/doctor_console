import 'package:doctor_console/features/login/presentation/cubit/login_cubit.dart';

import '../../injection_container.dart';
import 'data/datasources/login_remote_data_source.dart';
import 'data/repositories/login_repository_impl.dart';
import 'domain/repositories/login_repository.dart';
import 'domain/usecases/login.dart';

Future<void> loginInit() async {
  sl.registerFactory(() => LoginCubit(sl()));

  // Use cases
  sl.registerLazySingleton(() => Login(sl()));

  // Repository
  sl.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  // Data sources
  sl.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl(
            account: sl(),
          ));
}
