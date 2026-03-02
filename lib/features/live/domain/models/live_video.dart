class LiveVideo {
  final String id;
  final String videoUrl;
  final String hostName;
  final String hostAvatarUrl;
  final String description;
  final int viewers;
  final int likes;

  const LiveVideo({
    required this.id,
    required this.videoUrl,
    required this.hostName,
    required this.hostAvatarUrl,
    required this.description,
    required this.viewers,
    required this.likes,
  });
}
