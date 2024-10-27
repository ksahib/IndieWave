import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthRemoteRepository {
  Future<void> signup({
    required String mail,
    required String name,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse(
        'http://127.0.0.1:8000/auth/Signup',
      ),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': mail, 'name': name, 'password': password}),
    );
    print(response.body);
    print(response.statusCode);
  }

  Future<void> login() async {}
}
