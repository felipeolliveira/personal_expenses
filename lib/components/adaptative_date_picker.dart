import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime _selectedDate;
  final Function(DateTime) _onDateChanged;

  AdaptativeDatePicker(this._selectedDate, this._onDateChanged);

  void _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
    ).then((date) {
      if (date == null) {
        return;
      }

      _onDateChanged(date);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Container(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(2015),
              maximumDate: DateTime.now(),
              onDateTimeChanged: _onDateChanged,
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                TextButton(
                  onPressed: () => _showDatePicker(context),
                  child: Text(
                    _selectedDate == null
                        ? 'Selecionar data'
                        : 'Data: ${DateFormat('dd MMM yyyy').format(_selectedDate)}',
                  ),
                  style: TextButton.styleFrom(
                      primary: Theme.of(context).primaryColor),
                ),
              ],
            ),
          );
  }
}
