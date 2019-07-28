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
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepPurple, width: 2)),
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                padding: EdgeInsets.all(10),
                child: Text(
                  '\$${tx.amount}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.deepPurple),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${tx.title}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
