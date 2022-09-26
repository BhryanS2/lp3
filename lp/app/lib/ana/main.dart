import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() => runApp(
      MaterialApp(
        home: Home(),
      ),
    );

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _nome = TextEditingController();
  TextEditingController _sobrenome = TextEditingController();
  TextEditingController _ra = TextEditingController();

  _recuperarBancoDados() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "meubanco.db");

    var bd = await openDatabase(localBancoDados, version: 1,
        onCreate: (db, dbVersaoRecente) {
      String sql =
          "CREATE TABLE usuarios (id INTEGER PRIMARY KEY AUTOINCREMENT, nome VARCHAR, sobrenome VARCHAR, ra VARCHAR) ";
      db.execute(sql);
    });
    return bd;
  }

  Future _salvar() async {
    Database bd = await _recuperarBancoDados();

    Map<String, dynamic> dadosUsuario = {
      "nome": _nome.text,
      "sobrenome": _sobrenome.text,
      "ra": _ra.text
    };
    print(dadosUsuario);
    int id = await bd.insert("usuarios", dadosUsuario);
  }

  Future _listarUsuarios() async {
    Database bd = await _recuperarBancoDados();

    String sql = "SELECT * FROM usuarios ";
    List usuarios = await bd.rawQuery(sql);

    for (var usuario in usuarios) {
      print(
          "item id: ${usuario['id']} nome: ${usuario['nome']} sobrenome: ${usuario['sobrenome']} ra: ${usuario['ra']}");
    }
  }

  Future _listarUsuarioPeloId(int id) async {
    Database bd = await _recuperarBancoDados();

    List usuarios = await bd.query("usuarios",
        columns: ["id", "nome", "sobrenome", "ra"],
        where: "id = ?",
        whereArgs: [id]);

    for (var usuario in usuarios) {
      print("item id: " +
          usuario['id'].toString() +
          " nome: " +
          usuario['nome'] +
          " sobrenome: " +
          usuario['sobrenome'] +
          " ra: " +
          usuario['ra']);
    }
  }

  Future _excluir(int id) async {
    Database bd = await _recuperarBancoDados();

    int retorno = await bd.delete("usuarios",
        /*where: "id = ?",
      whereArgs: [id]*/
        where: " nome = ? AND idade = ?",
        whereArgs: ["Pedro Eavangelista", 40]);

    print("item qtde removida: $retorno");
  }

  Future _listar(int id) async {
    Database bd = await _recuperarBancoDados();

    Map<String, dynamic> dadosUsuario = {
      "nome": "Mariana Almeida",
      "idade": 18
    };
    int retorno = await bd
        .update("usuarios", dadosUsuario, where: "id = ?", whereArgs: [id]);

    print("item qtde atualizada: $retorno");
  }

  _alterar() async {
    Database bd = await _recuperarBancoDados();
    Map<String, dynamic> dadosUsuario = {
      "nome": _nome.text,
      "sobrenome": _sobrenome.text,
      "ra": _ra.text
    };
    int retorno = await bd.update("usuarios", dadosUsuario,
        where: "ra = ?", whereArgs: [_ra.text]);

    print("item qtde atualizada: $retorno");
    print("itens atualizados: $dadosUsuario");
  }

  _excluirPeloRa() async {
    Database bd = await _recuperarBancoDados();
    int retorno =
        await bd.delete("usuarios", where: "ra = ?", whereArgs: [_ra.text]);
    print("item qtde removida: $retorno");
    setState(() {
      _nome.text = "";
      _sobrenome.text = "";
      _ra.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyForm"),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 35, bottom: 20),
              child: Text(
                "Form DB",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal),
              ),
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: "Nome:"),
              style: TextStyle(fontSize: 22),
              controller: _nome,
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: "Sobrenome:"),
              style: TextStyle(fontSize: 22),
              controller: _sobrenome,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "RA:"),
              style: TextStyle(fontSize: 22),
              controller: _ra,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: ElevatedButton(
                  child: Text('Salvar'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                    onPrimary: Colors.white,
                    shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    minimumSize: Size(200, 50),
                  ),
                  onPressed: _salvar),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: ElevatedButton(
                  child: Text('Consultar'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                    onPrimary: Colors.white,
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    minimumSize: Size(200, 50),
                  ),
                  onPressed: _listarUsuarios),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: ElevatedButton(
                  child: Text('Alterar'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                    onPrimary: Colors.white,
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    minimumSize: Size(200, 50),
                  ),
                  onPressed: _alterar),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: ElevatedButton(
                  child: Text('Excluir'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                    onPrimary: Colors.white,
                    shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    minimumSize: Size(200, 50),
                  ),
                  onPressed: _excluirPeloRa),
            ),
          ]),
        ),
      ),
    );
  }
}
