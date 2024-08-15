import 'dart:async';

import 'package:bytebank/components/custom_switch_widget.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebclient _webClient = TransactionWebclient();
  final String transactionId = Uuid().v4();
  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
        actions: [
          CustomSwitch(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                child: Progress(
                  message: 'Sending...',
                ),
                visible: _sending,
              ),
              Text(
                widget.contact.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Text(
                      'Transfer',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      final double? value =
                          double.tryParse(_valueController!.text);
                      final transactionCreated = Transaction(
                        transactionId,
                        value,
                        widget.contact,
                      );

                      showDialog(
                        context: context,
                        builder: (contextDialog) {
                          return TransactionAuthDialog(
                            onConfirm: (password) {
                              _save(transactionCreated, password, context);
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save(
    Transaction transactionCreated,
    String password,
    BuildContext context,
  ) async {
    await _send(transactionCreated, password, context);
  }

  Future<void> _send(
    Transaction transactionCreated,
    String password,
    BuildContext context,
  ) async {
    setState(() {
      _sending = true;
    });
    try {
      final Transaction transaction =
          await _webClient.save(transactionCreated, password);
      await _showSuccessfulMessage(transaction, context);
    } on HttpException catch (e) {
      _showFailureMessage(context, message: e.toString());
    } on TimeoutException catch (e) {
      _showFailureMessage(context,
          message: 'timeout submitting the transaction');
    } catch (e) {
      _showFailureMessage(context, message: 'unknown error');
    }
  }

  void _showFailureMessage(BuildContext context, {required String message}) {
    setState(() {
      _sending = false;
    });
    showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(message);
        });
  }

  Future<void> _showSuccessfulMessage(
      Transaction transaction, BuildContext context) async {
    if (transaction != null) {
      setState(() {
        _sending = false;
      });
      await showDialog(
        context: context,
        builder: (contextDialog) {
          return SuccessDialog('successful transaction');
        },
      );
      Navigator.pop(context);
    }
  }
}
