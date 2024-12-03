import 'package:client/features/album/model/album_model.dart';
import 'package:client/features/home/models/playlist_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_playlist_notifier.g.dart';

@Riverpod(keepAlive: true)
class CurrentPlaylistNotifier extends _$CurrentPlaylistNotifier {
  @override
  List<PlaylistModel>? build() {
    return [];
  }

  // void addPlaylist(List<PlaylistModel> albums) {
  //   state = albums;
  // }

  void addPlaylist(PlaylistModel playlist) {
    state = [...state ?? [], playlist];
  }

  void clearAlbums() {
    state = [];
  }
}
