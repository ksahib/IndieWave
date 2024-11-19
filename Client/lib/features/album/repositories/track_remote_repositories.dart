import 'dart:convert';
import 'package:client/features/album/model/track_model.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:client/core/constants/server_constant.dart';
import 'package:client/core/failure/failure.dart';


part 'track_remote_repositories.g.dart';

@riverpod
TrackRemoteRepositories trackRemoteRepository(Ref ref) {
  return TrackRemoteRepositories();
}

class TrackRemoteRepositories {

  final http.Client client = http.Client();
  final CookieJar cookieJar = CookieJar();

  Future<Either<AppFailure, TrackModel>> addTrack({
    required String name,
    required Duration length,
    required String tag,
    required String track_url,
    required String album_id,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ServerConstant.serverUrl}/InsertTrack'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"track_name": name, "length": length, "tag": tag, 'track_url': track_url, 'album_id': album_id}),
      );

      final res = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 201) {
        return Left(AppFailure(res['detail']));
      } else {
        return Right(TrackModel.fromMap(res));
      }
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, List<TrackModel>>> getAlltracks(String? albumName) async {
  try {
    final uri = Uri.parse('${ServerConstant.serverUrl}/GetTrack');
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'album-name': albumName ?? "",
      },
    );

    final res = jsonDecode(response.body) as Map<String, dynamic>;
    //print('API Response Body: ${response.body}');
    if (response.statusCode != 200) {
      return Left(AppFailure(res['message']));
    } else {

      final List<dynamic> albumDataList = res['data'];

      final List<TrackModel> albums = albumDataList
          .map((albumData) => TrackModel.fromMap(albumData))
          .toList();

      return Right(albums);
    }
  } catch (e) {
    return Left(AppFailure(e.toString()));
  }
}

// Future<Either<AppFailure, AlbumModel>> getCurrentAlbum(String artist_name, String album_name) async {
//     try {
//       final uri = Uri.parse('${ServerConstant.serverUrl}/getAlbum');
//       final response = await http.get(
//         uri,
//         headers: {
//           'Content-Type': 'application/json',
//           'album-name': album_name,
//           'artist-name': artist_name,
//           },
        
//       );
//       final res = jsonDecode(response.body) as Map<String, dynamic>;  
//       //print('ALBUM API Response Body: ${response.body}');
//       if (response.statusCode != 200) {
//         return Left(AppFailure(res['message']));
//       } else {
//         final artistData = res['data'][0];
//         return Right(AlbumModel.fromMap(artistData).copyWith(name: album_name, artist_name: artist_name));

//       }
//   } catch (e) {
//      return Left(AppFailure(e.toString()));
//   }
//   }

}