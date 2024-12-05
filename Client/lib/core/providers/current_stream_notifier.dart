import 'dart:convert';

import 'package:client/core/constants/server_constant.dart';
import 'package:client/features/auth/model/user_model.dart';
import 'package:client/features/home/models/trend_model.dart';
import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod/riverpod.dart';
import 'package:http/http.dart' as http;

part 'current_stream_notifier.g.dart';

@riverpod
class CurrentStreamNotifier extends _$CurrentStreamNotifier{
  AudioPlayer? audioPlayer;
  bool isPlaying = false;
  @override
  TrendModel? build() {
    return null;
  }

  Future<void> countStreams(String user, String track) async {
    try {
      await http.post(
        Uri.parse('${ServerConstant.serverUrl}/streamAdd'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": user, "track_id": track}),
      );
    } catch(e) {
      print(e);
    }
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

  void stop() {
    audioPlayer?.stop();
    state = state?.copyWith(album_id: state?.album_id);
  }
}