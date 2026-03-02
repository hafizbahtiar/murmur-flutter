import '../models/notification_item.dart';
import '../repositories/notification_repository.dart';

class GetOrderUpdatesUseCase {
  final NotificationRepository _repository;

  const GetOrderUpdatesUseCase(this._repository);

  Future<List<NotificationItem>> call() {
    return _repository.getOrderUpdates();
  }
}
