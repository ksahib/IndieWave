import 'package:client/core/providers/current_album_notifier.dart';
import 'package:client/features/album/model/album_model.dart';
import 'package:client/features/album/repositories/album_remote_repository.dart';
import 'package:client/features/auth/repositories/auth_local_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'album_viewmodel.g.dart';


@riverpod
class AlbumViewmodel extends _$AlbumViewmodel {
  late AlbumRemoteRepository _albumRemoteRepository;
  late AuthLocalRepository _authLocalRepository;
  late CurrentAlbumNotifier _currentAlbumNotifier;

  AsyncValue<AlbumModel>? albumState;
  AsyncValue<List<AlbumModel>>? allAlbumState;

  @override
  AsyncValue<AlbumModel>? build() {
    _albumRemoteRepository = ref.watch(albumRemoteRepositoryProvider);
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    _currentAlbumNotifier = ref.watch(currentAlbumNotifierProvider.notifier);
    return const AsyncValue.loading();
  }

  Future<void> initSharedPreferences() async {
    await _authLocalRepository.init();
  }



  Future<void> addAlbum({
    required String name,
    required String price,
    required String cover_art,
    required String artist_name,
  }) async {
    state = const AsyncValue.loading();
    final res = await _albumRemoteRepository.createAlbum(
      name: name,
      price: price,
      cover_art: cover_art,
      artist_name: artist_name
      
    );
    switch(res) {
      case Left(value: final l): 
        albumState = AsyncValue.error(l.message, StackTrace.current);
        break;
      case Right(value: final r): 
        albumState = AsyncValue.data(r);
        break;
    };
    //print(val);
  }

Future<AsyncValue<List<AlbumModel>>> getAllAlbumData({required String artistName}) async {
  allAlbumState = const AsyncValue.loading();
  try {
    final res = await _albumRemoteRepository.getAllAlbum(artistName); 
    print("in view model: ${res}");
    switch (res) {
      case Left(value: final l):
        allAlbumState = AsyncValue.error(l.message, StackTrace.current);
        return allAlbumState!; 

      case Right(value: final r):
        allAlbumState = _getAllAlbumDataSuccess(r);
        return allAlbumState!; 
    }
  } catch (e) {
    allAlbumState = AsyncValue.error('An error occurred: $e', StackTrace.current);
  }
  return allAlbumState!;
}

AsyncValue<List<AlbumModel>> _getAllAlbumDataSuccess(List<AlbumModel> albums) {
  _currentAlbumNotifier.addAlbums(albums); 
  return AsyncValue.data(albums);
}
}
