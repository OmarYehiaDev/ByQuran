
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'RefreshIndicator',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // The initial todos
  List _todos = [];

  // Call this when the user pull down the screen
  Future<void> _loadData() async {
    const url = 'https://jsonplaceholder.typicode.com/todos';
    try {
      final http.Response response = await http.get(Uri.parse(url));
      final _loadedTodos = json.decode(response.body);
      setState(() {
        _todos = _loadedTodos;
      });
    } catch (err) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RefreshIndicator'),
      ),
      body: RefreshIndicator(
        // trigger the _loadData function when the user pulls down
          onRefresh: _loadData,
          // Render the todos
          child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (BuildContext ctx, index) {
                return Card(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: ListTile(
                    // Render each todo
                    leading: Text(_todos[index]['id'].toString()),
                    title: Text(_todos[index]["title"]),
                    trailing: _todos[index]["completed"]
                        ? const Icon(
                      Icons.check_circle,
                      color: Colors.blue,
                    )
                        : const Icon(
                      Icons.circle,
                      color: Colors.yellow,
                    ),
                  ),
                );
              })),
    );
  }
}