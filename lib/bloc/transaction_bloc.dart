import 'package:bloc/bloc.dart';

import '../models/transaction.dart';
import 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  @override
  TransactionState get initialState => TransactionState(transactions: [
        Transaction(
            title: 'new shoes',
            amount: 21.0,
            date: DateTime.now().subtract(Duration(days: 1))),
        Transaction(
            title: 'bitches',
            amount: 99.0,
            date: DateTime.now().subtract(Duration(days: 2)))
      ], totalWeekExpenses: 120.0);

  @override
  Stream<TransactionState> mapEventToState(TransactionEvent event) async* {
    if (event is AddTransactionEvent) {
      yield TransactionState(
          transactions: List.from(currentState.transactions)
            ..add(event.transaction),
          totalWeekExpenses:
              currentState.totalWeekExpenses + event.transaction.amount);
    } else if (event is DeleteTransactionEvent) {
      yield TransactionState(
          transactions: currentState.transactions
              .where((transaction) => transaction.id != event.id)
              .toList(),
          totalWeekExpenses: currentState.totalWeekExpenses -
              currentState.transactions
                  .singleWhere((transaction) => transaction.id == event.id)
                  ?.amount);
    } else {
      yield currentState;
    }
  }
}
