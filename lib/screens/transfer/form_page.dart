import 'package:bytebank/components/custom_switch_widget.dart';
import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/components/transfer/editor_widget.dart';
import 'package:bytebank/models/transfer.dart';
import 'package:flutter/material.dart';

const _appBarTitle = 'Criando Transferência';
const _valueFieldLabel = 'Valor';
const _valueFieldTip = '0.00';
const _numberAccountFieldTip = '0000';
const _numberAccountFieldLabel = 'Número da Conta';
const _confirmButtonText = "Confirmar";

class TransferForm extends StatefulWidget {
  @override
  State<TransferForm> createState() => _TransferFormState();
}

class _TransferFormState extends State<TransferForm> {
  final TextEditingController _accountNumberFieldController =
      TextEditingController();

  final TextEditingController _valueFieldController = TextEditingController();

  void _criaTransferencia(BuildContext context) {
    final int accountNumber = int.tryParse(_accountNumberFieldController.text)!;
    final double value = double.tryParse(_valueFieldController.text)!;

    final createdTransfer =
        Transfer(value: value, accountNumber: accountNumber);
    Navigator.pop(context, createdTransfer);
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
        actions: [
          CustomSwitch(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              controller: _accountNumberFieldController,
              label: _numberAccountFieldLabel,
              tip: _numberAccountFieldTip,
            ),
            Editor(
              controller: _valueFieldController,
              label: _valueFieldLabel,
              tip: _valueFieldTip,
              icon: Icons.monetization_on,
            ),
            ElevatedButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) {
                  return TransactionAuthDialog(
                    onConfirm: (password) => print(password),
                  );
                },
              ),
              child: Text(
                _confirmButtonText,
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
