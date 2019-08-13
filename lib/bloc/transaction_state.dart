import 'package:equatable/equatable.dart';

import '../models/transaction.dart';

// state
class TransactionState extends Equatable {
  final List<Transaction> transactions;

  TransactionState({this.transactions}) : super([transactions]);

  TransactionState copyWith({List<Transaction> transactions}) {
    return TransactionState(transactions: transactions ?? this.transactions);
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
