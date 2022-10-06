// Gláucia Eduarda do Amorim Silva & Julio Nunes Avelar

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
      home: const MyHomePage(title: 'Gláucia Amorim e Julio Nunes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _codigo = TextEditingController();
  TextEditingController _nome = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _matricula = TextEditingController();
  TextEditingController _idade = TextEditingController();
  TextEditingController _nota = TextEditingController();
  String _data = "";

  Future<Database> _recuperarBancoDados() async {
    final caminhoBancoDados =
        await getDatabasesPath(); //recupera o caminho do banco no celular do usuario
    final localBancoDados = join(caminhoBancoDados,
        "glauciajulio.db"); // nome do banco de dados a ser recuperado/utilizado

    var bd = await openDatabase(localBancoDados, // Banco de dados utilizado
        version: 1, //Eu crio a versao de acordo com meu APP
        onCreate: (db, dbVersaoRecente) {
      //db permite manipular o banco
      String sql =
          "CREATE TABLE usuarios (id INTEGER PRIMARY KEY AUTOINCREMENT, nome VARCHAR(100), email VARCHAR(100), matricula VARCHAR(100), idade INTEGER, nota INTEGER )";
      db.execute(sql);
    });

    return bd;
  }

  Future<void> _salvar() async {
    Database bd = await _recuperarBancoDados();
    Map<String, dynamic> dadosUsuario = {
      "nome": _nome.text,
      "email": _email.text,
      "matricula": _matricula.text,
      "idade": int.parse(_idade.text),
      "nota": int.parse(_nota.text)
    };
    int id = await bd.insert("usuarios", dadosUsuario);
    print("Salvo: $id ");

    setState(() {
      _data = "item id: " +
          id.toString() +
          "\n" +
          "nome: " +
          _nome.text +
          "\n" +
          "email: " +
          _email.text +
          "\n" +
          "matricula: " +
          _matricula.text +
          "\n" +
          "idade: " +
          _idade.text +
          "\n" +
          "nota: " +
          _nota.text +
          "\n";
    });
  }

  Future<void> _listarUsuarios() async {
    Database bd = await _recuperarBancoDados();
    String sql = "SELECT * FROM usuarios "; //ASC, DESC
    List usuarios = await bd.rawQuery(sql);

    setState(() {
      _data = "";
    });

    for (var usuario in usuarios) {
      print("item id: " +
          usuario['id'].toString() +
          ", nome: " +
          usuario['nome'] +
          ", email: " +
          usuario['email'] +
          ", matricula: " +
          usuario['matricula'] +
          ", idade: " +
          usuario['idade'].toString() +
          ", nota: " +
          usuario['nota'].toString());

      setState(() {
        _data += "item id: " +
            usuario['id'].toString() +
            "\n" +
            "nome: " +
            usuario['nome'] +
            "\n" +
            "email: " +
            usuario['email'] +
            "\n" +
            "matricula: " +
            usuario['matricula'] +
            "\n" +
            "idade: " +
            usuario['idade'].toString() +
            "\n" +
            "nota: " +
            usuario['nota'].toString() +
            "\n\n";
      });
    }
  }

  Future<void> _listarUsuarioPeloId() async {
    int codigoint = int.parse(_codigo.text);
    Database bd = await _recuperarBancoDados();
    //CRUD -> Create, Read, Update and Delete
    List usuarios = await bd.query("usuarios",
        columns: ["id", "nome", "email", "matricula", "idade", "nota"],
        where: "id = ?",
        whereArgs: [codigoint]);

    setState(() {
      _data = "";
    });

    for (var usuario in usuarios) {
      print("item id: " +
          usuario['id'].toString() +
          ", nome: " +
          usuario['nome'] +
          ", email: " +
          usuario['email'] +
          ", matricula: " +
          usuario['matricula'] +
          ", idade: " +
          usuario['idade'].toString() +
          ", nota: " +
          usuario['nota'].toString());
      _nome.text = usuario['nome'];
      _email.text = usuario['email'];
      _matricula.text = usuario['matricula'];
      _idade.text = usuario['idade'].toString();
      _nota.text = usuario['nota'].toString();

      setState(() {
        _data = "item id: " +
            usuario['id'].toString() +
            "\n" +
            "nome: " +
            usuario['nome'] +
            "\n" +
            "email: " +
            usuario['email'] +
            "\n" +
            "matricula: " +
            usuario['matricula'] +
            "\n" +
            "idade: " +
            usuario['idade'].toString() +
            "\n" +
            "nota: " +
            usuario['nota'].toString() +
            "\n";
      });
    }
  }

  Future<void> _listarUsuarioPelaMatricula() async {
    Database bd = await _recuperarBancoDados();
    //CRUD -> Create, Read, Update and Delete
    List usuarios = await bd.query("usuarios",
        columns: ["id", "nome", "email", "matricula", "idade", "nota"],
        where: "matricula = ?",
        whereArgs: [_matricula.text]);

    setState(() {
      _data = "";
    });

    for (var usuario in usuarios) {
      print("item id: " +
          usuario['id'].toString() +
          ", nome: " +
          usuario['nome'] +
          ", email: " +
          usuario['email'] +
          ", matricula: " +
          usuario['matricula'] +
          ", idade: " +
          usuario['idade'].toString() +
          ", nota: " +
          usuario['nota'].toString());
      _nome.text = usuario['nome'];
      _email.text = usuario['email'];
      _matricula.text = usuario['matricula'];
      _idade.text = usuario['idade'].toString();
      _nota.text = usuario['nota'].toString();

      setState(() {
        _data = "item id: " +
            usuario['id'].toString() +
            "\n" +
            "nome: " +
            usuario['nome'] +
            "\n" +
            "email: " +
            usuario['email'] +
            "\n" +
            "matricula: " +
            usuario['matricula'] +
            "\n" +
            "idade: " +
            usuario['idade'].toString() +
            "\n" +
            "nota: " +
            usuario['nota'].toString() +
            "\n";
      });
    }
  }

  Future<void> _excluirUsuario() async {
    int codigoint = int.parse(_codigo.text);
    Database bd = await _recuperarBancoDados();
    int retorno =
        await bd.delete("usuarios", where: "id = ?", whereArgs: [codigoint]);
    print("item qtde removida: $retorno");
    setState(() {
      _data = "";
    });
  }

  Future<void> _atualizarUsuario() async {
    int codigoint = int.parse(_codigo.text);
    Database bd = await _recuperarBancoDados();
    Map<String, dynamic> dadosUsuario = {
      "nome": _nome.text,
      "email": _email.text,
      "matricula": _matricula.text,
      "idade": int.parse(_idade.text),
      "nota": int.parse(_nota.text)
    };
    int retorno = await bd.update("usuarios", dadosUsuario,
        where: "id = ?", whereArgs: [codigoint]);
    print("item qtde atualizada: $retorno");

    setState(() {
      _data = "item id: " +
          _codigo.text +
          "\n" +
          "nome: " +
          _nome.text +
          "\n" +
          "email: " +
          _email.text +
          "\n" +
          "matricula: " +
          _matricula.text +
          "\n" +
          "idade: " +
          _idade.text +
          "\n" +
          "nota: " +
          _nota.text +
          "\n";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: SingleChildScrollView(
          //cria barra de rolagem da tela toda//column//utilizado quando temos muito conteúdo na tela
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .stretch, // faz com que os componentes da tela ocupem a tela toda na horizontal, inclusive o botão.
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 10), //espaçamento inferior
                child: Text(
                  "Exercício Cadastro de Usuários",
                  style: TextStyle(
                      //formataçãoo de fonte
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextField(
                keyboardType:
                    TextInputType.number, //caixa de número somente com .
                decoration:
                    InputDecoration(labelText: "Código" //texto padrão do campo
                        ),
                style: TextStyle(
                    //formatação da fonte
                    fontSize: 22),
                controller: _codigo, //pegando valor do campo alcool
              ),
              TextField(
                keyboardType:
                    TextInputType.text, //caixa de número somente com .
                decoration:
                    InputDecoration(labelText: "Nome:" //texto padrão do campo
                        ),
                style: TextStyle(fontSize: 22),
                controller: _nome, //pegando valor do campo gasolina
              ),
              TextField(
                keyboardType:
                    TextInputType.text, //caixa de número somente com .
                decoration:
                    InputDecoration(labelText: "Email:" //texto padrão do campo
                        ),
                style: TextStyle(fontSize: 22),
                controller: _email, //pegando valor do campo gasolina
              ),
              TextField(
                keyboardType:
                    TextInputType.number, //caixa de número somente com .
                decoration: InputDecoration(
                    labelText: "Matricula:" //texto padrão do campo
                    ),
                style: TextStyle(fontSize: 22),
                controller: _matricula, //pegando valor do campo gasolina
              ),
              TextField(
                keyboardType:
                    TextInputType.number, //caixa de número somente com .
                decoration:
                    InputDecoration(labelText: "Idade:" //texto padrão do campo
                        ),
                style: TextStyle(fontSize: 22),
                controller: _idade, //pegando valor do campo gasolina
              ),
              TextField(
                keyboardType:
                    TextInputType.number, //caixa de número somente com .
                decoration:
                    InputDecoration(labelText: "Nota:" //texto padrão do campo
                        ),
                style: TextStyle(fontSize: 22),
                controller: _nota, //pegando valor do campo gasolina
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10), //espaçamento superior
                  child: ElevatedButton(
                      child: Text('Salvar'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        onPrimary: Colors.white,
                        shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                      ),
                      onPressed: _salvar)),
              Padding(
                  padding: EdgeInsets.only(top: 10), //espaçamento superior
                  child: ElevatedButton(
                      child: Text('Alterar'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        onPrimary: Colors.white,
                        shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                      ),
                      onPressed: _atualizarUsuario)),
              Padding(
                  padding: EdgeInsets.only(top: 10), //espaçamento superior
                  child: ElevatedButton(
                      child: Text('Excluir'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        onPrimary: Colors.white,
                        shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                      ),
                      onPressed: _excluirUsuario)),
              Padding(
                  padding: EdgeInsets.only(top: 10), //espaçamento superior
                  child: ElevatedButton(
                      child: Text('Consultar'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        onPrimary: Colors.white,
                        shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                      ),
                      onPressed: _listarUsuarioPeloId)),
              Padding(
                  padding: EdgeInsets.only(top: 10), //espaçamento superior
                  child: ElevatedButton(
                      child: Text('Consultar pela Matricula'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        onPrimary: Colors.white,
                        shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                      ),
                      onPressed: _listarUsuarioPelaMatricula)),
              Padding(
                  padding: EdgeInsets.only(top: 10), //espaçamento superior
                  child: ElevatedButton(
                      child: Text('Listar Usuarios'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        onPrimary: Colors.white,
                        shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                      ),
                      onPressed: _listarUsuarios)),
              Text(
                _data,
                style: TextStyle(
                    //formataçãoo de fonte
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
