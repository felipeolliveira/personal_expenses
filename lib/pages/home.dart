import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses/components/chart.dart';

import 'package:personal_expenses/components/transaction_form.dart';
import 'package:personal_expenses/components/transaction_list.dart';
import 'package:personal_expenses/models/transaction.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  void _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() => _transactions.add(newTransaction));

    Navigator.of(context).pop();
  }

  void _removeTransaction(String id) {
    setState(
      () => _transactions.removeWhere((transaction) => transaction.id == id),
    );
  }

  void _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(child: TransactionForm(_addTransaction));
      },
    );
  }

  Widget _getIconButton(IconData icon, Function fn) {
    return Platform.isIOS
        ? GestureDetector(
            onTap: fn,
            child: Icon(icon),
          )
        : IconButton(
            icon: Icon(icon),
            onPressed: fn,
          );
  }

  @override
  Widget build(BuildContext context) {
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final actions = <Widget>[
      if (isLandscape)
        _getIconButton(
          _showChart ? Icons.list_alt_outlined : Icons.show_chart_rounded,
          () {
            setState(() {
              _showChart = !_showChart;
            });
          },
        ),
      _getIconButton(
        Icons.add,
        () => _openTransactionFormModal(context),
      ),
    ];

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Personal Expansives'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          )
        : AppBar(
            title: Text('Personal Expansives'),
            actions: actions,
          );

    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    final _bodyPage = _transactions.isEmpty
        ? SafeArea(child: Center(child: _EmptyList()))
        : SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_showChart || !isLandscape)
                  Container(
                    height: availableHeight * (!isLandscape ? 0.25 : 0.75),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Chart(_transactions),
                    ),
                  ),
                if (!_showChart || !isLandscape)
                  Container(
                    height: availableHeight * (!isLandscape ? 0.75 : 1),
                    child: TransactionList(_transactions, _removeTransaction),
                  ),
              ],
            ),
          );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: _bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _openTransactionFormModal(context),
                  ),
            body: _bodyPage,
          );
  }
}

class _EmptyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: LayoutBuilder(builder: (ctx, contraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(
                  'assets/images/empty_list.png',
                ),
                Text('Ops... >.<',
                    style: Theme.of(context).textTheme.headline5),
                SizedBox(height: 10),
                Text('Sem transações cadastradas',
                    style: Theme.of(context).textTheme.headline6),
              ],
            );
          }),
        ),
      ],
    );
  }
}
