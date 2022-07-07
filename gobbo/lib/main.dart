import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Guilherme Gobbo'),
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
  int _a = 0;
  int _b = 0;
  int _c = 0;
  var _valor = 0;
  String _imagem1 = "images/img1.png";

  void setAleatorios() {
    setState(() {
      _a = math.Random().nextInt(100);
      _b = math.Random().nextInt(100);
      _c = math.Random().nextInt(100);
    });
  }

  void updateImage() {
    setState(() {
      if (_imagem1 == "images/img1.png") {
        _imagem1 = "images/img2.png";
      } else {
        _imagem1 = "images/img1.png";
      }
    });
  }

  void maiorNumero() {
    setState(() {
      if (_a > _b && _a > _c) {
        _valor = _a;
      } else if (_b > _a && _b > _c) {
        _valor = _b;
      } else {
        _valor = _c;
      }
    });
  }

  void menorNumero() {
    setState(() {
      if (_a < _b && _a < _c) {
        _valor = _a;
      } else if (_b < _a && _b < _c) {
        _valor = _b;
      } else {
        _valor = _c;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.green,
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Text("$_a"),
                  Text("$_b"),
                  Text("$_c"),
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              ),
              Image(
                image: AssetImage(_imagem1),
                height: 100,
              ),
              Text("$_valor"),
              RaisedButton(
                child: Text("Maior"),
                onPressed: () {
                  setAleatorios();
                  maiorNumero();
                  updateImage();
                },
                color: Colors.green,
              ),
              RaisedButton(
                child: Text("Menor"),
                onPressed: () {
                  setAleatorios();
                  menorNumero();
                  updateImage();
                },
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
