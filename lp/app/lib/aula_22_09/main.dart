// @dart=2.9

//foi necessaario inserir a linha acima para o coodigo funcionar.

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

//Criar Conexao com banco de dados
//Adicionar  sqflite: logo abaixo de  cupertino_icons: ^1.0.2 no pubspec.yaml proximo da linha 35
//Adicionar os imports
//import 'package:sqflite/sqflite.dart';
//import 'package:path/path.dart';

void main() => runApp(
      const MaterialApp(
        home: Home(),
      ),
    );

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //async determina que um metodo sera assincrono, nao retornara algo imediato
  //await serve para mostrar que o app deve esperar uma resposta antes de continuar.
  // determina que uma funcao ira retornar algo no futuro. Levara um tempo para ser executada.
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerAge = TextEditingController();
  int _id = 0;
  String _name = '';
  int _age = 0;

  _recuperarBancoDados() async {
    final caminhoBancoDados = await getDatabasesPath();

    //recupera o caminho do banco no celular do usuario
    final localBancoDados = path.join(caminhoBancoDados, "banco.db");
    // nome do banco de dados a ser recuperado/utilizado

    var db = await openDatabase(
      localBancoDados, // Banco de dados utilizado
      version: 1, //Eu crio a versao de acordo com meu APP
      onCreate: (db, dbVersaoRecente) async {
        //db permite manipular o banco
        String sql =
            "CREATE TABLE usuarios (id INTEGER PRIMARY KEY AUTOINCREMENT, nome VARCHAR, idade INTEGER) ";
        db.execute(sql);
      },
    );

    return db;
  }

  _salvar() async {
    Database bd = await _recuperarBancoDados();

    Map<String, dynamic> dadosUsuario = {"nome": "Usuário Teste", "idade": 30};

    // exists
    String sql =
        "SELECT * FROM usuarios WHERE nome = '${dadosUsuario['nome']}'";
    var user = await bd.rawQuery(sql);
    if (user.isEmpty) {
      int id = await bd.insert("usuarios", dadosUsuario);
      setState(() {
        _id = id;
        _name = _controllerName.text;
        _age = int.parse(_controllerAge.text);
      });
    } else {
      setState(() {
        _id = user[0]['id'];
      });
    }
  }

  _listarUsuarios() async {
    Database bd = await _recuperarBancoDados();

    //String sql = "SELECT * FROM usuarios WHERE id = 5 ";
    //String sql = "SELECT * FROM usuarios WHERE idade >= 30 AND idade <= 58";
    //String sql = "SELECT * FROM usuarios WHERE idade BETWEEN 18 AND 46 ";
    //String sql = "SELECT * FROM usuarios WHERE idade IN (18,30) ";
    //String filtro = "an";
    //String sql = "SELECT * FROM usuarios WHERE nome LIKE '%" + filtro + "%' ";
    //String sql = "SELECT *, UPPER(nome) as nomeMaiu FROM usuarios WHERE 1=1 ORDER BY UPPER(nome) DESC ";//ASC, DESC
    //String sql = "SELECT *, UPPER(nome) as nomeMaiu FROM usuarios WHERE 1=1 ORDER BY idade DESC LIMIT 3";//ASC, DESC
    String sql = "SELECT * FROM usuarios "; //ASC, DESC
    List usuarios = await bd.rawQuery(sql);

    for (var usuario in usuarios) {
      // print("item id: " +
      //     usuario['id'].toString() +
      //     " nome: " +
      //     usuario['nome'] +
      //     " idade: " +
      //     usuario['idade'].toString());
      print(
          "item id: ${usuario['id']}, nome: ${usuario['nome']}, idade: ${usuario['idade']}");
    }

    //print("usuarios: " + usuarios.toString() );
  }

  _listarUsuarioPeloId(int id) async {
    Database bd = await _recuperarBancoDados();

    //CRUD -> Create, Read, Update and Delete
    List usuarios = await bd.query("usuarios",
        columns: ["id", "nome", "idade"], where: "id = ?", whereArgs: [id]);

    for (var usuario in usuarios) {
      print(
          "item id: ${usuario['id']}, nome: ${usuario['nome']}, idade: ${usuario['idade']}");
    }

    setState(() {
      _id = usuarios[0]['id'];
      _name = usuarios[0]['nome'];
      _age = usuarios[0]['idade'];
    });
  }

  _excluirUsuario(int id) async {
    Database bd = await _recuperarBancoDados();

    int retorno = await bd.delete("usuarios",
        /*where: "id = ?",
      whereArgs: [id]*/
        where: " nome = ? AND idade = ?",
        whereArgs: ["Pedro Eavangelista", 40]);

    print("item qtde removida: $retorno");
    setState(() {
      _id = 0;
      _name = '';
      _age = 0;
      _controllerAge.text = "";
      _controllerName.text = "";
    });
  }

  _atualizarUsuario(int id) async {
    Database bd = await _recuperarBancoDados();

    Map<String, dynamic> dadosUsuario = {
      "nome": _controllerName.text,
      "idade": _controllerAge.text
    };
    int retorno = await bd
        .update("usuarios", dadosUsuario, where: "id = ?", whereArgs: [id]);

    print("item qtde atualizada: $retorno");
    setState(() {
      _name = _controllerName.text;
      _age = int.parse(_controllerAge.text);
    });
  }

  _salvarDados() async {
    Database bd = await _recuperarBancoDados();

    Map<String, dynamic> dadosUsuario = {
      "nome": _controllerName.text,
      "idade": _controllerAge.text
    };
    int id = await bd.insert("usuarios", dadosUsuario);
    setState(() {
      _id = id;
      _name = _controllerName.text;
      _age = int.parse(_controllerAge.text);
    });
    print("Salvo: $id ");
  }

  @override
  Widget build(BuildContext context) {
    // _salvar();
    //_excluirUsuario(2);
    //_atualizarUsuario(3);
    // _listarUsuarios();
    //_listarUsuarioPeloId(2);

    return Scaffold(
      appBar: AppBar(
        title: Text("Banco de Dados"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text("Id: $_id"),
              Text("Nome: $_name"),
              Text("Idade: $_age"),
              TextField(
                decoration: InputDecoration(labelText: "Nome"),
                controller: _controllerName,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Idade"),
                controller: _controllerAge,
              ),
              RaisedButton(
                child: Text("Salvar"),
                onPressed: () {
                  _salvarDados();
                },
              ),
              RaisedButton(
                child: Text("Alterar"),
                onPressed: () {
                  _atualizarUsuario(_id);
                },
              ),
              RaisedButton(
                child: Text("Consultar"),
                onPressed: () {
                  _listarUsuarioPeloId(_id);
                },
              ),
              RaisedButton(
                child: Text("Excluir"),
                onPressed: () {
                  _excluirUsuario(_id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
