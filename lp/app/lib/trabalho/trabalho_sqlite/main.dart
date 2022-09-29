// @dart=2.9


import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

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

class DatabaseController {
  int id;
  String firstName;
  String lastName;
  int age;
  String email;
  String phone;

  _setAllData(
      int id, String firstName, String lastName, int age, String email) {
    this.id = id;
    this.firstName = firstName;
    this.lastName = lastName;
    this.age = age;
    this.email = email;
  }

  _getAllData() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'email': email
    };
  }

  _getDatabase() async {
    final pathDatabase = await getDatabasesPath();
    final pathjoin = path.join(pathDatabase, 'trabalho_sqlite.db');
    String sql =
        'CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR, sobrenome VARCHAR, idade INTEGER, email VARCHAR, telefone VARCHAR)';
    var db = await openDatabase(
      pathjoin,
      version: 1,
      onCreate: (db, dbVersaoRecente) {
        db.execute(sql);
      },
    );
    return db;
  }

  _existsUser() async {
    if (id == -1) {
      return false;
    }
    Database db = await _getDatabase();
    final user = await db.query('users', where: 'id = ?', whereArgs: [id]);
    if (user.isEmpty) {
      return false;
    }
    return true;
  }

  _save() async {
    Database db = await _getDatabase();
    Map<String, dynamic> dadosUsuario = {
      'nome': firstName,
      'sobrenome': lastName,
      'idade': age,
      'email': email,
      'telefone': phone,
    };
    int id = await db.insert('users', dadosUsuario);
    this.id = id;
  }

  _alter() async {
    if (id == -1) {
      return;
    }
    if (!_existsUser()) {
      return;
    }
    Database db = await _getDatabase();
    Map<String, dynamic> dadosUsuario = {
      'nome': firstName,
      'sobrenome': lastName,
      'idade': age,
      'email': email,
      'telefone': phone,
    };
    await db.update('users', dadosUsuario, where: 'id = ?', whereArgs: [id]);
    _setAllData(id, firstName, lastName, age, email);
  }

  _getUser() async {
    this.id = id;
    if (id == -1) {
      return;
    }
    if (!_existsUser()) {
      return;
    }
    Database db = await _getDatabase();
    final user = await db.query('users', where: 'id = ?', whereArgs: [id]);
    _setAllData(user[0]['id'], user[0]['nome'], user[0]['sobrenome'],
        user[0]['idade'], user[0]['email']);
    return user;
  }

  _delete() async {
    if (id == -1) {
      return;
    }
    if (!_existsUser()) {
      return;
    }
    Database db = await _getDatabase();
    await db.delete('users', where: 'id = ?', whereArgs: [id]);
    _setAllData(-1, "", "", -1, "");
  }

  _getAllUsers() async {
    Database db = await _getDatabase();
    final users = await db.query('users');
    return users;
  }
}

class _HomeState extends State<Home> {
  /*
    id -> integer pk ai
    nome -> string
    sobrenome -> string
    idade -> integer
    email -> string
    telefone -> string
    */
  int _id = -1;
  TextEditingController _controllerFirstName = TextEditingController();
  TextEditingController _controllerLastName = TextEditingController();
  TextEditingController _controllerAge = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPhone = TextEditingController();
  final database = DatabaseController();
  _clearFields() {
    _controllerFirstName.text = "";
    _controllerLastName.text = "";
    _controllerAge.text = "";
    _controllerEmail.text = "";
    _controllerPhone.text = "";
  }

  /* 
  salvar
  alterar
  excluir
  consultar
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Banco de Dados"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text("Entre com os dados"),
              TextField(
                controller: _controllerFirstName,
                decoration: InputDecoration(labelText: "Nome"),
              ),
              TextField(
                controller: _controllerLastName,
                decoration: InputDecoration(labelText: "Sobrenome"),
              ),
              TextField(
                controller: _controllerAge,
                decoration: InputDecoration(labelText: "Idade"),
              ),
              TextField(
                controller: _controllerEmail,
                decoration: InputDecoration(labelText: "Email"),
              ),
              TextField(
                controller: _controllerPhone,
                decoration: InputDecoration(labelText: "Telefone"),
              ),
              MaterialButton(
                onPressed: () {
                  database._setAllData(
                      _id,
                      _controllerFirstName.text,
                      _controllerLastName.text,
                      int.parse(_controllerAge.text),
                      _controllerEmail.text);
                  database._save();
                  _clearFields();
                },
                child: Text("Salvar"),
              ),
              MaterialButton(
                onPressed: () {
                  database._setAllData(
                      _id,
                      _controllerFirstName.text,
                      _controllerLastName.text,
                      int.parse(_controllerAge.text),
                      _controllerEmail.text);
                  database._alter();
                  _clearFields();
                },
                child: Text("Alterar"),
              ),
              MaterialButton(
                onPressed: () {
                  database._setAllData(
                      _id,
                      _controllerFirstName.text,
                      _controllerLastName.text,
                      int.parse(_controllerAge.text),
                      _controllerEmail.text);
                  database._delete();
                  _clearFields();
                },
                child: Text("Excluir"),
              ),
              Material(
                child: FutureBuilder(
                  future: database._getUser(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(snapshot.data[0]['nome']);
                    } else {
                      return Text("Nenhum dado encontrado");
                    }
                  },
                ),
              ),
              Text("Dados do banco de dados"),
              Material(
                child: FutureBuilder(
                  future: database._getAllUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(snapshot.data[index]['nome']),
                            subtitle: Text(snapshot.data[index]['email']),
                            onTap: () {
                              _id = snapshot.data[index]['id'];
                              _controllerFirstName.text =
                                  snapshot.data[index]['nome'];
                              _controllerLastName.text =
                                  snapshot.data[index]['sobrenome'];
                              _controllerAge.text =
                                  snapshot.data[index]['idade'].toString();
                              _controllerEmail.text =
                                  snapshot.data[index]['email'];
                              _controllerPhone.text =
                                  snapshot.data[index]['telefone'];
                            },
                          );
                        },
                      );
                    } else {
                      return Text("Nenhum dado encontrado");
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
