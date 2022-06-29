// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'dart:math' as math;

class Numeros extends StatefulWidget {
  const Numeros({
    Key? key,
  }) : super(key: key);

  @override
  State<Numeros> createState() => _NumerosState();
}

class _NumerosState extends State<Numeros> {
  int _counter = 0;
  String _textoResultado = "";
  TextEditingController _controllerNumbers = TextEditingController();
  List<String> _lista = [];
  String _resultado = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Números"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // show _lista
          Expanded(
            child: ListView.builder(
              itemCount: _lista.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [Text(_lista[index])],
                );
              },
            ),
          ),
          TextField(
            controller: _controllerNumbers,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Digite um número',
              labelStyle: TextStyle(color: Colors.orange[600]),
            ),
            style: TextStyle(color: Colors.orange[600]),
          ),
          RaisedButton(
            child: Text("Adicionar a lista"),
            onPressed: () {
              setState(() {
                _lista.add(_controllerNumbers.text);
                _controllerNumbers.text = '';
              });
            },
          ),
          Row(
            children: <Widget>[
              RaisedButton(
                child: Text("Maior"),
                onPressed: () {
                  setState(() {
                    _lista.sort();
                    _resultado = _lista[_lista.length - 1];
                  });
                },
              ),
              RaisedButton(
                child: Text("Médio"),
                onPressed: () {
                  setState(() {
                    _lista.sort();
                    //  arround ceil
                    int meio = _lista.length ~/ 2;
                    _resultado = _lista[meio];
                  });
                },
              ),
              RaisedButton(
                child: Text("Menor"),
                onPressed: () {
                  setState(() {
                    _lista.sort();
                    _resultado = _lista[0];
                  });
                },
              ),
            ],
          ),
          RaisedButton(
            child: Text("Soma"),
            onPressed: () {
              setState(() {
                _lista.sort();
                int soma = 0;
                for (int i = 0; i < _lista.length; i++) {
                  soma += int.parse(_lista[i]);
                }
                _resultado = soma.toString();
              });
            },
          ),
          RaisedButton(
            child: Text("Limpar"),
            onPressed: () {
              setState(() {
                _lista.clear();
              });
            },
          ),
          Text("Resultado: $_resultado"),
        ],
      ),
    );
  }
}
