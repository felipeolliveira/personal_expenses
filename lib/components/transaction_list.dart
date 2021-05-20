import 'package:flutter/material.dart';
import 'package:personal_expenses/components/transaction_item.dart';
import 'package:personal_expenses/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function(String) _onRemove;

  TransactionList(this._transactions, this._onRemove);

  @override
  Widget build(BuildContext context) {
    if (_transactions.isNotEmpty) {
      return _Transactions(_transactions, _onRemove);
    }

    return null;
  }
}

class _Transactions extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function(String) _onRemove;

  _Transactions(this._transactions, this._onRemove);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:
          // ListView(
          //   padding: EdgeInsets.only(bottom: 80),
          //   children: _transactions
          //       .map((transaction) => TransactionItem(
          //             key: ValueKey(transaction.id),
          //             transaction: transaction,
          //             onRemove: _onRemove,
          //           ))
          //       .toList(),
          // ),
          ListView.builder(
        padding: EdgeInsets.only(bottom: 80),
        itemCount: _transactions.length,
        itemBuilder: (ctx, index) {
          final transaction = _transactions[index];

          return TransactionItem(
            key: GlobalObjectKey(transaction),
            transaction: transaction,
            onRemove: _onRemove,
          );
        },
      ),
    );
  }
}
