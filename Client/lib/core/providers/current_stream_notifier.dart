import 'package:client/features/home/models/trend_model.dart';
import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod/riverpod.dart';

part 'current_stream_notifier.g.dart';

@riverpod
class CurrentStreamNotifier extends _$CurrentStreamNotifier{
  AudioPlayer? audioPlayer;
  bool isPlaying = false;
  @override
  TrendModel? build() {
    return null;
  }

  void updateSong(TrendModel track) async {
    audioPlayer = AudioPlayer();
    final audioSource = AudioSource.uri(
      Uri.parse(track.track_url),
    );
    await audioPlayer!.setAudioSource(audioSource);
    audioPlayer!.play();
    isPlaying = true;
    state = track;

  }

  void playPause() {
    if(isPlaying) {
      audioPlayer?.pause();
    } else {
      audioPlayer?.play();
    }
    isPlaying = !isPlaying;
    state = state?.copyWith(album_id: state?.album_id);
  }
}