import 'package:client/core/providers/current_trend_notifier.dart';
import 'package:client/features/home/models/trend_model.dart';
import 'package:client/features/home/repositories/trend_remote_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'trend_viewmodel.g.dart';


@riverpod
class TrendViewmodel extends _$TrendViewmodel {
  late TrendRemoteRepository _trendRemoteRepository;
  late CurrentTrendNotifier _currentTrendNotifier;

  AsyncValue<List<TrendModel>>? allTrendState;

  @override
  AsyncValue<TrendModel>? build() {
    _trendRemoteRepository = ref.watch(trendRemoteRepositoryProvider);
    _currentTrendNotifier = ref.watch(currentTrendNotifierProvider.notifier);
    return const AsyncValue.loading();
  }

Future<AsyncValue<List<TrendModel>>?> getAllTrendData({required String type}) async {
  allTrendState = const AsyncValue.loading();
  try {
    final res = await _trendRemoteRepository.getAllTrends(type);  // API call
    //print("in view model: ${res}");

    if (res is Left) {
      final l = res as Left;  // Cast to Left type
      //print("Error: ${l.value.message}"); // Log error message
      allTrendState = AsyncValue.error(l.value.message, StackTrace.current);  // Handle Left (error)
    } else if (res is Right) {
      final r = res as Right;  // Cast to Right type
      //print("Success: ${r.value}"); // Log successful response
      allTrendState = _getAllTrackDataSuccess(r.value);  // Handle Right (success)
    } else {
      //print("Unexpected response format: $res"); // Log unexpected response
    }

    //print("VAL: $allAlbumState");
    return allTrendState;
  } catch (e) {
    // Catch any errors and set the error state
    print("Error caught: $e"); // Log error
    allTrendState = AsyncValue.error('An error occurred: $e', StackTrace.current);
    return allTrendState;
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

AsyncValue<List<TrendModel>> _getAllTrackDataSuccess(List<TrendModel> trends) {
  _currentTrendNotifier.addTrends(trends); 
  return AsyncValue.data(trends);
}
}
