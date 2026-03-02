import '../models/notification_item.dart';
import '../repositories/notification_repository.dart';

class GetNotificationsByTypeUseCase {
  final NotificationRepository _repository;

  const GetNotificationsByTypeUseCase(this._repository);

  Future<List<NotificationItem>> call(NotificationType type) {
    return _repository.getNotificationsByType(type);
  }
}
