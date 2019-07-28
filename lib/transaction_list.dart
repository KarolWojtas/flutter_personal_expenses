import 'package:flutter/material.dart';

import 'models/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionList({this.transactions});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (BuildContext ctx, int index) {
        return TransactionItem(transactions[index]);
      },
    );
  }
}
