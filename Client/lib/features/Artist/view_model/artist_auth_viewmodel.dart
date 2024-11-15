import 'package:client/core/providers/current_artist_notifier.dart';
import 'package:client/features/Artist/repositories/artist_auth_remote_repositories.dart';
import 'package:client/features/Artist/model/artist_model.dart';
import 'package:client/features/auth/repositories/auth_local_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'artist_auth_viewmodel.g.dart';

@riverpod
class ArtistAuthViewmodel extends _$ArtistAuthViewmodel {
  late ArtistAuthRemoteRepositories _artistAuthRemoteRepository;
  late AuthLocalRepository _authLocalRepository;
  late CurrentArtistNotifier _currentArtistNotifier;

  AsyncValue<ArtistModel>? artistState;

  @override
  AsyncValue<ArtistModel>? build() {
    _artistAuthRemoteRepository = ref.watch(artistAuthRemoteRepositoryProvider);
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    _currentArtistNotifier = ref.watch(currentArtistNotifierProvider.notifier);
    return const AsyncValue.loading();
  }

  Future<void> initSharedPreferences() async {
    await _authLocalRepository.init();
  }

  Future<void> signUpArtist({
    required String email,
    required String name,
    required String about,
    required String imageUrl,
  }) async {
    artistState = const AsyncValue.loading();
    print("email: ${email}");
    print("image: ${imageUrl}");
    final res = await _artistAuthRemoteRepository.artistSignup(
      name: name,
      mail: email,
      about: about,
      imageUrl: imageUrl
    );
    switch(res) {
      case Left(value: final l): 
        artistState = AsyncValue.error(l.message, StackTrace.current);
        break;
      case Right(value: final r): 
        artistState = AsyncValue.data(r);
        break;
    }
  }

Future<ArtistModel?> getArtistData() async {
  artistState = const AsyncValue.loading();
  try {
    final token = await _authLocalRepository.getToken();
    if (token != null) {
      final res = await _artistAuthRemoteRepository.getArtist(token);
      final val = switch (res) {
        Left(value: final l) => artistState = AsyncValue.error(l.message, StackTrace.current),
        Right(value: final r) => artistState = _getArtistDataSuccess(r),
      };
      return val.value;
    } else {
      artistState = AsyncValue.error('No token found', StackTrace.current);
    }
  } catch (e) {
    artistState = AsyncValue.error('An error occurred: $e', StackTrace.current);
  }
  return null;
}

  AsyncValue<ArtistModel> _getArtistDataSuccess(ArtistModel artist) {
    _currentArtistNotifier.addArtist(artist);
    return artistState = AsyncValue.data(artist);
  }
}
