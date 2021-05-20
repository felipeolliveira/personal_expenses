import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';

class TransactionItem extends StatefulWidget {
  final Transaction transaction;
  final Function(String p1) _onRemove;

  const TransactionItem({
    Key key,
    @required this.transaction,
    @required Function(String p1) onRemove,
  })  : _onRemove = onRemove,
        super(key: key);

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  static const colors = [
    Colors.yellow,
    Colors.purple,
    Colors.red,
    Colors.blue,
    Colors.orange
  ];

  Color _background;

  @override
  void initState() {
    int i = Random().nextInt(colors.length);
    _background = colors[i];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: ListTile(
        leading: Container(
          width: 80,
          decoration: BoxDecoration(
            color: _background,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Center(
              child: FittedBox(
                child: Text(
                  'R\$ ${widget.transaction.value.toStringAsFixed(2)}',
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
          widget.transaction.title,
          style: Theme.of(context).textTheme.headline4,
        ),
        subtitle:
            Text(DateFormat('dd MMM yyyy').format(widget.transaction.date)),
        trailing: MediaQuery.of(context).size.width > 480
            ? ElevatedButton.icon(
                onPressed: () {
                  widget._onRemove(widget.transaction.id);
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
                  widget._onRemove(widget.transaction.id);
                },
              ),
      ),
    );
  }
}
