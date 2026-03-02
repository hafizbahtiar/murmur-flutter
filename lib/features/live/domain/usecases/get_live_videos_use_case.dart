import '../models/live_video.dart';
import '../repositories/live_video_repository.dart';

class GetLiveVideosUseCase {
  final LiveVideoRepository _repository;

  const GetLiveVideosUseCase(this._repository);

  Future<List<LiveVideo>> call({String category = 'For You'}) {
    return _repository.getVideos(category: category);
  }
}
