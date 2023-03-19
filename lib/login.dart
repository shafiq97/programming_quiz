import 'package:programming_quiz/connection.dart';

Future<bool> login(String username, String password, String role) async {
  final conn = await getConnection();
  final results = await conn.query(
    'SELECT * FROM users WHERE username = ? AND password = ? AND role = ?',
    [username, password, role],
  );
  await conn.close();
  return results.isNotEmpty;
}
