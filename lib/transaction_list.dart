import 'package:flutter/material.dart';

import 'models/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionList({this.transactions});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? SliverToBoxAdapter(
            child: Column(
              children: [
                Text('No transactions'),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          )
        : SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext ctx, int index) {
                return TransactionItem(transactions[index]);
              },
              childCount: transactions.length,
            ),
          );
  }
}
