import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_console/core/utils/responsive.dart';
import 'package:doctor_console/features/login/presentation/cubit/login_cubit.dart';
import 'package:doctor_console/features/login/presentation/widgets/logo.dart';
import 'package:doctor_console/features/tables/presentation/pages/tables_screen.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => Dialog(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  child: Center(
                      child: LoadingAnimationWidget.inkDrop(
                          color: context.primaryColor, size: 50.0))),
            );
          } else if (state is LoginSuccess) {
            //remove the circular progress indicator
            context.pop();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const TablesScreen(),
              ),
            );
          } else if (state is LoginError) {
            //remove the circular progress indicator

            context.pop();
            Fluttertoast.showToast(
              msg: state.message,
              webPosition: 'center',
              webBgColor: context.primaryColor.hex,
              toastLength: Toast.LENGTH_LONG,
            );
          }
        },
        child: const SingleChildScrollView(
          child: Responsive(
            mobile: MobileLoginScreen(),
            desktop: Row(
              children: [
                Expanded(
                  child: Logo(),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 450,
                        child: LoginForm(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Logo(),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: LoginForm(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
