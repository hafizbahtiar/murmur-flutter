import '../models/notification_category.dart';
import '../models/notification_item.dart';

abstract class NotificationRepository {
  Future<List<NotificationCategory>> fetchCategories();
  Future<List<NotificationItem>> fetchOrderUpdates();
  Future<List<NotificationItem>> fetchNotificationsByType(NotificationType type);
  Future<int> getTotalUnreadCount();
}
