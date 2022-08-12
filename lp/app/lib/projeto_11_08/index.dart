import 'package:flutter/material.dart';

class EntradaDeDados extends StatefulWidget {
  const EntradaDeDados({Key? key}) : super(key: key);

  @override
  _EntradaDeDadosState createState() => _EntradaDeDadosState();
}

class _EntradaDeDadosState extends State<EntradaDeDados> {
  int? _escolhaUsuario = 0;
  bool? _checkBoxValue = false;

  void setRadioValue(int? valor) {
    setState(() {
      _escolhaUsuario = valor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Entrada de dados"),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Seu nome"),
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),

          // Escolha da imagem
          Column(
            children: <Widget>[
              RadioListTile(
                title: const Text("Masculino"), //titulo da lista
                value: 1, //tipo do valor do campo
                groupValue: _escolhaUsuario, // tipo do grupo
                onChanged: (int? escolha) {
                  setState(() {
                    _escolhaUsuario = escolha;
                  });
                },
              ),
              RadioListTile(
                value: 2,
                groupValue: _escolhaUsuario,
                onChanged: setRadioValue,
                title: Text("Feminino"),
              )
            ],
          ),
          // ACeita notificações
          SwitchListTile(
            title: const Text("Aceita notificações"),
            value: _escolhaUsuario == 1,
            onChanged: (bool valor) {
              setState(() {
                _escolhaUsuario = valor ? 1 : 0;
              });
            },
          ),
          CheckboxListTile(
            title: const Text("Aceita notificações"),
            value: _escolhaUsuario == 1,
            onChanged: (bool? valor) {
              setState(() {
                _checkBoxValue = !valor;
              });
            },
          ),
          // Botão de salvar
          MaterialButton(
            onPressed: () {
              print("valor escolhido: " + _escolhaUsuario.toString());
            },
            child: Text("Salvar", style: TextStyle(color: Colors.white)),
            color: Colors.blue,
          )
        ],
      ),
    );
  }
}
