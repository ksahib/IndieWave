import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:client/core/constants/server_constant.dart';
import 'package:client/core/failure/failure.dart';
import 'package:client/features/auth/model/user_model.dart';

part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(AuthRemoteRepositoryRef ref) {
  return AuthRemoteRepository();
}

class AuthRemoteRepository {

  final http.Client client = http.Client();
  final CookieJar cookieJar = CookieJar();

  Future<Either<AppFailure, UserModel>> signup({
    required String mail,
    required String name,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ServerConstant.serverUrl}/Signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": mail, "name": name, "password": password}),
      );

      final res = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 201) {
        return Left(AppFailure(res['detail']));
      } else {
        return Right(UserModel.fromMap(res));
      }
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

    Future<Either<AppFailure, UserModel>> login({
    required String mail,
    required String password,
    required bool keepLoggedIn,
  }) async {
    try {
      final uri = Uri.parse('${ServerConstant.serverUrl}/Login');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": mail, "password": password, "keepLoggedIn": keepLoggedIn}),
      );
      final res = jsonDecode(response.body) as Map<String, dynamic>;  
      if (response.statusCode != 200) {
        return Left(AppFailure(res['detail']));
      } else {
        return Right(UserModel.fromMap(res));
      }
  } catch (e, stackTrace) {
     return Left(AppFailure(e.toString()));
  }
  }

  Future<bool> autologin() async {
    try {
      final uri = Uri.parse('${ServerConstant.serverUrl}/Login'); 
      final response = await http.post(
          uri,
          headers: {
            'Content-Type': 'application/json',
            },
          body: jsonEncode({"email": "dummy@example.com", "password": "dummypass", "keepLoggedIn": false}),
        );
        if (response.statusCode == 200) {
          return true;
        }
        else  {
          return false;
        }
    } catch(e) {
        print('Error during auto-login: $e');
        return false;
    }
  }

}