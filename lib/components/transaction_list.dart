import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 80),
        itemCount: _transactions.length,
        itemBuilder: (ctx, index) {
          final transaction = _transactions[index];

          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            child: ListTile(
              leading: Container(
                width: 80,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        'R\$ ${transaction.value.toStringAsFixed(2)}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              title: Text(
                transaction.title,
                style: Theme.of(context).textTheme.headline4,
              ),
              subtitle:
                  Text(DateFormat('dd MMM yyyy').format(transaction.date)),
              trailing: MediaQuery.of(context).size.width > 480
                  ? ElevatedButton.icon(
                      onPressed: () {
                        _onRemove(transaction.id);
                      },
                      icon: Icon(Icons.delete),
                      label: Text('Excluir'),
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).errorColor,
                      ),
                    )
                  : IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () {
                        _onRemove(transaction.id);
                      },
                    ),
            ),
          );
        },
      ),
    );
  }
}
