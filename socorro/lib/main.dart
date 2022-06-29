import 'package:flutter/material.dart';
import 'dart:math' as math;

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
      home: const MyHomePage(title: 'Bhryan E grande Caruzo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Title extends StatelessWidget {
  const Title({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        title,
        style: TextStyle(color: Colors.blue, fontSize: 30),
      ),
    );
  }
}

class Paragraph extends StatelessWidget {
  const Paragraph({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        text,
        style: TextStyle(color: Colors.black, fontSize: 25),
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> _list = [0, 0, 0];
  int _selectedNumber = 0;
  String _imagePath = 'images/img1.png';

  void setNumerosRandomicos() {
    var random = math.Random();
    setState(() {
      _list = List<int>.generate(3, (i) => random.nextInt(100));
      _imagePath = _imagePath == 'images/img1.png'
          ? 'images/img2.png'
          : 'images/img1.png';
      _list.sort();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Title(title: 'Números aleatórios'),
            Row(
              children: [
                Paragraph(
                  text: '${_list[0]}',
                ),
                Paragraph(
                  text: '${_list[1]}',
                ),
                Paragraph(
                  text: '${_list[2]}',
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
            Padding(
                padding: EdgeInsets.all(16),
                child: Image(
                  image: AssetImage(_imagePath),
                  height: 100,
                )),
            Title(title: "Resultado"),
            Paragraph(
              text: "$_selectedNumber",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setNumerosRandomicos();
                    setState(() {
                      _selectedNumber = _list[0];
                    });
                  },
                  child: Container(
                    width: 100,
                    height: 50,
                    color: Colors.purple,
                    child: Center(
                      child: Text(
                        'Menor',
                        style:
                            TextStyle(color: Colors.green[500], fontSize: 30),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setNumerosRandomicos();
                    setState(() {
                      _selectedNumber = _list[2];
                    });
                  },
                  child: Container(
                    width: 100,
                    height: 50,
                    color: Colors.purple,
                    child: Center(
                      child: Text(
                        'Maior',
                        style:
                            TextStyle(color: Colors.green[500], fontSize: 30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
