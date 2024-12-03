import 'dart:convert';
import 'package:client/features/Artist/model/artist_model.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:client/core/constants/server_constant.dart';
import 'package:client/core/failure/failure.dart';

part 'artist_auth_remote_repositories.g.dart';



@riverpod
ArtistAuthRemoteRepositories artistAuthRemoteRepository(Ref ref) {
  return ArtistAuthRemoteRepositories();
}

class ArtistAuthRemoteRepositories {

  final http.Client client = http.Client();
  final CookieJar cookieJar = CookieJar();


  Future<Either<AppFailure, ArtistModel>> artistSignup({
    required String mail,
    required String name,
    required String about,
    required String imageUrl,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ServerConstant.serverUrl}/ArtistSignUp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": mail, "artist_name": name, "about": about, "profile_pic": imageUrl}),
      );

      final res = jsonDecode(response.body) as Map<String, dynamic>;
      print('API Response Body: ${response.body}');

      if (response.statusCode != 201) {
        return Left(AppFailure(res['detail']));
      } else {
        return Right(ArtistModel.fromMap(res));
      }
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, ArtistModel>> getArtist(String? token) async {
    try {
      final uri = Uri.parse('${ServerConstant.serverUrl}/Artist');
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
        final artistData = res['data'];
        return Right(ArtistModel.fromMap(artistData).copyWith(token: token));

      }
  } catch (e) {
     return Left(AppFailure(e.toString()));
  }
  }

}