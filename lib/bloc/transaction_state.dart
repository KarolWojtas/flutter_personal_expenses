import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../models/transaction.dart';

// state
class TransactionState extends Equatable {
  final List<Transaction> transactions;
  final double totalWeekExpenses;

  TransactionState({this.transactions, this.totalWeekExpenses})
      : super([transactions, totalWeekExpenses]);

  TransactionState copyWith(
      {List<Transaction> transactions, double totalWeekExpenses}) {
    return TransactionState(
        transactions: transactions ?? this.transactions,
        totalWeekExpenses: totalWeekExpenses ?? this.totalWeekExpenses);
  }

  @override
  String toString() => 'Transactions: ${transactions.toString()}';
}

// actions
abstract class TransactionEvent extends Equatable {
  TransactionEvent([List props = const []]) : super([props]);
}

class AddTransactionEvent extends TransactionEvent {
  final Transaction transaction;

  AddTransactionEvent({this.transaction}) : super([transaction]);
  @override
  String toString() => 'AddTransaction';
}

class DeleteTransactionEvent extends TransactionEvent {
  final String id;
  DeleteTransactionEvent({@required this.id}): super([id]);

  @override
  String toString() => 'DeleteTransaction';

}
