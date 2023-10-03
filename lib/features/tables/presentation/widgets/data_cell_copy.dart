import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DataCellCopy extends StatelessWidget {
  const DataCellCopy({super.key, required this.data});
  final String data;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            data,
            textAlign: TextAlign.center,
          ),
        ),
        IconButton(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: data));
            Fluttertoast.showToast(
              msg: 'تم النسخ !',
              webPosition: 'center',
              webBgColor: context.primaryColor.hex,
              toastLength: Toast.LENGTH_LONG,
            );
          },
          icon: const Icon(Icons.copy),
        ),
      ],
    );
  }
}
