import 'package:client/features/auth/model/album_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_album_notifier.g.dart';

@Riverpod(keepAlive: true)
class CurrentAlbumNotifier extends _$CurrentAlbumNotifier {
  @override
  List<AlbumModel>? build() {
    return [];
  }

  void addAlbums(List<AlbumModel> albums) {
    state = albums;
  }

  void addAlbum(AlbumModel album) {
    state = [...state ?? [], album];
  }

  void clearAlbums() {
    state = [];
  }
}
