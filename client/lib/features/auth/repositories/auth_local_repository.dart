import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';


part 'auth_local_repository.g.dart'; 

@riverpod
AuthLocalRepository authLocalRepository(Ref ref) {
  return AuthLocalRepository();
}

class AuthLocalRepository {
  late SharedPreferences _sharedPreferences;
  final Completer<void> _initCompleter = Completer();

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _initCompleter.complete();
  }

  Future<void> setToken(String? token)  async {
    await _initCompleter.future;
    if(token != null) {
      _sharedPreferences.setString('x-auth-token', token);
    }
  }

  Future<String?> getToken()  async {
    await _initCompleter.future;
    return _sharedPreferences.getString('x-auth-token');
  }
}