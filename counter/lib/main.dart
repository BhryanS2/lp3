import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);

  // This class is the configuration for the state.
  // It holds the values (in this case nothing) provided
  // by the parent and used by the build  method of the
  // State. Fields in a Widget subclass are always marked
  // "final".

  // const Counter({super.key});

  @override
  _Contador createState() => _Contador();
}

class _Contador extends State<Counter> {
  int _count = 0;

  void aumentarValor() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Aqui é a minha Appbar"),
      ),
      body: Center(
        child: Container(
          child: Text("Contador {$_count}\n"),
        ),
      ),
      floatingActionButton: Container(
        child: GestureDetector(
          child: Icon(Icons.add),
          onTap: aumentarValor,
        ),
        color: Colors.blue,
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Counter(),
    debugShowCheckedModeBanner: false,
  ));
}
