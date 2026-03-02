import '../models/notification_category.dart';
import '../models/order_update.dart';

abstract class NotificationRepository {
  Future<List<NotificationCategory>> fetchCategories();
  Future<List<OrderUpdate>> fetchOrderUpdates();
}
