import 'package:app/aula_18_08/form.dart';
import 'package:app/aula_1_09/TelaSecundaria.dart';
import 'package:app/projeto_1_9/Home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  void navigate(BuildContext context, page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

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
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          // child:
          // criar side menu
          child: Container(
            child: Column(
              children: <Widget>[
                Builder(builder: (context) {
                  return MaterialButton(
                    child: const Text("Ir para formulário"),
                    padding: const EdgeInsets.all(15),
                    color: Colors.blue,
                    onPressed: () {
                      navigate(context, Forms());
                    },
                  );
                }),
                Builder(builder: (context) {
                  return MaterialButton(
                    onPressed: () {
                      navigate(
                        context,
                        TelaSecundaria(valor: "Tela secundária"),
                      );
                    },
                    color: Colors.red,
                    child: const Text("Tela Secundária"),
                  );
                }),
                Builder(builder: (context) {
                  return MaterialButton(
                    onPressed: () {
                      navigate(context, Home());
                    },
                    color: Colors.purple,
                    child: const Text("Projeto da aula 01/9"),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
      // home: Builder(
      //   builder: (context) => Center(
      //     child: RaisedButton(
      //       child: Text("Foo"),
      //       onPressed: () => Navigator.pushNamed(context, "/"),
      //     ),
      //   ),
      // ),
    );
  }
}
