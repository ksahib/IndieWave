import 'dart:convert';
import 'package:client/core/constants/server_constant.dart';
import 'package:client/features/album/model/album_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod/riverpod.dart';
import 'package:http/http.dart' as http;

part 'current_artistview_notifier.g.dart';

@riverpod
class CurrentArtistViewNotifier extends _$CurrentArtistViewNotifier{
  AudioPlayer? audioPlayer;
  bool isPlaying = false;
  @override
  List<AlbumModel>? build() {
    return [];
  }

  Future<List<AlbumModel>> getAllReleasedAlbum(String? artistName) async {
  try {
    final uri = Uri.parse('${ServerConstant.serverUrl}/AllReleasedAlbum');
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
      throw Failure(res['message']);
    } else {

      final List<dynamic> albumDataList = res['data'];

      final List<AlbumModel> albums = albumDataList
          .map((albumData) => AlbumModel.fromMap(albumData))
          .toList();

      return state = albums;
    }
  } catch (e) {
    state = []; 
    throw Failure(e.toString());
  }
}

  
}