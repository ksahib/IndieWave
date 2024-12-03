import 'package:client/features/album/model/album_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_banner_notifier.g.dart';

@Riverpod(keepAlive: true)
class CurrentBannerNotifier extends _$CurrentBannerNotifier {
  @override
  AlbumModel? build() {
    return null;
  }

  void addBanner(AlbumModel banner) {
    state = banner;
  }
}
