import 'package:bytebank/components/custom_switch_widget.dart';
import 'package:bytebank/models/transfer.dart';
import 'package:bytebank/screens/transfer/form_page.dart';
import 'package:flutter/material.dart';

import '../../components/transfer/item_widget.dart';

const _appBarTitle = "Transferências";

class TransferList extends StatefulWidget {
  @override
  State<TransferList> createState() => _TransferListState();
}

class _TransferListState extends State<TransferList> {
  final List<Transfer> _transfers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
        actions: [
          CustomSwitch(),
        ],
      ),
      body: ListView.builder(
        itemCount: _transfers.length,
        itemBuilder: (context, index) {
          final transfer = _transfers[index];
          return TransferItem(transfer: transfer);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TransferForm()),
          )
          .then((receivedTransfer) => _refresh(receivedTransfer));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _refresh(receivedTransfer) {
    if (receivedTransfer != null) {
      setState(() {
        _transfers.add(receivedTransfer);
      });
    }
  }
}
