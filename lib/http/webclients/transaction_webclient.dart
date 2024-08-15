import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';

class TransactionWebclient {

  static final Map<int, String> _statusCodeResponses = {
    400: 'there was an error submitting transaction',
    401: 'authentication failed',
    409: 'transaction always exists',
  };

  Future<List<Transaction>> findAll() async {
    Uri uri = Uri.parse(baseUrl);
    final Response response = await client.get(uri);
    final List<dynamic> decodedJson = jsonDecode(response.body) is List<dynamic>
        ? jsonDecode(response.body)
        : [];
    final List<Transaction> transactions = decodedJson.map((dynamic json) => Transaction.fromJson(json))
      .toList();
    return transactions;
  }


  Future<Transaction> save(Transaction transaction, String password) async {

    final String transactionJson = jsonEncode(transaction.toJson());

    Uri uri = Uri.parse(baseUrl);
    final Response response = await client.post(uri, headers: {
      'Content-type': 'application/json',
      'password': password,
    }, body: transactionJson);

    if (response.statusCode == 200){
      Transaction responseTransaction = Transaction.fromJson(jsonDecode(response.body));
      return responseTransaction;
    }

    throw HttpException(_getMessage(response.statusCode));

  }

  String? _getMessage(int statusCode) {
    if(_statusCodeResponses.containsKey(statusCode)){
      return _statusCodeResponses[statusCode];
    }
    return 'Unknown error';
  }

}

class HttpException implements Exception{
  final String? message;

  HttpException(this.message);

  @override
  String toString() {
    return message ?? 'Unknown error';
  }

}