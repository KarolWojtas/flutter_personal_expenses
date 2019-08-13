import 'package:bloc/bloc.dart';

import '../models/transaction.dart';
import 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  @override
  TransactionState get initialState => TransactionState(transactions: [
        Transaction(
            title: 'new shoes',
            amount: 21.33,
            date: DateTime.now().subtract(Duration(days: 1))),
        Transaction(
            title: 'bitches',
            amount: 99,
            date: DateTime.now().subtract(Duration(days: 2)))
      ]);

  @override
  Stream<TransactionState> mapEventToState(TransactionEvent event) async* {
    if (event is AddTransactionEvent) {
      yield TransactionState(
          transactions: List.from(currentState.transactions)
            ..add(event.transaction));
    } else {
      yield currentState;
    }
  }
}
