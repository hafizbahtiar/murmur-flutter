import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../di/live_di.dart';
import '../../domain/models/live_video.dart';

part 'live_video_provider.g.dart';

@riverpod
class LiveVideoList extends _$LiveVideoList {
  @override
  Future<List<LiveVideo>> build({String category = 'For You'}) async {
    final getLiveVideos = ref.watch(getLiveVideosUseCaseProvider);
    return getLiveVideos(category: category);
  }
}
