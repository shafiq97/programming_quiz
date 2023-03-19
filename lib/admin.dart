import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  List<dynamic> _questions = [];
  var _selectedValues = [];

  Future<void> _fetchQuestions() async {
    final response =
        await http.get(Uri.parse('http://192.168.68.105:3001/api/data/all'));

    if (response.statusCode == 200) {
      setState(() {
        _questions = jsonDecode(response.body)['questions'];
        _selectedValues = List<String>.filled(_questions.length, "");
      });
    } else {
      throw Exception('Failed to fetch questions');
    }
  }

  Future<void> _deleteQuestion(int index) async {
    var question = _questions[index];
    log(question.toString());
    final id = question['id'];
    log(id.toString());
    final response = await http
        .delete(Uri.parse('http://192.168.68.105:3001/api/questions/$id'));

    if (response.statusCode == 200) {
      log(response.body);
      setState(() {
        _questions.removeAt(index);
        _selectedValues.removeAt(index);
      });
    } else {
      throw Exception('Failed to delete question');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Lists'),
      ),
      body: ListView.builder(
        itemCount: _questions.length,
        itemBuilder: (BuildContext context, int index) {
          final question = _questions[index];
          final choices = question['choices'];

          return Dismissible(
            key: Key(question['id'].toString()),
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) {
              _deleteQuestion(index);
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      question['question'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  ...choices.map((choice) => RadioListTile(
                        title: Text(choice),
                        value: choice,
                        groupValue: _selectedValues[index],
                        onChanged: (value) {
                          setState(() {
                            _selectedValues[index] = value;
                          });
                        },
                      ))
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/addQuestion');
            },
            child: Text('Add new Question'),
          ),
        ),
      ),
    );
  }
}
