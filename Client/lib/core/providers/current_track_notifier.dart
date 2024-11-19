import 'package:client/features/album/model/track_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_track_notifier.g.dart';

@Riverpod(keepAlive: true)
class CurrentTrackNotifier extends _$CurrentTrackNotifier {
  @override
  List<TrackModel>? build() {
    return [];
  }

  void addTracks(List<TrackModel> albums) {
    state = albums;
  }

  void addTrack(TrackModel album) {
    state = [...state ?? [], album];
  }

  void clearTracks() {
    state = [];
  }
}
