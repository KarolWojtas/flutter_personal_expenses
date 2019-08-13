import 'package:flutter/material.dart';

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
              FlatButton(
                  child: Text('Add'),
                  textColor: Colors.deepPurple,
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
}
