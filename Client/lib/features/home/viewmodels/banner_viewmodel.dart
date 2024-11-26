import 'package:client/core/providers/current_banner_notifier.dart';
import 'package:client/core/providers/current_trend_notifier.dart';
import 'package:client/features/album/model/album_model.dart';
import 'package:client/features/home/models/trend_model.dart';
import 'package:client/features/home/repositories/banner_remote_repository.dart';
import 'package:client/features/home/repositories/trend_remote_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'banner_viewmodel.g.dart';


@riverpod
class BannerViewmodel extends _$BannerViewmodel {
  late BannerRemoteRepository _bannerRemoteRepository;
  late CurrentBannerNotifier _currentBannerNotifier;


  @override
  AsyncValue<AlbumModel>? build() {
    _bannerRemoteRepository = ref.watch(bannerRemoteRepositoryProvider);
    _currentBannerNotifier = ref.watch(currentBannerNotifierProvider.notifier);
    return const AsyncValue.loading();
  }


Future<AlbumModel?> banner(email) async {
  state = const AsyncValue.loading();
  try{
    final res = await _bannerRemoteRepository.getBanner(email);
    final val = switch(res) {
      Left(value: final l) => state = AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => state = _getBannerDataSuccess(r),
    };
    print("ALbum viewmode val: ${val.value}");
    return val.value;
  } catch (e) {
    state = AsyncValue.error('An error occurred: $e', StackTrace.current);
    print(state);
    return null;
  }
}

AsyncValue<AlbumModel> _getBannerDataSuccess(AlbumModel banner) {
  _currentBannerNotifier.addBanner(banner);
  return AsyncValue.data(banner);
}
}
