enum NotificationType { promotion, social, finance, shopeeUpdate, shopeePrize, orderUpdate }

class NotificationItem {
  final String id;
  final NotificationType type;
  final String title;
  final String description;
  final DateTime timestamp;
  final bool isRead;
  final String? imageUrl; // For order updates or items with images
  final String? bannerUrl; // For large marketing banners

  const NotificationItem({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.isRead,
    this.imageUrl,
    this.bannerUrl,
  });
}