import 'package:doctor_console/core/constants/enums.dart';
import 'package:doctor_console/features/tables/domain/usecases/get_book_receipts.dart';
import 'package:doctor_console/features/tables/domain/usecases/get_tables.dart';
import 'package:doctor_console/features/tables/presentation/cubits/tables_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

class FiltersRow extends StatefulWidget {
  const FiltersRow({super.key, required this.formKey});
  final GlobalKey<FormBuilderState> formKey;
  @override
  State<FiltersRow> createState() => _FiltersRowState();
}

class _FiltersRowState extends State<FiltersRow> {
  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: widget.formKey,
      child: Wrap(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 200,
                child: FormBuilderDropdown<Year>(
                    name: 'year',
                    onChanged: (value) => setState(() {}),
                    validator:
                        FormBuilderValidators.required(errorText: 'مطلوب'),
                    decoration: InputDecoration(
                      labelText: 'السنة الدراسية',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)),
                    ),
                    initialValue: Year.none,
                    items: Year.values
                        .map((e) =>
                            DropdownMenuItem(value: e, child: Text(e.desc)))
                        .toList()),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 200,
              child: FormBuilderDateTimePicker(
                name: 'day',
                inputType: InputType.date,
                format: DateFormat('yyyy-MM-dd'),
                decoration: const InputDecoration(
                    labelText: 'اليوم',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 200,
              child: FormBuilderTextField(
                name: 'query',
                initialValue: '',
                decoration: const InputDecoration(
                    labelText: 'البحث',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 200,
              child: FormBuilderCheckbox(
                name: 'isRenewed',
                initialValue: false,
                title: const Text('تم التجديد'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 200,
              child: ElevatedButton(
                  onPressed: () {
                    if (widget.formKey.currentState?.saveAndValidate() ??
                        false) {
                      context.read<TablesCubit>().getTablesData(GetTablesParams(
                            isRenewed: widget.formKey.currentState
                                ?.fields['isRenewed']?.value,
                            day: widget
                                .formKey.currentState?.fields['day']?.value,
                            year: widget
                                .formKey.currentState?.fields['year']?.value,
                            query: widget
                                .formKey.currentState?.fields['query']?.value,
                          ));
                    }
                  },
                  child: const Text('بحث')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 200,
              child: ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF10793F))),
                  onPressed: () {
                    if (widget.formKey.currentState!.saveAndValidate()) {
                      context.read<TablesCubit>().getBookReceipts(
                          GetBookReceiptsParams(
                              day: widget
                                  .formKey.currentState?.fields['day']?.value));
                    }
                  },
                  icon: const Icon(
                    Icons.download,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'تحميل اكسل المذكرات',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
