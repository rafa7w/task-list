import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ignore: prefer_final_fields
  List _toDoList = [];

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/data.json');
  }

  Future<File> _saveData() async {
    String data = json.encode(_toDoList);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String?> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tarefas'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Nova Tarefa',
                      labelStyle: TextStyle(
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  color: Colors.blueAccent,
                  child: const Text('ADD'),
                  textColor: Colors.white,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 10.0),
              itemCount: _toDoList.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(_toDoList[index]['title']),
                  value: _toDoList[index]['ok'],
                  secondary: CircleAvatar(
                    child: Icon(
                        _toDoList[index]['ok'] ? Icons.check : Icons.error),
                  ),
                  onChanged: (bool? value) {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
