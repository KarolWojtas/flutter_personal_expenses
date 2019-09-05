import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction tx;
  static const String defaultLocale = 'pl_PL';
  TransactionItem(this.tx);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text(
                NumberFormat.compactSimpleCurrency(
                        locale: defaultLocale, decimalDigits: 0)
                    .format(tx.amount),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white70),
              ),
            ),
          ),
        ),
        title: Text(
          '${tx.title}',
          style: Theme.of(context).textTheme.title,
          textAlign: TextAlign.left,
        ),
        subtitle: FutureBuilder(
          builder: (BuildContext ctx, AsyncSnapshot asyncSnapshot) => Text(
            DateFormat.yMMMd(defaultLocale).format(tx.date),
            style: TextStyle(fontSize: 13, color: Colors.grey),
            textAlign: TextAlign.left,
          ),
          future: initializeDateFormatting(defaultLocale),
        ),
      ),
    );
  }
}
