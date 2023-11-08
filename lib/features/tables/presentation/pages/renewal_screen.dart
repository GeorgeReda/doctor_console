import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_console/features/tables/presentation/widgets/renewal_receipts_table.dart';
import 'package:flutter/material.dart';


class RenewalScreen extends StatelessWidget {
  const RenewalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'تجديد الشهر',
                    style: context.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(child: Image.asset("assets/logo.png")),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const RenewalReceiptsTable(),
        ],
      ),
    );
  }
}
