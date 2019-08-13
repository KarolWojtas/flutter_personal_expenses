import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';

import 'transaction_state.dart';

class LogDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    if (event is AddTransactionEvent) {
      developer.log('BlocDelegate: new transaction ${event.transaction.title}');
    }
  }
}
