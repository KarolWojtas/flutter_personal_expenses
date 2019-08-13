import 'dart:collection';

import 'package:flutter/foundation.dart';

import '../models/transaction.dart';

class TransactionNotifier extends ChangeNotifier {
  final List<Transaction> _transactions = [
    Transaction(
        title: 'new shoes',
        amount: 21.33,
        date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(
        title: 'bitches',
        amount: 99,
        date: DateTime.now().subtract(Duration(days: 2)))
  ];

  UnmodifiableListView<Transaction> get transactions =>
      UnmodifiableListView(_transactions);

  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }
}
