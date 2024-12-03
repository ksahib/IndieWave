import 'package:client/core/providers/current_album_notifier.dart';
import 'package:client/features/album/model/album_model.dart';
import 'package:client/features/album/repositories/album_remote_repository.dart';
import 'package:client/features/auth/repositories/auth_local_repository.dart';
import 'package:client/features/home/repositories/playlist_remote_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'playlist_viewmodel.g.dart';


@riverpod
class PlaylistViewmodel extends _$PlaylistViewmodel {
  late PlaylistRemoteRepository _playlistRemoteRepository;

  AsyncValue<AlbumModel>? albumState;
  AsyncValue<List<AlbumModel>>? allAlbumState;

  @override
  AsyncValue<AlbumModel>? build() {
    _playlistRemoteRepository = ref.watch(playlistRemoteRepositoryProvider);
    return const AsyncValue.loading();
  }

  Future<void> addPlaylist({
    required String name,
    required String cover_pic,
  }) async {
    state = const AsyncValue.loading();
    final res = await _playlistRemoteRepository.createPlaylist(
      name: name,
      image_url: cover_pic,
      
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

  

// Future<AsyncValue<List<AlbumModel>>?> getAllAlbumData({required String artistName}) async {
//   allAlbumState = const AsyncValue.loading();
//   try {
//     final res = await _albumRemoteRepository.getAllAlbum(artistName);  // API call
//     //print("in view model: ${res}");

//     if (res is Left) {
//       final l = res as Left;  // Cast to Left type
//       //print("Error: ${l.value.message}"); // Log error message
//       allAlbumState = AsyncValue.error(l.value.message, StackTrace.current);  // Handle Left (error)
//     } else if (res is Right) {
//       final r = res as Right;  // Cast to Right type
//       //print("Success: ${r.value}"); // Log successful response
//       allAlbumState = _getAllAlbumDataSuccess(r.value);  // Handle Right (success)
//     } else {
//       //print("Unexpected response format: $res"); // Log unexpected response
//     }

//     //print("VAL: $allAlbumState");
//     return allAlbumState;
//   } catch (e) {
//     // Catch any errors and set the error state
//     print("Error caught: $e"); // Log error
//     allAlbumState = AsyncValue.error('An error occurred: $e', StackTrace.current);
//     return allAlbumState;
//   }
// }





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

// AsyncValue<List<AlbumModel>> _getAllAlbumDataSuccess(List<AlbumModel> albums) {
//   _currentAlbumNotifier.addAlbums(albums); 
//   return AsyncValue.data(albums);
// }
}
