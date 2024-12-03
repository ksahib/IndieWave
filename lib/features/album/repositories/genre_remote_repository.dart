import 'dart:convert';
import 'package:client/features/album/model/genre_model.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:client/core/constants/server_constant.dart';
import 'package:client/core/failure/failure.dart';


part 'genre_remote_repository.g.dart';

@riverpod
GenreRemoteRepository genreRemoteRepository(Ref ref) {
  return GenreRemoteRepository();
}

class GenreRemoteRepository {

  final http.Client client = http.Client();
  final CookieJar cookieJar = CookieJar();

  Future<Either<AppFailure, List<GenreModel>>> getAllGenre() async {
  try {
    final uri = Uri.parse('${ServerConstant.serverUrl}/Genre');
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    final res = jsonDecode(response.body) as Map<String, dynamic>;
    //print('API Response Body: ${response.body}');
    if (response.statusCode != 200) {
      return Left(AppFailure(res['message']));
    } else {

      final List<dynamic> genreDataList = res['data'];
      print(res['data']);
      final List<GenreModel> genres = genreDataList
          .map((genreData) => GenreModel.fromMap(genreData))
          .toList();

      return Right(genres);
    }
  } catch (e) {
    return Left(AppFailure(e.toString()));
  }
}

}