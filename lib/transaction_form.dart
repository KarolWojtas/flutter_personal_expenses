import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'models/transaction.dart';

typedef OnSaveTransactionData = void Function(Transaction tx);

class TransactionForm extends StatefulWidget {
  final OnSaveTransactionData onSaveCallback;
  TransactionForm({this.onSaveCallback});

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();

  final TransactionFormData _transactionFormData = TransactionFormData();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Title:'),
                validator: (String value) =>
                    value.isEmpty ? 'Title is required' : null,
                onSaved: (title) => _transactionFormData.title = title,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Amount:'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Amount must be specified';
                  } else {
                    double parsedAmount = double.tryParse(value);
                    return parsedAmount == null ? 'Invalid number' : null;
                  }
                },
                onSaved: (amountString) =>
                    _transactionFormData.setAmount(amountString),
                onFieldSubmitted: (amountString) {
                  _transactionFormData.setAmount(amountString);
                  _submitForm(context);
                },
              ),
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: _transactionFormData.date != null
                          ? FutureBuilder(
                              builder: (BuildContext ctx,
                                      AsyncSnapshot asyncSnapshot) =>
                                  Text(
                                    'Picked date: ${DateFormat.yMMMd('pl-PL').format(_transactionFormData.date)}',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey),
                                    textAlign: TextAlign.left,
                                  ),
                              future: initializeDateFormatting())
                          : Text('No date chosen'),
                    ),
                    RaisedButton(
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).textTheme.button.color,
                      child: Text(
                        'Choose date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () => _chooseDate(context),
                    ),
                  ],
                ),
              ),
              FlatButton(
                  child: Text('Add'),
                  textColor: Theme.of(context).accentColor,
                  onPressed: () => _submitForm(context))
            ],
          ),
          key: _formKey,
        ),
      ),
    );
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      widget.onSaveCallback(Transaction.fromFormData(_transactionFormData));
      _formKey.currentState.reset();
      FocusScope.of(context).unfocus();
    }
  }

  void _chooseDate(BuildContext context) async {
    var date = await showDatePicker(
        context: context,
        initialDate: _transactionFormData.date ?? DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 7)),
        lastDate: DateTime.now());
    setState(() {
      _transactionFormData.date = date ?? null;
    });
  }
}
