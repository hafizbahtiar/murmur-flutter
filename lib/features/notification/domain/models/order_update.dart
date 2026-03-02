class OrderUpdate {
  final String id;
  final String imageUrl;
  final String title;
  final String description;
  final DateTime timestamp;
  final bool isRead;

  const OrderUpdate({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.isRead,
  });
}
