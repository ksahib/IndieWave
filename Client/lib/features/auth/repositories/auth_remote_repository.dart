import 'dart:convert';
import 'dart:io';
import 'package:client/features/album/model/album_model.dart';
import 'package:crypto/crypto.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:client/core/constants/server_constant.dart';
import 'package:client/core/failure/failure.dart';
import 'package:client/features/auth/model/user_model.dart';

part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(Ref ref) {
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

  Future<Either<AppFailure, AlbumModel>> createAlbum({
    required String name,
    required String price,
    required String cover_art,
    required String artist_name,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ServerConstant.serverUrl}/AlbumAdd'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"name": name, "cover_art": cover_art, "price": price, 'artist_name': artist_name}),
      );

      final res = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 201) {
        return Left(AppFailure(res['detail']));
      } else {
        return Right(AlbumModel.fromMap(res));
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
      final uri = Uri.parse('http://localhost/indiewave/api/Login');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": mail, "password": password, "keepLoggedIn": keepLoggedIn}),
      );
      final res = jsonDecode(response.body) as Map<String, dynamic>;  
      if (response.statusCode != 200) {
        return Left(AppFailure(res['message']));
      } else {
        return Right(UserModel.fromMap(res['data']['user']['data']).copyWith(token: res['data']['token']));
      }
  } catch (e) {
     return Left(AppFailure(e.toString()));
  }
  }

  Future<Either<AppFailure, UserModel>> getUser(String? token) async {
    try {
      final uri = Uri.parse('${ServerConstant.serverUrl}/Auth');
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': token ?? "",
          },
        
      );
      final res = jsonDecode(response.body) as Map<String, dynamic>;  
      if (response.statusCode != 200) {
        return Left(AppFailure(res['message']));
      } else {
        final userData = res['data'][0]['data'];
        final imageUrl = res['data'][1]['data']['image_url'];
        return Right(UserModel.fromMap(userData, imageUrl).copyWith(token: token));

      }
  } catch (e) {
     return Left(AppFailure(e.toString()));
  }
  }

  Future<Either<AppFailure, List<AlbumModel>>> getAllAlbum(String? artistName) async {
  try {
    final uri = Uri.parse('${ServerConstant.serverUrl}/AllAlbums');
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'artist-name': artistName ?? "",
      },
    );

    final res = jsonDecode(response.body) as Map<String, dynamic>;
    print('API Response Body: ${response.body}');
    if (response.statusCode != 200) {
      return Left(AppFailure(res['message']));
    } else {

      final List<dynamic> albumDataList = res['data'];

      final List<AlbumModel> albums = albumDataList
          .map((albumData) => AlbumModel.fromMap(albumData))
          .toList();

      return Right(albums);
    }
  } catch (e) {
    return Left(AppFailure(e.toString()));
  }
}

Future<Either<AppFailure, AlbumModel>> getCurrentAlbum(String artist_name, String album_name) async {
    try {
      final uri = Uri.parse('${ServerConstant.serverUrl}/getAlbum');
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'album-name': album_name,
          'artist-name': artist_name,
          },
        
      );
      final res = jsonDecode(response.body) as Map<String, dynamic>;  
      if (response.statusCode != 200) {
        return Left(AppFailure(res['message']));
      } else {
        final artistData = res['data'];
        return Right(AlbumModel.fromMap(artistData).copyWith(name: album_name, artist_name: artist_name));

      }
  } catch (e) {
     return Left(AppFailure(e.toString()));
  }
  }

}