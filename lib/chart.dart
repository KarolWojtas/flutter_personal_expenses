import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'chart_bar.dart';
import 'models/chart_bar.dart';
import 'models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;
  final double totalWeekExpenses;

  Chart({@required this.transactions, @required this.totalWeekExpenses});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:
              this.transactions.isNotEmpty && this.totalWeekExpenses != null
                  ? this.mapTransactionsToBars(this.transactions)
                  : [Text('No transactions')],
        ),
      ),
    );
  }

  List<Widget> mapTransactionsToBars(List<Transaction> transactions) {
    return List.generate(7, (int index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      final double expensesAmount = transactions
          .where((transaction) => datesAreEqual(transaction.date, weekday))
          .fold(0, (double total, Transaction tx) => total + tx.amount);

      return ChartBarModel(
          weekday: index + 1,
          weekdayLiteral: DateFormat.E().format(weekday),
          expensesAmount: expensesAmount,
          expensesPercentage: expensesAmount / this.totalWeekExpenses * 100);
    })
        .map((ChartBarModel chartBarModel) {
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(
              chartBarModel: chartBarModel,
            ),
          );
        })
        .toList()
        .reversed
        .toList();
  }

  bool datesAreEqual(DateTime firstDate, DateTime secondDate) =>
      firstDate.year == secondDate.year &&
      firstDate.month == secondDate.month &&
      firstDate.day == secondDate.day;
}
