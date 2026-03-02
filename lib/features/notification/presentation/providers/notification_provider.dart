import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/fake_notification_repository.dart';
import '../../domain/models/notification_category.dart';
import '../../domain/models/order_update.dart';
import '../../domain/repositories/notification_repository.dart';

part 'notification_provider.g.dart';

@riverpod
NotificationRepository notificationRepository(Ref ref) {
  return FakeNotificationRepository();
}

@riverpod
Future<List<NotificationCategory>> notificationCategories(Ref ref) async {
  final repo = ref.watch(notificationRepositoryProvider);
  return repo.fetchCategories();
}

@riverpod
Future<List<OrderUpdate>> orderUpdates(Ref ref) async {
  final repo = ref.watch(notificationRepositoryProvider);
  return repo.fetchOrderUpdates();
}
