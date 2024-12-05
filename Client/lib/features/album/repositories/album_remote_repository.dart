import 'dart:convert';
import 'package:client/features/album/model/album_model.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:client/core/constants/server_constant.dart';
import 'package:client/core/failure/failure.dart';


part 'album_remote_repository.g.dart';

@riverpod
AlbumRemoteRepository albumRemoteRepository(Ref ref) {
  return AlbumRemoteRepository();
}

class AlbumRemoteRepository {

  final http.Client client = http.Client();
  final CookieJar cookieJar = CookieJar();

  Future<Either<AppFailure, AlbumModel>> createAlbum({
    required String name,
    required String cover_art,
    required String artist_name,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ServerConstant.serverUrl}/AlbumAdd'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"name": name, "cover_art": cover_art, 'artist_name': artist_name}),
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

    Future<Object> releaseAlbum({
    required String artist_name,
    required String album_id,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ServerConstant.serverUrl}/Release'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'artist_name': artist_name, 'album_id': album_id}),
      );

      final res = jsonDecode(response.body) as Map<String, dynamic>;
      print("RELEASE: ${res}");
      if (response.statusCode != 201) {
        return Left(AppFailure(res['detail']));
      } else {
        return true;
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
    //print('API Response Body: ${response.body}');
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
      //print('ALBUM API Response Body: ${response.body}');
      if (response.statusCode != 200) {
        return Left(AppFailure(res['message']));
      } else {
        final artistData = res['data'][0];
        return Right(AlbumModel.fromMap(artistData).copyWith(name: album_name, artist_name: artist_name));

      }
  } catch (e) {
     return Left(AppFailure(e.toString()));
  }
}

Future<Either<AppFailure, int>> unreleaseAlbum(String album_id) async {
    try {
      final uri = Uri.parse('${ServerConstant.serverUrl}/Unrelease');
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'album-id': album_id,
          },
        
      );
      final res = jsonDecode(response.body) as Map<String, dynamic>;  
      //print('ALBUM API Response Body: ${response.body}');
      if (response.statusCode != 200) {
        return Left(AppFailure(res['message']));
      } else {
        return Right(response.statusCode);

      }
  } catch (e) {
     return Left(AppFailure(e.toString()));
  }
}

  Future<Either<AppFailure, int>> releaseStatus(String album_id) async {
    try {
      final uri = Uri.parse('${ServerConstant.serverUrl}/ReleaseStatus');
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'album-id': album_id,
          },
        
      );
      //print('ALBUM API Response Body: ${response.body}');
      if (response.statusCode != 200) {
        return Left(AppFailure('Album is now unreleased'));
      } else {
        return Right(response.statusCode);

      }
  } catch (e) {
     return Left(AppFailure(e.toString()));
  }
  }

}