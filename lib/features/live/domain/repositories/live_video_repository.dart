import '../models/live_video.dart';

abstract class LiveVideoRepository {
  Future<List<LiveVideo>> fetchVideos({String category = 'For You'});
}
