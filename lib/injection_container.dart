import 'package:appwrite/appwrite.dart';
import 'package:doctor_console/core/network/network_info.dart';
import 'package:doctor_console/features/login/login_injection_container.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'features/tables/tables_injection_container.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  sl.registerLazySingleton(() => InternetConnection());
  sl.registerLazySingleton(() => Client()
    ..setEndpoint('https://appwrite.doctorinphysics.com/v1')
    ..setProject('651400d5d07d0023699b'));
  sl.registerLazySingleton(() => Functions(sl()));
  sl.registerLazySingleton(() => Account(sl()));
  sl.registerLazySingleton(() => Databases(sl()));
  // Features
  await loginInit();
  await tablesInit();

  await sl.allReady();
}
