import 'package:client/features/auth/model/artist_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:client/features/auth/model/artist_model.dart';

part 'current_artist_notifier.g.dart';

@Riverpod(keepAlive: true)
class CurrentArtistNotifier extends _$CurrentArtistNotifier{
  @override
  ArtistModel? build() {
    return null;
  }

  void addArtist(ArtistModel artist) {
    state = artist;
  }
}