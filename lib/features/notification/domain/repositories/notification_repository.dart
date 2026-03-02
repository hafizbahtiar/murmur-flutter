import '../models/notification_category.dart';
import '../models/notification_item.dart';

abstract class NotificationRepository {
  Future<List<NotificationCategory>> getCategories();
  Future<List<NotificationItem>> getOrderUpdates();
  Future<List<NotificationItem>> getNotificationsByType(NotificationType type);
  Future<int> getTotalUnreadCount();
}
