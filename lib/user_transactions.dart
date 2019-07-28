import 'package:flutter/material.dart';

import 'models/transaction.dart';
import 'transaction_form.dart';
import 'transaction_list.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> transactions = [
    Transaction(
        title: 'new shoes',
        amount: 21.33,
        date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(
        title: 'bitches',
        amount: 99,
        date: DateTime.now().subtract(Duration(days: 2)))
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TransactionForm(onSaveCallback: _onAddTransaction),
        Expanded(
          child: TransactionList(
            transactions: transactions,
          ),
        )
      ],
    );
  }

  void _onAddTransaction(Transaction transaction) {
    setState(() => transactions.add(transaction));
  }
}
