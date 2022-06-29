// import 'package:collection/material.dart';
import 'package:flutter/material.dart';

class Form extends StatefulWidget {
  const Form({Key? key}) : super(key: key);

  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<Form> {
  TextEditingController _controllerNumbers = TextEditingController();
  List<String> _lista = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // show list
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _lista.map((item) {
              return Padding(
                padding: EdgeInsets.all(8),
                child: Chip(
                  label: Text(item),
                  backgroundColor: Colors.orange[600],
                ),
              );
            }).toList(),
          ),
        ),
        Row(
          children: [
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
            )
          ],
        ),
        RaisedButton(
          child: Text("Médio"),
          onPressed: () {},
        ),
        RaisedButton(
          child: Text("Menor"),
          onPressed: () {},
        ),
        RaisedButton(
          child: Text("Soma"),
          onPressed: () {},
        ),
        RaisedButton(
          child: Text("Limpar"),
          onPressed: () {
            setState(() {
              _lista.clear();
            });
          },
        ),
      ],
    );
  }
}
