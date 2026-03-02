import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/fake_live_video_repository.dart';
import '../../domain/models/live_video.dart';
import '../../domain/repositories/live_video_repository.dart';

part 'live_video_provider.g.dart';

@riverpod
LiveVideoRepository liveVideoRepository(Ref ref) {
  return FakeLiveVideoRepository();
}

@riverpod
class LiveVideoList extends _$LiveVideoList {
  @override
  Future<List<LiveVideo>> build({String category = 'For You'}) async {
    final repo = ref.watch(liveVideoRepositoryProvider);
    return repo.fetchVideos(category: category);
  }
}
