import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/log_delegate.dart';
import 'bloc/transaction_bloc.dart';
import 'bloc/transaction_state.dart';
import 'chart.dart';
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
            textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(fontFamily: 'OpenSans'),
                button: TextStyle(color: Colors.white)),
            appBarTheme: AppBarTheme(
                textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(fontFamily: 'OpenSans', fontSize: 20))),
            primarySwatch: Colors.deepPurple,
            accentColor: Colors.lightBlueAccent,
            fontFamily: 'Quicksand'),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final chart = BlocBuilder<TransactionBloc, TransactionState>(
    builder: (BuildContext ctx, TransactionState state) => Chart(
      transactions: state.transactions,
      totalWeekExpenses: state.totalWeekExpenses,
    ),
  );
  final transactionList = BlocBuilder<TransactionBloc, TransactionState>(
    builder: (context, TransactionState state) => TransactionList(
      transactions: state.transactions
          .where((transaction) => transaction.date
              .isAfter(DateTime.now().subtract(Duration(days: 7))))
          .toList(),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          return CustomScrollView(
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
          ]..addAll(orientation == Orientation.portrait
                  ? [
                      SliverToBoxAdapter(
                        child: chart,
                      ),
                      transactionList
                    ]
                  : [
                      SliverGrid.count(
                        crossAxisCount: 2,
                        children: <Widget>[
                          LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              return Container(
                                child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4),
                                    child: chart),
                                height: constraints.maxHeight,
                              );
                            },
                          ),
                          CustomScrollView(
                            slivers: <Widget>[transactionList],
                          )
                        ],
                      ),
                    ]));
        },
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
        isScrollControlled: true,
        builder: (_) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SingleChildScrollView(child:
                  TransactionForm(onSaveCallback: (Transaction transaction) {
                bloc.dispatch(AddTransactionEvent(transaction: transaction));
                Navigator.of(context).pop();
              })),
            ),
          );
        });
  }
}
