import 'package:client/core/providers/current_album_notifier.dart';
import 'package:client/core/providers/current_playlist_notifier.dart';
import 'package:client/features/album/model/album_model.dart';
import 'package:client/features/album/repositories/album_remote_repository.dart';
import 'package:client/features/auth/repositories/auth_local_repository.dart';
import 'package:client/features/home/models/playlist_model.dart';
import 'package:client/features/home/repositories/playlist_remote_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'playlist_viewmodel.g.dart';


@riverpod
class PlaylistViewmodel extends _$PlaylistViewmodel {
  late PlaylistRemoteRepository _playlistRemoteRepository;
  late CurrentPlaylistNotifier _currentPlaylistNotifier;

  // AsyncValue<AlbumModel>? albumState;
  AsyncValue<List<PlaylistModel>>? allPlaylistState;

  @override
  AsyncValue<PlaylistModel>? build() {
    _playlistRemoteRepository = ref.watch(playlistRemoteRepositoryProvider);
    _currentPlaylistNotifier = ref.watch(currentPlaylistNotifierProvider.notifier);
    return const AsyncValue.loading();
  }

  Future<void> addPlaylist({
    required String name,
    required String cover_pic,
    required String email,
  }) async {
    state = const AsyncValue.loading();
    print(email);
    final res = await _playlistRemoteRepository.createPlaylist(
      name: name,
      image_url: cover_pic,
      email: email,
    );
    print(res);
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

  

Future<AsyncValue<List<PlaylistModel>>?> getAllPlaylistData({required String email}) async {
  allPlaylistState = const AsyncValue.loading();
  try {
    final res = await _playlistRemoteRepository.getAllPlaylist(email);
    //print("in view model: ${res}");

    if (res is Left) {
      final l = res as Left;
      //print("Error: ${l.value.message}");
      allPlaylistState = AsyncValue.error(l.value.message, StackTrace.current);
    } else if (res is Right) {
      final r = res as Right;  // Cast to Right type
      //print("Success: ${r.value}"); // Log successful response
      allPlaylistState = _getAllPlaylistDataSuccess(r.value);  // Handle Right (success)
    } else {
      //print("Unexpected response format: $res"); // Log unexpected response
    }

    //print("VAL: $allPlaylistState");
    return allPlaylistState;
  } catch (e) {
    // Catch any errors and set the error state
    print("Error caught: $e"); // Log error
    allPlaylistState = AsyncValue.error('An error occurred: $e', StackTrace.current);
    return allPlaylistState;
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

// Future<bool> checkRelease(album_id) async {
//   state = const AsyncValue.loading();
//   try{
//     final res = await _albumRemoteRepository.releaseStatus(album_id);
//     if(res is Left)
//     {
//       final l = res as Left;
//       state = AsyncValue.error(l, StackTrace.current);
//       return false;
//     }
//     else {
//       return true;
//     }
//   } catch (e) {
//     state = AsyncValue.error('An error occurred: $e', StackTrace.current);
//     print(state);
//     return false;
//   }
// }

// Future<bool> Unrelease( {required String album_id}) async {
//   state = const AsyncValue.loading();
//   try{
//     final res = await _albumRemoteRepository.unreleaseAlbum(album_id);
//     if(res is Left)
//     {
//       final l = res as Left;
//       state = AsyncValue.error(l, StackTrace.current);
//       return false;
//     }
//     else {
//       return true;
//     }
//   } catch (e) {
//     state = AsyncValue.error('An error occurred: $e', StackTrace.current);
//     print(state);
//     return false;
//   }
// }

AsyncValue<List<PlaylistModel>> _getAllPlaylistDataSuccess(List<PlaylistModel> playlists) {
  _currentPlaylistNotifier.allPlaylist(playlists); 
  return AsyncValue.data(playlists);
}
}
