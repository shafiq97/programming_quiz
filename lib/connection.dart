import 'package:mysql1/mysql1.dart';

Future<MySqlConnection> getConnection() async {
  final settings = ConnectionSettings(
    host: '192.168.68.105',
    port: 3306,
    user: 'flutter',
    password: 'flutter',
    db: 'flutter_login',
  );
  final conn = await MySqlConnection.connect(settings);
  return conn;
}
