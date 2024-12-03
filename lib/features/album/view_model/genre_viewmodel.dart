import 'package:client/core/providers/current_genre_notifier.dart';
import 'package:client/features/album/model/album_model.dart';
import 'package:client/features/album/model/genre_model.dart';
import 'package:client/features/album/repositories/genre_remote_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'genre_viewmodel.g.dart';


@riverpod
class GenreViewmodel extends _$GenreViewmodel {
  late GenreRemoteRepository _genreRemoteRepository;
  late CurrentGenreNotifier _currentGenreNotifier;

  AsyncValue<List<GenreModel>>? allGenreState;

  @override
  AsyncValue<AlbumModel>? build() {
    _genreRemoteRepository = ref.watch(genreRemoteRepositoryProvider);
    _currentGenreNotifier = ref.watch(currentGenreNotifierProvider.notifier);
    return const AsyncValue.loading();
  }

Future<AsyncValue<List<GenreModel>>?> getAllGenre() async {
  allGenreState = const AsyncValue.loading();
  try {
    final res = await _genreRemoteRepository.getAllGenre();
    //print("in view model: ${res}");

    if (res is Left) {
      final l = res as Left;  // Cast to Left type
      //print("Error: ${l.value.message}"); // Log error message
      allGenreState = AsyncValue.error(l.value.message, StackTrace.current);  // Handle Left (error)
    } else if (res is Right) {
      final r = res as Right;  // Cast to Right type
      //print("Success: ${r.value}"); // Log successful response
      allGenreState = _getAllGenreDataSuccess(r.value);  // Handle Right (success)
    } else {
      //print("Unexpected response format: $res"); // Log unexpected response
    }

    //print("VAL: $allAlbumState");
    return allGenreState;
  } catch (e) {
    // Catch any errors and set the error state
    print("Error caught: $e"); // Log error
    allGenreState = AsyncValue.error('An error occurred: $e', StackTrace.current);
    return allGenreState;
  }
}

AsyncValue<List<GenreModel>> _getAllGenreDataSuccess(List<GenreModel> genres) {
  _currentGenreNotifier.addAlbums(genres); 
  return AsyncValue.data(genres);
}
}
