import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/log_delegate.dart';
import 'bloc/transaction_bloc.dart';
import 'bloc/transaction_state.dart';
import 'models/transaction.dart';
import 'transaction_form.dart';
import 'transaction_list.dart';

void main() {
  BlocSupervisor.delegate = LogDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionBloc>(
      builder: (context) => TransactionBloc(),
      child: MaterialApp(
        title: 'Personal Expenses',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            expandedHeight: 75,
            title: Center(
              child: Text(
                'PersonalExpenses',
                style: TextStyle(fontSize: 30, letterSpacing: 1),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
                background: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/stars.jpg'),
                      fit: BoxFit.cover)),
            )),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => startAddNewTransaction(context))
            ],
          ),
          SliverToBoxAdapter(
            child: Container(child: Text('chart')),
          ),
          BlocBuilder<TransactionBloc, TransactionState>(
            builder: (context, TransactionState state) => TransactionList(
              transactions: state.transactions,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => startAddNewTransaction(context),
          child: Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void startAddNewTransaction(BuildContext context) {
    final TransactionBloc bloc = BlocProvider.of<TransactionBloc>(context);
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(child:
                TransactionForm(onSaveCallback: (Transaction transaction) {
              bloc.dispatch(AddTransactionEvent(transaction: transaction));
              Navigator.of(context).pop();
            })),
          );
        });
  }
}
