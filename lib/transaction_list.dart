import 'package:flutter/material.dart';

import 'models/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionList({this.transactions});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext ctx, int index) {
          return TransactionItem(transactions[index]);
        },
        childCount: transactions.length,
      ),
    );
  }
}
