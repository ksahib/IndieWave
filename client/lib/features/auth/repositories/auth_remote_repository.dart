import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthRemoteRepository {
  Future<void> signup({
    required String mail,
    required String name,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.0.111/indiewave/api/Signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": mail, "name": name, "password": password}),
      );

      if (response.statusCode == 201) {
        print('Signup successful: ${response.body}');
      } else {
        print('Signup failed: ${response.statusCode} - ${response.body}');
      }
    } catch (e, stackTrace) {
      print('Error during signup: $e');
      print('Stack trace: $stackTrace');
    }
  }

    Future<void> login({
    required String mail,
    required String password,
    required bool keepLoggedIn,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.0.111/indiewave/api/Login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": mail, "password": password, "keepLoggedIn": keepLoggedIn}),
      );

      if (response.statusCode == 201) {
        print('Login successful: ${response.body}');
      } else {
        print('Login failed: ${response.statusCode} - ${response.body}');
      }
  } catch (e, stackTrace) {
      print('Error during Login: $e');
      print('Stack trace: $stackTrace');
  }
  }

}