import '../components/centered_message.dart';
import '../http/wepclients/transaction_webclient.dart';
import 'package:flutter/material.dart';

import '../components/progress.dart';
import '../models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final TransactionWebClient _webClient = TransactionWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Transactions'), backgroundColor: Colors.green[900]),
      body: FutureBuilder<List<Transaction>>(
          future: Future.delayed(Duration(seconds: 1))
              .then((value) => _webClient.findAll()),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Progress();
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                //faz a checkagem se vai ter dado, se vai vir nulo ou não
                if (snapshot.hasData) {
                  final List<Transaction>? transactions = snapshot.data;
                  //faz a checkagem se não vai estar vazio
                  if (transactions!.isNotEmpty) {
                    return
                        //.builder poque não sabe quantos itens vai ter
                        ListView.builder(
                      itemBuilder: (context, index) {
                        final Transaction transaction = transactions[index];
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
                      itemCount: transactions.length,
                    );
                  }
                  return CenteredMessage('Nenhuma transação encontrada',
                      icon: Icons.warning);
                }
            }
            return CenteredMessage('Erro desconhecido', icon: Icons.warning);
          }),
    );
  }
}
