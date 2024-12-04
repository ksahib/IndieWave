import 'package:client/core/providers/current_queue_notifier.dart';
import 'package:client/core/providers/current_track_notifier.dart';
import 'package:client/features/album/model/track_model.dart';
import 'package:client/features/album/repositories/track_remote_repositories.dart';
import 'package:client/features/auth/repositories/auth_local_repository.dart';
import 'package:client/features/home/models/queue_model.dart';
import 'package:client/features/home/repositories/queue_remote_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'queue_viewmodel.g.dart';


@riverpod
class QueueViewmodel extends _$QueueViewmodel {
  late QueueRemoteRepository _qRemoteRepository;
  late CurrentQueueNotifier _currentQNotifier;

  AsyncValue<List<QueueModel>>? allTrackState;

  @override
  AsyncValue<QueueModel>? build() {
    _qRemoteRepository = ref.watch(queueRemoteRepositoryProvider);
    _currentQNotifier = ref.watch(currentQueueNotifierProvider.notifier);
    return const AsyncValue.loading();
  }




  Future<void> addToQueue({
    required String track_id,
    required String playlist_id,
  }) async {
    state = const AsyncValue.loading();
    final res = await _qRemoteRepository.addToPlaylist(
      playlist_id: playlist_id,
      track_id: track_id,
      
    );
    
    switch(res) {
      case Left(value: final l): 
        state = AsyncValue.error(l.message, StackTrace.current);
        break;
      case Right(value: final r): 
        state = AsyncValue.data(r);
        break;
    };
    //print(val);
  }

Future<AsyncValue<List<QueueModel>>?> getInPlaylistkData({required String playlistid}) async {
  allTrackState = const AsyncValue.loading();
  try {
    final res = await _qRemoteRepository.inPlaylist(playlistid);  // API call
    //print("in view model: ${res}");

    if (res is Left) {
      final l = res as Left;  // Cast to Left type
      //print("Error: ${l.value.message}"); // Log error message
      allTrackState = AsyncValue.error(l.value.message, StackTrace.current);  // Handle Left (error)
    } else if (res is Right) {
      final r = res as Right;  // Cast to Right type
      //print("Success: ${r.value}"); // Log successful response
      allTrackState = _getAllTrackDataSuccess(r.value);  // Handle Right (success)
    } else {
      //print("Unexpected response format: $res"); // Log unexpected response
    }

    //print("VAL: $allAlbumState");
    return allTrackState;
  } catch (e) {
    // Catch any errors and set the error state
    print("Error caught: $e"); // Log error
    allTrackState = AsyncValue.error('An error occurred: $e', StackTrace.current);
    return allTrackState;
  }
}





// Future<AlbumModel?> getAlbum(artist_name, album_name) async {
//   state = const AsyncValue.loading();
//   try{
//     final res = await _albumRemoteRepository.getCurrentAlbum(artist_name, album_name);
//     final val = switch(res) {
//       Left(value: final l) => state = AsyncValue.error(l.message, StackTrace.current),
//       Right(value: final r) => state = AsyncValue.data(r),
//     };
//     print("ALbum viewmode val: ${val.value}");
//     return val.value;
//   } catch (e) {
//     state = AsyncValue.error('An error occurred: $e', StackTrace.current);
//     print(state);
//     return null;
//   }
// }

AsyncValue<List<QueueModel>> _getAllTrackDataSuccess(List<QueueModel> tracks) {
  _currentQNotifier.addTracks(tracks); 
  return AsyncValue.data(tracks);
}
}
