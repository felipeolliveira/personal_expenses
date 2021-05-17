import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/components/chart_bar.dart';

import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/models/transactionDayValue.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _transactions;

  Chart(this._transactions);

  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  List<TransactionDayValue> get _groudpedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      final firstLetterWeek = DateFormat.E().format(weekDay)[0];

      final totalValueInDay = _recentTransactions.fold(0.0, (sum, next) {
        bool sameDay = next.date.day == weekDay.day;
        bool sameMonth = next.date.month == weekDay.month;
        bool sameYear = next.date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          return sum + next.value;
        }

        return sum;
      });

      return TransactionDayValue(firstLetterWeek, totalValueInDay);
    }).reversed.toList();
  }

  double get _totalWeekValue {
    return _groudpedTransactions.fold(
      0.0,
      (sum, next) => sum + next.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(6.0),
      child: Row(
        children: _groudpedTransactions
            .map((transaction) => Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    day: transaction.day,
                    value: transaction.value,
                    percent: transaction.value / _totalWeekValue,
                  ),
                ))
            .toList(),
      ),
    );
  }
}
