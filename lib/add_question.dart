import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddQuestion extends StatefulWidget {
  const AddQuestion({Key? key}) : super(key: key);

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final _choice1Controller = TextEditingController();
  final _choice2Controller = TextEditingController();
  final _choice3Controller = TextEditingController();
  final _choice4Controller = TextEditingController();
  final _answerController = TextEditingController();
  final List<String> _categories = ['cpp', 'java', 'mysql', 'html'];
  String _selectedCategory = 'cpp';

  @override
  void initState() {
    super.initState();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final question = _questionController.text.trim();
      final choice1 = _choice1Controller.text.trim();
      final choice2 = _choice2Controller.text.trim();
      final choice3 = _choice3Controller.text.trim();
      final choice4 = _choice4Controller.text.trim();
      final answer = _answerController.text.trim();
      final category = _selectedCategory;

      // send the data to the server and insert the new question into the table
      final response = await http.post(
        Uri.parse('http://192.168.68.105:3001/api/data/add'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'question': question,
          'choice1': choice1,
          'choice2': choice2,
          'choice3': choice3,
          'choice4': choice4,
          'answer': answer,
          'category': category,
        }),
      );

      if (response.statusCode == 201) {
        // show a success message and clear the form
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Question added successfully'),
          ),
        );
        _formKey.currentState!.reset();
      } else {
        // show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to add question'),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _questionController.dispose();
    _choice1Controller.dispose();
    _choice2Controller.dispose();
    _choice3Controller.dispose();
    _choice4Controller.dispose();
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Question'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Question'),
                  controller: _questionController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a question';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Choice 1'),
                  controller: _choice1Controller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter choice 1';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Choice 2'),
                  controller: _choice2Controller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a choice 2';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Choice 3'),
                  controller: _choice3Controller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a choice 3';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Choice 4'),
                  controller: _choice4Controller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a choice 4';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: const InputDecoration(labelText: 'Category'),
                  items: _categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Answer'),
                  controller: _answerController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an answer';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
