import 'package:flutter/material.dart';

class Prova extends StatefulWidget {
  @override
  _ProvaState createState() => _ProvaState();
}

class _ProvaState extends State<Prova> {
  String _imageApp = 'images/img1.png';
  int _soma = 0;
  List<TextEditingController> _controller = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Bhryan, feito para codar!'),
          backgroundColor: Colors.green,
        ),
        body: Container(
            child: SingleChildScrollView(
          child: Center(
            child: Column(children: <Widget>[
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Entre com um número: ',
                  labelStyle: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                style: const TextStyle(
                  color: Colors.blue,
                ),
                keyboardType: TextInputType.number,
                controller: _controller[0],
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Entre com um número: ',
                  labelStyle: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                style: const TextStyle(
                  color: Colors.blue,
                ),
                keyboardType: TextInputType.number,
                controller: _controller[1],
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Entre com um número: ',
                  labelStyle: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                style: const TextStyle(
                  color: Colors.blue,
                ),
                keyboardType: TextInputType.number,
                controller: _controller[2],
              ),
              RaisedButton(
                onPressed: () {
                  // verificar soma dos dois maiores números
                  List<int> _lista = [];
                  for (int i = 0; i < _controller.length; i++) {
                    _lista.add(int.parse(_controller[i].text));
                  }
                  _lista.sort();
                  setState(() {
                    _soma = _lista[1] + _lista[2];
                    int image = _soma < 50 ? 1 : 2;
                    _imageApp = 'images/img${image}.png';
                  });
                  // se soma maior que 50, mostrar imagem 1
                  // se soma menor ou igual a 50, mostrar imagem 2
                },
                child: Text('Calcular'),
              ),
              Text("Soma: $_soma"),
              // imagem
              Image(
                image: AssetImage(_imageApp),
                height: 100,
              ),
            ]),
          ),
        )));
  }
}
