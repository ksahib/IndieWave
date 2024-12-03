import 'package:client/features/home/models/trend_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_trend_notifier.g.dart';

@Riverpod(keepAlive: true)
class CurrentTrendNotifier extends _$CurrentTrendNotifier {
  @override
  List<TrendModel>? build() {
    return [];
  }

  void addTrends(List<TrendModel> trends) {
    state = trends;
  }

  void addTrend(TrendModel trend) {
    state = [...state ?? [], trend];
  }

  void clearTracks() {
    state = [];
  }
}
