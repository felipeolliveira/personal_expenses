import 'package:flutter/material.dart';
import 'package:personal_expenses/components/adaptative_button.dart';
import 'package:personal_expenses/components/adaptative_date_picker.dart';
import 'package:personal_expenses/components/adaptative_text_field.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit) {
    print('constructor TransactionForm');
  }

  @override
  _TransactionFormState createState() {
    print('createState TransactionForm');

    return _TransactionFormState();
  }
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _TransactionFormState() {
    print('Constructor _TransactionFormState');
  }

  @override
  void initState() {
    super.initState();
    print('initState _TransactionFormState');
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget _TransactionFormState');
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose _TransactionFormState');
  }

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    } else {
      widget.onSubmit(title, value, _selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(_selectedDate);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          AdaptativeTextField(
            controller: _titleController,
            label: 'Título',
            onSubmit: (_) => _submitForm(),
          ),
          AdaptativeTextField(
            controller: _valueController,
            label: 'Valor (R\$)',
            onSubmit: (_) => _submitForm(),
            type: TextInputType.numberWithOptions(decimal: false),
          ),
          AdaptativeDatePicker(
            _selectedDate,
            (newDate) => setState(() => _selectedDate = newDate),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AdaptativeButton('Adicionar transação', _submitForm),
              ],
            ),
          )
        ],
      ),
    );
  }
}
