import '../models/live_video.dart';

abstract class LiveVideoRepository {
  Future<List<LiveVideo>> getVideos({String category = 'For You'});
}
