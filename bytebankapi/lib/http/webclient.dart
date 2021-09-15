import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import '../models/contact.dart';
import '../models/transaction.dart';

Future<List<Transaction>> findAll() async {
  final Client client =
      InterceptedClient.build(interceptors: [LoggingInterceptor()]);
  final Response response =
      await client.get(Uri.parse('http://localhost:8080/transactions'));
  //decodificou o json pra criar uma lista de transactions
  final List<dynamic> decodedJson = jsonDecode(response.body);
  //criar lista vazia
  final List<Transaction> transactions = [];
  //varreu o json decodificado
  for (Map<String, dynamic> transactionJson in decodedJson) {
    final Map<String, dynamic> contactJson = transactionJson['contact'];
    //para cada um dos elementos, cria uma transaction
    //criada a a partir do valor que vem do value
    final Transaction transaction = Transaction(
        transactionJson['value'],
        //criar contato pra transaction
        Contact(0, transactionJson['contact']['name'],
            transactionJson['contact']['accountNumber']));
    transactions.add(transaction);
  }
  return transactions;
}

//interceptor fica de olho em todas as requisições, mostra todos os detalhe do request e response
class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    //deixando mais print pra por vizualizar melhor
    print('Request');
    print('url: ${data.url}');
    print('body: ${data.body}');
    print('headers: ${data.headers}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print('Reponse');
    print('body: ${data.body}');
    print('headers: ${data.headers}');
    print('status: ${data.statusCode}');
    return data;
  }
}
