//@dart=2.9
//foi necessaario inserir a linha acima para o coodigo funcionar.

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//Criar Conexao com banco de dados
//Adicionar  sqflite: logo abaixo de  cupertino_icons: ^1.0.2 no pubspec.yaml proximo da linha 35
//Adicionar os imports
//import 'package:sqflite/sqflite.dart';
//import 'package:path/path.dart';

void main() => runApp(MaterialApp(
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //async determina que um metodo sera assincrono, nao retornara algo imediato
  //await serve para mostrar que o app deve esperar uma resposta antes de continuar.
  //Future determina que uma funcao ira retornar algo no futuro. Levara um tempo para ser executada.

  TextEditingController _codigotxt = TextEditingController();
  TextEditingController _nometxt = TextEditingController();
  TextEditingController _sobrenometxt = TextEditingController();
  TextEditingController _ratxt = TextEditingController();

  _recuperarBancoDados() async {
    final caminhoBancoDados =
        await getDatabasesPath(); //recupera o caminho do banco no celular do usuario
    final localBancoDados = join(caminhoBancoDados,
        "alunos.db"); // nome do banco de dados a ser recuperado/utilizado

    var bd = await openDatabase(localBancoDados, // Banco de dados utilizado
        version: 1, //Eu crio a versao de acordo com meu APP
        onCreate: (db, dbVersaoRecente) {
      //db permite manipular o banco
      String sql =
          "CREATE TABLE usuarios (id INTEGER PRIMARY KEY AUTOINCREMENT, nome string, sobrenome string, ra string) ";
      db.execute(sql);
    });
    return bd;
    //print("aberto: " + bd.isOpen.toString() );
  }

  _salvar() async {
    int raint = int.parse(_ratxt.text);
    Database bd = await _recuperarBancoDados();
    Map<String, dynamic> dadosUsuario = {
      "nome": _nometxt.text,
      "sobrenome": _sobrenometxt.text,
      "ra": _ratxt.text
    };
    int id = await bd.insert("usuarios", dadosUsuario);
    print("Salvo: $id ");
    setState(() {
      _codigotxt.text = id.toString();
    });
  }

  _listarUsuarios() async {
    Database bd = await _recuperarBancoDados();
    String sql = "SELECT * FROM usuarios "; //ASC, DESC
    List usuarios = await bd.rawQuery(sql);

    for (var usuario in usuarios) {
      print("item id: " +
          usuario['id'].toString() +
          " nome: " +
          usuario['nome'] +
          " sobrenome: " +
          usuario['sobrenome'] +
          " ra: " +
          usuario['ra'].toString());
    }
    //print("usuarios: " + usuarios.toString() );
  }

  _listarUsuarioPeloId() async {
    int codigoint = int.parse(_codigotxt.text);
    Database bd = await _recuperarBancoDados();
    //CRUD -> Create, Read, Update and Delete
    List usuarios = await bd.query("usuarios",
        columns: ["id", "nome", "sobrenome", "ra"],
        where: "id = ?",
        whereArgs: [codigoint]);

    for (var usuario in usuarios) {
      print("item id: " +
          usuario['id'].toString() +
          " nome: " +
          usuario['nome'] +
          " sobrenome: " +
          usuario['sobrenome'].toString() +
          " ra: " +
          usuario['ra'].toString());
      _nometxt.text = usuario['nome'];
      _sobrenometxt.text = usuario['sobrenome'];
      _ratxt.text = usuario['ra'].toString();
    }
  }

  _excluirUsuario() async {
    int codigoint = int.parse(_codigotxt.text);
    Database bd = await _recuperarBancoDados();
    int retorno =
        await bd.delete("usuarios", where: "id = ?", whereArgs: [codigoint]
            //where: " nome = ? AND idade = ?",
            //whereArgs: ["Pedro Eavangelista", 40]
            );
    print("item qtde removida: $retorno");
  }

  _atualizarUsuario() async {
    int codigoint = int.parse(_codigotxt.text);
    int raint = int.parse(_ratxt.text);
    Database bd = await _recuperarBancoDados();
    Map<String, dynamic> dadosUsuario = {
      "nome": _nometxt.text,
      "sobrenome": _sobrenometxt.text,
      "ra": _ratxt.text
    };
    int retorno = await bd.update("usuarios", dadosUsuario,
        where: "id = ?", whereArgs: [codigoint]);
    print("item qtde atualizada: $retorno");
  }

  @override
  Widget build(BuildContext context) {
    //_salvar();
    //_excluirUsuario(2);
    //_atualizarUsuario(3);
    //_listarUsuarios();
    //_listarUsuarioPeloId(2);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Usuários"),
        backgroundColor: Colors.red,
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
                    InputDecoration(labelText: "Código:" //texto padrão do campo
                        ),
                style: TextStyle(
                    //formatação da fonte
                    fontSize: 22),
                controller: _codigotxt, //pegando valor do campo alcool
              ),
              TextField(
                keyboardType:
                    TextInputType.text, //caixa de número somente com .
                decoration:
                    InputDecoration(labelText: "Nome:" //texto padrão do campo
                        ),
                style: TextStyle(fontSize: 22),
                controller: _nometxt, //pegando valor do campo gasolina
              ),
              TextField(
                keyboardType:
                    TextInputType.text, //caixa de número somente com .
                decoration: InputDecoration(
                    labelText: "Sobrenome:" //texto padrão do campo
                    ),
                style: TextStyle(fontSize: 22),
                controller: _sobrenometxt, //pegando valor do campo gasolina
              ),
              TextField(
                keyboardType:
                    TextInputType.number, //caixa de número somente com .
                decoration:
                    InputDecoration(labelText: "RA:" //texto padrão do campo
                        ),
                style: TextStyle(fontSize: 22),
                controller: _ratxt, //pegando valor do campo gasolina
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10), //121espaçamento superior
                  child: ElevatedButton(
                      child: Text('Salvar'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        onPrimary: Colors.red,
                        shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                      ),
                      onPressed: _salvar)),
              Padding(
                  padding: EdgeInsets.only(top: 10), //espaçamento superior
                  child: ElevatedButton(
                      child: Text('Alterar'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        onPrimary: Colors.black,
                        shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                      ),
                      onPressed: _atualizarUsuario)),
              Padding(
                  padding: EdgeInsets.only(top: 10), //espaçamento superior
                  child: ElevatedButton(
                      child: Text('Excluir'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        onPrimary: Colors.red,
                        shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                      ),
                      onPressed: _excluirUsuario)),
              Padding(
                  padding: EdgeInsets.only(top: 10), //espaçamento superior
                  child: ElevatedButton(
                      child: Text('Consultar'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        onPrimary: Colors.black,
                        shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                      ),
                      onPressed: _listarUsuarioPeloId)),
            ],
          ),
        ),
      ),
    );
  }
}
