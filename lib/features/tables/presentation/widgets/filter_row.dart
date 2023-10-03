import 'package:doctor_console/core/constants/constants.dart';
import 'package:doctor_console/core/constants/enums.dart';
import 'package:doctor_console/features/tables/domain/usecases/get_tables.dart';
import 'package:doctor_console/features/tables/presentation/cubits/tables_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

class FiltersRow extends StatefulWidget {
  const FiltersRow({super.key});

  @override
  State<FiltersRow> createState() => _FiltersRowState();
}

class _FiltersRowState extends State<FiltersRow> {
  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      child: Row(
        children: [
          Expanded(
            child: FormBuilderDropdown(
                name: 'paymentMethod',
                onChanged: (value) => setState(() {}),
                validator: FormBuilderValidators.required(errorText: 'مطلوب'),
                decoration: const InputDecoration(labelText: 'طريقة الدفع'),
                initialValue: PaymentMethod.fawry,
                items: const [
                  DropdownMenuItem(
                    value: PaymentMethod.vodafoneCash,
                    child: Text('فودافون كاش'),
                  ),
                  DropdownMenuItem(
                    value: PaymentMethod.fawry,
                    child: Text('فوري'),
                  ),
                ]),
          ),
          if (formKey.currentState?.fields['paymentMethod']?.value ==
              PaymentMethod.vodafoneCash)
            Expanded(
              child: FormBuilderDropdown(
                  name: 'phoneReceived',
                  initialValue: numbers.first,
                  items: numbers
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList()),
            ),
          Expanded(
            child: FormBuilderDateTimePicker(
              name: 'day',
              initialValue: DateTime.now(),
              inputType: InputType.date,
              format: DateFormat('yyyy-MM-dd'),
              decoration: const InputDecoration(labelText: 'اليوم'),
            ),
          ),
          Expanded(
            child: FormBuilderCheckbox(
              name: 'isUsed',
              initialValue: true,
              title: const Text('تم الاستخدام'),
            ),
          ),
          Expanded(
            child: FormBuilderCheckbox(
              name: 'isRenewed',
              initialValue: false,
              title: const Text('تم التجديد'),
            ),
          ),
          Expanded(
            child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState?.saveAndValidate() ?? false) {
                    context.read<TablesCubit>().getTablesData(GetTablesParams(
                        paymentMethod: formKey
                            .currentState?.fields['paymentMethod']?.value,
                        phoneReceived: formKey
                            .currentState?.fields['phoneReceived']?.value,
                        isUsed: formKey.currentState?.fields['isUsed']?.value,
                        isRenewed:
                            formKey.currentState?.fields['isRenewed']?.value,
                        day: formKey.currentState?.fields['day']?.value));
                  }
                },
                child: const Text('بحث')),
          )
        ],
      ),
    );
  }
}
