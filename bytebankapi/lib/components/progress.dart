import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  final String message;

  Progress({this.message = "Carregando"});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            //grossura
            strokeWidth: 5.5,
            color: Colors.green[900],
          ),
          //separando espaço entre o cirgularprogress e o texto
          SizedBox(
            height: 10,
          ),
          Text(message),
        ],
      ),
    );
  }
}
