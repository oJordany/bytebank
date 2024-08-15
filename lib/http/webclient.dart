import 'dart:convert';
import 'dart:developer';

import 'package:bytebank/http/interceptors/logger_interceptor.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

final Client client = InterceptedClient.build(
  interceptors: [LoggerInterceptor()],
  requestTimeout: Duration(seconds: 5),
);

const String baseUrl = 'http://localhost:8080/transactions';

