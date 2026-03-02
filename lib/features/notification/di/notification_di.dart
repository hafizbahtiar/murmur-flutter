import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/fake_notification_repository.dart';
import '../domain/repositories/notification_repository.dart';
import '../domain/usecases/get_notification_categories_use_case.dart';
import '../domain/usecases/get_notifications_by_type_use_case.dart';
import '../domain/usecases/get_order_updates_use_case.dart';
import '../domain/usecases/get_total_unread_count_use_case.dart';

final notificationRepositoryDiProvider = Provider<NotificationRepository>((ref) {
  return FakeNotificationRepository();
});

final getNotificationCategoriesUseCaseProvider = Provider<GetNotificationCategoriesUseCase>((ref) {
  final repository = ref.watch(notificationRepositoryDiProvider);
  return GetNotificationCategoriesUseCase(repository);
});

final getOrderUpdatesUseCaseProvider = Provider<GetOrderUpdatesUseCase>((ref) {
  final repository = ref.watch(notificationRepositoryDiProvider);
  return GetOrderUpdatesUseCase(repository);
});

final getNotificationsByTypeUseCaseProvider = Provider<GetNotificationsByTypeUseCase>((ref) {
  final repository = ref.watch(notificationRepositoryDiProvider);
  return GetNotificationsByTypeUseCase(repository);
});

final getTotalUnreadCountUseCaseProvider = Provider<GetTotalUnreadCountUseCase>((ref) {
  final repository = ref.watch(notificationRepositoryDiProvider);
  return GetTotalUnreadCountUseCase(repository);
});
