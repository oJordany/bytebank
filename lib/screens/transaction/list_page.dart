import 'package:bytebank/components/centered_message.dart';
import 'package:bytebank/components/custom_switch_widget.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionsListPage extends StatelessWidget {
  final TransactionWebclient _webclient = TransactionWebclient();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
        actions: [
          CustomSwitch(),
        ],
      ),
      body: FutureBuilder<List<Transaction>>(
        initialData: [],
        future: _webclient.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if(snapshot.hasData){
                final List<Transaction>? transactions = snapshot.data;
                if (transactions!.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final Transaction transaction = transactions![index];
                      return Card(
                        child: ListTile(
                          leading: Icon(Icons.monetization_on),
                          title: Text(
                            transaction.value.toString(),
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            transaction.contact.accountNumber.toString(),
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: transactions?.length,
                  );
                }
              }
              return CenteredMessage(
                'No Transactions Found',
                icon: Icons.warning,
              );
          }
          return CenteredMessage('Unknown Error');
        },
      ),
    );
  }
}
