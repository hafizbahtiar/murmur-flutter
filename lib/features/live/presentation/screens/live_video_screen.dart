import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../providers/live_video_provider.dart';
import '../../domain/models/live_video.dart';

class LiveVideoScreen extends ConsumerStatefulWidget {
  final bool isActive;
  const LiveVideoScreen({super.key, this.isActive = true});

  @override
  ConsumerState<LiveVideoScreen> createState() => _LiveVideoScreenState();
}

class _LiveVideoScreenState extends ConsumerState<LiveVideoScreen> {
  final PageController _pageController = PageController();
  String _selectedTab = 'For You';
  int _currentPage = 0;

  bool _isScreenVisible = true;

  @override
  Widget build(BuildContext context) {
    final liveVideosAsync = ref.watch(liveVideoListProvider(category: _selectedTab));

    return VisibilityDetector(
      key: const Key('live-video-screen-visibility'),
      onVisibilityChanged: (info) {
        final visible = info.visibleFraction > 0.5;
        if (_isScreenVisible != visible) {
          setState(() {
            _isScreenVisible = visible;
          });
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // Vertical Video Feed
            liveVideosAsync.when(
              data: (videos) {
                if (videos.isEmpty) {
                  return const Center(
                    child: Text('No videos available', style: TextStyle(color: Colors.white)),
                  );
                }
                return PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: videos.length,
                  itemBuilder: (context, index) {
                    // Only play video if it's the current page AND screen is visible AND tab is active
                    return _VideoItem(
                      video: videos[index],
                      shouldPlay: index == _currentPage && _isScreenVisible && widget.isActive,
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(
                child: Text('Error: $err', style: const TextStyle(color: Colors.white)),
              ),
            ),

            // Top Navigation
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 16,
            right: 16,
            child: Row(
              children: [
                const Icon(Icons.person_outline, color: Colors.white, size: 28),
                const SizedBox(width: 16),
                const Icon(Icons.search, color: Colors.white, size: 28),
                const Spacer(),
                _buildTopTab('Video'),
                const SizedBox(width: 16),
                _buildTopTab('Live'),
                const SizedBox(width: 16),
                _buildTopTab('For You'),
                const Spacer(),
                const Icon(Icons.add_box_outlined, color: Colors.white, size: 28),
              ],
            ),
          ),

          // Host Info Bar (Below Top Nav)
          Positioned(
            top: MediaQuery.of(context).padding.top + 60,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Shopee Live Host',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.verified, color: Colors.yellow, size: 12),
                        ],
                      ),
                      const Text('12.5K Viewers', style: TextStyle(color: Colors.white70, fontSize: 10)),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEE4D2D), // Shopee Orange
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.add, color: Colors.white, size: 12),
                        SizedBox(width: 2),
                        Text(
                          'Follow',
                          style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }

  Widget _buildTopTab(String text) {
    final isSelected = _selectedTab == text;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = text;
          _pageController.jumpToPage(0); // Reset to first video when switching tabs
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white60,
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (isSelected) Container(margin: const EdgeInsets.only(top: 4), width: 20, height: 2, color: Colors.white),
        ],
      ),
    );
  }
}

class _VideoItem extends StatefulWidget {
  final LiveVideo video;
  final bool shouldPlay;

  const _VideoItem({required this.video, required this.shouldPlay});

  @override
  State<_VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<_VideoItem> {
  late VideoPlayerController _controller;
  bool _initialized = false;
  bool _isPlaying = false;
  bool _showPlayIcon = false;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  @override
  void didUpdateWidget(_VideoItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shouldPlay && !oldWidget.shouldPlay) {
      if (_isPlaying) _controller.play(); // Resume if it was playing
    } else if (!widget.shouldPlay && oldWidget.shouldPlay) {
      _controller.pause();
    }
  }

  void _initializeController() {
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.video.videoUrl))
      ..initialize()
          .then((_) {
            if (mounted) {
              setState(() {
                _initialized = true;
                _isPlaying = true; // Auto-play by default
              });
              _controller.setLooping(true);
              if (widget.shouldPlay) {
                _controller.play();
              }
            }
          })
          .catchError((error) {
            debugPrint('Video error: $error');
          });
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
      _showPlayIcon = true;
    });

    if (_isPlaying) {
      _controller.play();
    } else {
      _controller.pause();
    }

    // Hide icon after delay
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        setState(() {
          _showPlayIcon = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Only auto-play if shouldPlay is true AND user hasn't manually paused
    if (widget.shouldPlay && _initialized && !_controller.value.isPlaying && _isPlaying) {
      _controller.play();
    } else if (!widget.shouldPlay && _controller.value.isPlaying) {
      _controller.pause();
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        // 1. Video Player with Gesture Detector
        GestureDetector(
          onTap: _togglePlayPause,
          child: _initialized
              ? FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                )
              : Container(
                  color: Colors.black,
                  child: const Center(child: CircularProgressIndicator(color: Colors.white)),
                ),
        ),

        // Play/Pause Icon Overlay
        if (_showPlayIcon)
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.5), shape: BoxShape.circle),
              child: Icon(_isPlaying ? Icons.play_arrow : Icons.pause, color: Colors.white, size: 48),
            ),
          ),

        // 2. Overlay Gradient
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 300,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black.withValues(alpha: 0.6), Colors.transparent],
              ),
            ),
          ),
        ),

        // 3. Right Side Actions
        Positioned(
          right: 16,
          bottom: 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildActionItem(Icons.favorite, '${widget.video.likes}', Colors.white),
              const SizedBox(height: 24),
              _buildActionItem(Icons.comment, '458', Colors.white),
              const SizedBox(height: 24),
              _buildActionItem(Icons.share, 'Share', Colors.white),
              const SizedBox(height: 24),
              _buildActionItem(Icons.card_giftcard, '', Colors.pinkAccent), // Gift
              const SizedBox(height: 40),
            ],
          ),
        ),

        // 4. Bottom Interaction Area
        Positioned(left: 0, right: 0, bottom: 0, child: _buildBottomBar(context)),

        // 5. System Message / Chat Area
        Positioned(
          left: 16,
          bottom: 220,
          right: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(widget.video.description, style: const TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.transparent,
      child: Row(
        children: [
          // Shopping Bag
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFEE4D2D), Colors.orange],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 24),
              ),
              Positioned(
                top: -4,
                right: -4,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: const Text(
                    '291',
                    style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),

          // Chat Input
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text('Say Something...', style: TextStyle(color: Colors.white70, fontSize: 14)),
            ),
          ),
          const SizedBox(width: 12),

          // Icons
          const Icon(Icons.more_horiz, color: Colors.white, size: 28),
          const SizedBox(width: 12),
          const Icon(Icons.card_giftcard, color: Colors.white, size: 28), // Gift/Voucher?
          const SizedBox(width: 12),
          const Icon(Icons.reply, color: Colors.white, size: 28), // Share arrow
        ],
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String label, Color color) {
    return Column(
      children: [
        Icon(icon, size: 20, color: color),
        if (label.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ],
    );
  }
}
