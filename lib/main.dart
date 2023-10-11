import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_console/features/login/presentation/cubit/login_cubit.dart';
import 'package:doctor_console/features/login/presentation/pages/login_screen.dart';
import 'package:doctor_console/features/tables/presentation/cubits/mark_cubit.dart';
import 'package:doctor_console/features/tables/presentation/cubits/tables_cubit.dart';
import 'package:doctor_console/injection_container.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setPathUrlStrategy();
  await init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetIt.I<LoginCubit>()),
        BlocProvider(create: (context) => GetIt.I<TablesCubit>()),
        BlocProvider(create: (context) => GetIt.I<MarkCubit>()),
      ],
      child: MaterialApp(
          theme: FlexThemeData.light(
            scheme: FlexScheme.deepBlue,
            useMaterial3: true,
            visualDensity: FlexColorScheme.comfortablePlatformDensity,
            
          ),
          builder: (context, child) => Directionality(
              textDirection: TextDirection.rtl,
              child: child ?? const SizedBox()),
          home: const LoginScreen()),
    );
  }
}
