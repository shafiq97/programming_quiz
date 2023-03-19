import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MySQLQuiz extends StatefulWidget {
  const MySQLQuiz({super.key});

  @override
  _MySQLQuizState createState() => _MySQLQuizState();
}

class _MySQLQuizState extends State<MySQLQuiz> {
  List<dynamic> _questions = [];
  List<String> _selectedValues = [];

  Future<void> _fetchQuestions() async {
    final response =
        await http.get(Uri.parse('http://192.168.68.105:3001/api/data/mysql'));

    if (response.statusCode == 200) {
      setState(() {
        _questions = jsonDecode(response.body)['questions'];
        _selectedValues = List<String>.filled(_questions.length, "");
      });
    } else {
      throw Exception('Failed to fetch questions');
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
        title: const Text('Java Quiz'),
      ),
      body: ListView.builder(
        itemCount: _questions.length,
        itemBuilder: (BuildContext context, int index) {
          final question = _questions[index];
          final choices = question['choices'];

          return Card(
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
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ElevatedButton(
            onPressed: () {
              int score = 0;
              for (int i = 0; i < _questions.length; i++) {
                final question = _questions[i];
                final correctAnswer = question['answer'];
                final selectedAnswer = _selectedValues[i];
                if (selectedAnswer == correctAnswer) {
                  score++;
                }
              }
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Score'),
                      content:
                          Text('You scored $score out of ${_questions.length}'),
                    );
                  });
            },
            child: Text('Submit'),
          ),
        ),
      ),
    );
  }
}
