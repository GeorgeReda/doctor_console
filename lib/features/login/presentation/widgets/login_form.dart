import 'package:doctor_console/features/login/presentation/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final TextEditingController username, password;

  @override
  void initState() {
    super.initState();
    username = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            controller: username,
            decoration: const InputDecoration(
              hintText: "الايميل",
              prefixIcon: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              controller: password,
              decoration: const InputDecoration(
                hintText: "كلمة المرور",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => context
                .read<LoginCubit>()
                .login(username.text.trim(), password.text.trim()),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text("تسجيل الدخول"),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
