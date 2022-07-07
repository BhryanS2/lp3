import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Greg cabeludo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _n1 = 0;
  int _n2 = 0;
  int _n3 = 0;
  int _resultado = 0;
  String _nomeImagem = 'img1.png';

  void definirNumerosAleatorios() {
    setState(() {
      _n1 = Random().nextInt(100);
      _n2 = Random().nextInt(100);
      _n3 = Random().nextInt(100);
      if (_nomeImagem == 'img1.png') {
        _nomeImagem = "img2.png";
      } else {
        _nomeImagem = "img1.png";
      }
    });
  }

  void maiorNumero() {
    definirNumerosAleatorios();
    int comparacao = _n1;
    if (comparacao < _n2) {
      comparacao = _n2;
    }
    if (comparacao < _n3) {
      comparacao = _n3;
    }

    setState(() {
      _resultado = comparacao;
    });
  }

  void somaNumeros() {
    definirNumerosAleatorios();
    setState(() {
      _resultado = _n1 + _n2 + _n3;
    });
  }

  void menorNumero() {
    definirNumerosAleatorios();
    int comparacao = _n1;
    if (comparacao > _n2) {
      comparacao = _n2;
    }
    if (comparacao > _n3) {
      comparacao = _n3;
    }

    setState(() {
      _resultado = comparacao;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Center(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Números aleátorios",
                style: TextStyle(color: Colors.blue, fontSize: 32),
              ),
            ),
            Row(
              children: [
                Text(
                  "$_n1",
                  style: TextStyle(color: Colors.blue, fontSize: 24),
                ),
                Text(
                  "$_n2",
                  style: TextStyle(color: Colors.blue, fontSize: 24),
                ),
                Text(
                  "$_n3",
                  style: TextStyle(color: Colors.blue, fontSize: 24),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Image(
                // Para colocar uma imagem altere o pubspec.yml
                image: AssetImage("imagens/$_nomeImagem"),
                height: 100,
              ),
            ),
            Text(
              "$_resultado",
              style: TextStyle(color: Colors.blue, fontSize: 24),
            ),
            Row(
              children: [
                RaisedButton(
                  onPressed: menorNumero,
                  child: Text("Menor"),
                  color: Colors.blue,
                ),
                RaisedButton(
                  onPressed: maiorNumero,
                  child: Text("Maior"),
                  color: Colors.blue,
                ),
                RaisedButton(
                  onPressed: somaNumeros,
                  child: Text("Soma"),
                  color: Colors.blue,
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
          ],
        )),
      ),
    );
  }
}
