import '../../domain/models/live_video.dart';
import '../../domain/repositories/live_video_repository.dart';

class FakeLiveVideoRepository implements LiveVideoRepository {
  static const _videos = [
    LiveVideo(
      id: '1',
      videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      hostName: 'Shopee Live Official',
      hostAvatarUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      description: 'Flash Sale! Up to 50% OFF on all electronics! #shopee #flashsale',
      viewers: 1542,
      likes: 12500,
    ),
    LiveVideo(
      id: '2',
      videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      hostName: 'Gadget Store MY',
      hostAvatarUrl: 'https://images.unsplash.com/photo-1599566150163-29194dcaad36?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      description: 'Reviewing the latest tech gadgets! Ask me anything.',
      viewers: 890,
      likes: 5600,
    ),
    LiveVideo(
      id: '3',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
      hostName: 'Fashion Hub',
      hostAvatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      description: 'New Arrival: Summer Collection 2024! ☀️👗',
      viewers: 3200,
      likes: 24000,
    ),
    LiveVideo(
      id: '4',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
      hostName: 'Gaming Zone',
      hostAvatarUrl: 'https://images.unsplash.com/photo-1527980965255-d3b416303d12?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      description: 'Live Gaming Session! Join the squad now. 🎮',
      viewers: 5600,
      likes: 45000,
    ),
     LiveVideo(
      id: '5',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
      hostName: 'Home & Living',
      hostAvatarUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      description: 'Best deals for your home decor! 🏠✨',
      viewers: 1200,
      likes: 8900,
    ),
  ];

  @override
  Future<List<LiveVideo>> getVideos({String category = 'For You'}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Simple mock filtering or shuffling based on category
    if (category == 'Video') {
      return _videos.reversed.toList();
    } else if (category == 'Live') {
      return [..._videos, ..._videos]; // More content for Live
    }
    
    return _videos;
  }
}
