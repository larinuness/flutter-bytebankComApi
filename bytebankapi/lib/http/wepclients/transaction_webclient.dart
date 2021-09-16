import 'dart:convert';
import 'package:http/http.dart';
import '../../models/transaction.dart';
import '../webclient.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response =
        //timeout pra não ficar com loading infinito se der erro na api
        await client
            .get(Uri.parse('http://localhost:8080/transactions'))
            .timeout(Duration(seconds: 5));
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction> save(Transaction transaction) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    final Response response =
        await client.post(Uri.parse('http://localhost:8080/transactions'),
            headers: {
              'Content-type': 'application/json',
              'password': '1000',
            },
            body: transactionJson);

    return Transaction.fromJson(jsonDecode(response.body));
  }
}
