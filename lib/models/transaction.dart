import 'dart:math';

import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  @required
  final String title;
  final double amount;
  final DateTime date;

  Transaction({this.title, this.amount, this.date})
      : this.id = Random().nextDouble().toString();
  factory Transaction.fromFormData(TransactionFormData txFormData) {
    return Transaction(
        title: txFormData.title,
        amount: txFormData.amount ?? 0.0,
        date: txFormData.date ?? DateTime.now());
  }
}

class TransactionFormData {
  @required
  String title;
  double amount;
  DateTime date;
}
