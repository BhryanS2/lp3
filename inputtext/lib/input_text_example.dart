import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aprendendo Text Input')),
      body: Container(
        child: const TextField(
          // keyboardType: KeyboardLockMode,
          decoration: InputDecoration(labelText: "aaaaaaaaaaaaaaaaaaaa"),
          // enabled: false,
          // maxLength: 5,
          // maxLengthEnforced:false,
          style: TextStyle(fontSize: 25, color: Colors.blue),
          // obscureText: true, // esconde o texto -> senha

          // events
          // onChanged: ,
          // onSubmitted

          // controler
          // controller: _var,
        ),
      ),
    );
  }
}
