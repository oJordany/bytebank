import 'package:bytebank/models/transfer.dart';
import 'package:flutter/material.dart';

class TransferItem extends StatelessWidget {
  final Transfer _transfer;

  const TransferItem({super.key, required Transfer transfer}) : _transfer = transfer;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text('R\$${_transfer.value.toStringAsFixed(2)}'),
        subtitle: Text(_transfer.accountNumber.toString()),
      ),
    );
  }
}