// import 'package:app/aula_11_08/CampoDeText.dart';
// import 'package:app/aula_11_08/EntradaSlider.dart';
// import 'package:app/aula_11_08/EntradaSwitch.dart';
import 'package:app/projeto_11_08/index.dart';
// import 'package:app/aula_11_08/RadioButton.dart';
import 'package:flutter/material.dart';

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
        primarySwatch: Colors.blue,
      ),
      //home: CampoTextoNovo()
      // home: EntradaRadioButton(),
      // home: EntradaSwitch(),
      // home: EntradaSlider(),
      home: EntradaDeDados(),
    );
  }
}
