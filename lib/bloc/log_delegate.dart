import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';

import 'transaction_state.dart';

class LogDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    if (event is AddTransactionEvent) {
      log(event, event.transaction.title);
    } else if (event is DeleteTransactionEvent) {
      log(event, event.id);
    }
  }

  void log(Object event, String message) {
    developer.log('BlocDelegate[${event.runtimeType}]: $message');
  }
}
