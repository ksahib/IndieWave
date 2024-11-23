import 'package:client/features/album/model/genre_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_genre_notifier.g.dart';

@Riverpod(keepAlive: true)
class CurrentGenreNotifier extends _$CurrentGenreNotifier {
  @override
  List<GenreModel>? build() {
    return [];
  }

  void addAlbums(List<GenreModel> albums) {
    state = albums;
  }

  void addAlbum(GenreModel album) {
    state = [...state ?? [], album];
  }

  void clearAlbums() {
    state = [];
  }
}
