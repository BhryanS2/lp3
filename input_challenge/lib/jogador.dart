import 'package:flutter/material.dart';
import 'dart:math' as math;

// 2. Permita que o jogador 1 digite 4 números e o jogador 2, 4 números. Ao clicar no botão “Jogar dados”, defina aquele que ganhou (quem ganhará será aquele que tiver a maior soma dos 4 números). Se o jogador 1 vencer, insira abaixo do “Jogador 1 venceu” uma imagem 1 de sua preferência. Caso contrário, abaixo de “Jogador 2 venceu”, insira uma imagem 2 de sua preferência.

class Jogador extends StatefulWidget {
  const Jogador({
    Key? key,
  }) : super(key: key);

  @override
  State<Jogador> createState() => _JogadorState();
}

class _JogadorState extends State<Jogador> {
  int _counter = 0;
  String _textoResultado = "";
  TextEditingController _controllerNumbers = TextEditingController();
  List<String> _lista = [];
  int _somaJ1 = 0;
  int _somaJ2 = 0;
  String _resultado = "";
  bool _jogador = true;
  String _imageApp = 'images/img1.png';

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
              labelText: 'Digite um número jogador' + (_jogador ? ' 1' : ' 2'),
              labelStyle: TextStyle(color: Colors.orange[600]),
            ),
            style: TextStyle(color: Colors.orange[600]),
          ),
          RaisedButton(
            child: Text("Adicionar a lista"),
            onPressed: () {
              setState(() {
                _lista.add(_controllerNumbers.text);
                _counter++;
                if (_counter <= 4) {
                  _jogador = true;
                  _somaJ1 += int.parse(_controllerNumbers.text);
                } else {
                  _jogador = false;
                  _somaJ2 += int.parse(_controllerNumbers.text);
                }
                if (_counter > 8) {
                  if (_somaJ1 > _somaJ2) {
                    _resultado = "Jogador 1 venceu";
                    _imageApp = 'images/img1.png';
                  } else {
                    _resultado = "Jogador 2 venceu";
                    _imageApp = 'images/img2.png';
                  }
                }
                _controllerNumbers.text = '';
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
          Image(
            image: AssetImage(_imageApp),
            height: 100,
          ),
        ],
      ),
    );
  }
}
