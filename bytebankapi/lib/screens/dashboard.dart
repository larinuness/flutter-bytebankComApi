import 'package:flutter/material.dart';

import 'contacts_list.dart';
import 'transaction_list.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text('Dashboard'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/bytebank_logo.png'),
          ),
          //singlechild pra deixar desligar os componentes
          //está no vertical pra deslizar pro lado
          //poderia ser um listview
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                //passa rota de lista de contatos pelo o onClick
                _FeatureItem('Transfer', Icons.monetization_on,
                    onClick: () => _showContactsList(context)),
                _FeatureItem('Transaction feed', Icons.description,
                    onClick: () => _showTransactionsList(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//função pra passa a rota de cada botão
void _showTransactionsList(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => TransactionsList()));
}

//função pra passa a rota de cada botão
void _showContactsList(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => ContactsList()));
}

//função pra reutilizar componente(os botões da dashboard)
class _FeatureItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function onClick;

  _FeatureItem(this.name, this.icon, {required this.onClick});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          //Tirou todo o conteudo do onTap e passa só a função, pra assim
          //cada widget ter sua rota especifica
          onTap: () => onClick(),
          child: Container(
            padding: EdgeInsets.all(8.0),
            height: 100,
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24.0,
                ),
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
