import 'package:flutter/material.dart';
import 'package:programming_quiz/CPP/cpp.dart';
import 'package:programming_quiz/HTML/html.dart';
import 'package:programming_quiz/JAVA/java.dart';
import 'package:programming_quiz/MYSQL/mysql.dart';
import 'package:programming_quiz/add_question.dart';
import 'package:programming_quiz/admin.dart';
import 'package:programming_quiz/home.dart';
import 'package:programming_quiz/loginui.dart';
import 'package:programming_quiz/menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(initialRoute: '/login', routes: {
    '/menu': (context) => const Menu(),
    '/login': (context) => LoginPage(),
    '/cpp': (context) => const CppQuiz(),
    '/java': (context) => const JavaQuiz(),
    '/html': (context) => const HTMLQuiz(),
    '/mysql': (context) => const MySQLQuiz(),
    '/admin': (context) => const Admin(),
    '/home': (context) => const Home(),
    '/addQuestion': (context) => const AddQuestion(),
  }));
}
