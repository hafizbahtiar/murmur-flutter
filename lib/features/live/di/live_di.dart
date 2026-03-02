import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/fake_live_video_repository.dart';
import '../domain/repositories/live_video_repository.dart';
import '../domain/usecases/get_live_videos_use_case.dart';

final liveVideoRepositoryDiProvider = Provider<LiveVideoRepository>((ref) {
  return FakeLiveVideoRepository();
});

final getLiveVideosUseCaseProvider = Provider<GetLiveVideosUseCase>((ref) {
  final repository = ref.watch(liveVideoRepositoryDiProvider);
  return GetLiveVideosUseCase(repository);
});
