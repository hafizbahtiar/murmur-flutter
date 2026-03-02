import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../di/notification_di.dart';
import '../../domain/models/notification_category.dart';
import '../../domain/models/notification_item.dart';

part 'notification_provider.g.dart';

@riverpod
Future<List<NotificationCategory>> notificationCategories(Ref ref) async {
  final getNotificationCategories = ref.watch(getNotificationCategoriesUseCaseProvider);
  return getNotificationCategories();
}

@riverpod
Future<List<NotificationItem>> orderUpdates(Ref ref) async {
  final getOrderUpdates = ref.watch(getOrderUpdatesUseCaseProvider);
  return getOrderUpdates();
}

@riverpod
Future<List<NotificationItem>> notificationList(Ref ref, NotificationType type) async {
  final getNotificationsByType = ref.watch(getNotificationsByTypeUseCaseProvider);
  return getNotificationsByType(type);
}

@riverpod
Future<int> totalUnreadCount(Ref ref) async {
  final getTotalUnreadCount = ref.watch(getTotalUnreadCountUseCaseProvider);
  return getTotalUnreadCount();
}
