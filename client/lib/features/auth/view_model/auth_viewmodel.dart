import 'package:client/core/providers/current_album_notifier.dart';
import 'package:client/core/providers/current_artist_notifier.dart';
import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/features/auth/model/album_model.dart';
import 'package:client/features/auth/model/artist_model.dart';
import 'package:client/features/auth/model/user_model.dart';
import 'package:client/features/auth/repositories/auth_local_repository.dart';
import 'package:client/features/auth/repositories/auth_remote_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewmodel extends _$AuthViewmodel {
  late AuthRemoteRepository _authRemoteRepository;
  late AuthLocalRepository _authLocalRepository;
  late CurrentUserNotifier _currentUserNotifier;
  late CurrentArtistNotifier _currentArtistNotifier;
  late CurrentAlbumNotifier _currentAlbumNotifier;

  AsyncValue<AlbumModel>? albumState;
  AsyncValue<ArtistModel>? artistState;
  AsyncValue<List<AlbumModel>>? allAlbumState;

  @override
  AsyncValue<UserModel>? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    _currentUserNotifier = ref.watch(currentUserNotifierProvider.notifier);
    _currentArtistNotifier = ref.watch(currentArtistNotifierProvider.notifier);
    _currentAlbumNotifier = ref.watch(currentAlbumNotifierProvider.notifier);
    getData();
    return const AsyncValue.loading();
  }

  Future<void> initSharedPreferences() async {
    await _authLocalRepository.init();
  }

  Future<void> signUpUser({
    required String email,
    required String name,
    required String password
  }) async {
    state = const AsyncValue.loading();
    final res = await _authRemoteRepository.signup(
      name: name,
      mail: email,
      password: password
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

  Future<void> addAlbum({
    required String name,
    required String price,
    required String cover_art,
    required String artist_name,
  }) async {
    state = const AsyncValue.loading();
    final res = await _authRemoteRepository.createAlbum(
      name: name,
      price: price,
      cover_art: cover_art,
      artist_name: artist_name
      
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

  Future<void> signUpArtist({
    required String email,
    required String name,
    required String about,
    required String imageUrl,
  }) async {
    artistState = const AsyncValue.loading();
    print("email: ${email}");
    print("image: ${imageUrl}");
    final res = await _authRemoteRepository.artistSignup(
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

  Future<void> loginUser({
    required String email,
    required String password,
    required bool keepLoggedIn
  }) async {
    state = const AsyncValue.loading();
    final res = await _authRemoteRepository.login(
      mail: email, 
      password: password, 
      keepLoggedIn: keepLoggedIn
    );
    switch(res) {
      case Left(value: final l): 
        state = AsyncValue.error(l.message, StackTrace.current);
        break;
      case Right(value: final r): 
        state = _loginSuccess(r);
        break;
    };
    //print(val);
  }

  AsyncValue<UserModel> _loginSuccess(UserModel user)  {
    _authLocalRepository.setToken(user.token);
    _currentUserNotifier.addUser(user);
    return state = state = AsyncValue.data(user);
  }

  Future<UserModel?> getData() async {
  state = const AsyncValue.loading();
  try {
    final token = await _authLocalRepository.getToken();
    if (token != null) {
      final res = await _authRemoteRepository.getUser(token);
      final val = switch (res) {
        Left(value: final l) => state = AsyncValue.error(l.message, StackTrace.current),
        Right(value: final r) => state = _getDataSuccess(r),
      };
      return val.value;
    } else {
      state = AsyncValue.error('No token found', StackTrace.current);
    }
  } catch (e) {
    state = AsyncValue.error('An error occurred: $e', StackTrace.current);
  }
  return null;
}

Future<ArtistModel?> getArtistData() async {
  artistState = const AsyncValue.loading();
  try {
    final token = await _authLocalRepository.getToken();
    if (token != null) {
      final res = await _authRemoteRepository.getArtist(token);
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

// Future<AlbumModel?> getAllAlbumData() async {
//   albumState = const AsyncValue.loading();
//   try {
//     final token = await _authLocalRepository.getToken();
//     if (token != null) {
//       final res = await _authRemoteRepository.getArtist(token);
//       final val = switch (res) {
//         Left(value: final l) => albumState = AsyncValue.error(l.message, StackTrace.current),
//         Right(value: final r) => albumState = _getAllAlbumDataSuccess(r),
//       };
//       return val.value;
//     } else {
//       artistState = AsyncValue.error('No token found', StackTrace.current);
//     }
//   } catch (e) {
//     artistState = AsyncValue.error('An error occurred: $e', StackTrace.current);
//   }
//   return null;
// }

AsyncValue<UserModel> _getDataSuccess(UserModel user) {
    _currentUserNotifier.addUser(user);
    return state = AsyncValue.data(user);
  }


  AsyncValue<ArtistModel> _getArtistDataSuccess(ArtistModel artist) {
    _currentArtistNotifier.addArtist(artist);
    return artistState = AsyncValue.data(artist);
  }

Future<List<AlbumModel>?> getAllAlbumData({required String artistName}) async {
  allAlbumState = const AsyncValue.loading();
  try {
    final res = await _authRemoteRepository.getAllAlbum(artistName); 
    print("in view model: ${res}");
    switch (res) {
      case Left(value: final l):
        allAlbumState = AsyncValue.error(l.message, StackTrace.current);
        return null; 

      case Right(value: final r):
        allAlbumState = _getAllAlbumDataSuccess(r);
        return r; 
    }
  } catch (e) {
    allAlbumState = AsyncValue.error('An error occurred: $e', StackTrace.current);
  }
  return null;
}



AsyncValue<List<AlbumModel>> _getAllAlbumDataSuccess(List<AlbumModel> albums) {
  _currentAlbumNotifier.addAlbums(albums); 
  return AsyncValue.data(albums);
}


  


  //  AsyncValue<AlbumModel> _getAllAlbumDataSuccess(AlbumModel album) {
  //   _currentAlbumNotifier.addAlbums(album);
  //   return albumState = AsyncValue.data(album);
  // }
}
