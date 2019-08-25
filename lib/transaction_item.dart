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
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 2)),
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                padding: EdgeInsets.all(10),
                child: Text(
                  '\$${tx.amount.toStringAsFixed(2)}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${tx.title}',
                    style: Theme.of(context).textTheme.title,
                    textAlign: TextAlign.left,
                  ),
                  FutureBuilder(
                    builder: (BuildContext ctx, AsyncSnapshot asyncSnapshot) =>
                        Text(
                      DateFormat.yMMMd(defaultLocale).format(tx.date),
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                      textAlign: TextAlign.left,
                    ),
                    future: initializeDateFormatting(defaultLocale),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
