import 'package:client/features/album/model/track_model.dart';
import 'package:client/features/home/models/queue_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_queue_notifier.g.dart';

@Riverpod(keepAlive: true)
class CurrentQueueNotifier extends _$CurrentQueueNotifier {
  @override
  List<QueueModel>? build() {
    return [];
  }

  void addTracks(List<QueueModel> queues) {
    state = queues;
  }

  void addToQueue(QueueModel queue) {
    state = [...state ?? [], queue];
  }

  void clearTracks() {
    state = [];
  }
}
