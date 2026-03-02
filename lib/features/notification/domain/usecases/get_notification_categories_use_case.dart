import '../models/notification_category.dart';
import '../repositories/notification_repository.dart';

class GetNotificationCategoriesUseCase {
  final NotificationRepository _repository;

  const GetNotificationCategoriesUseCase(this._repository);

  Future<List<NotificationCategory>> call() {
    return _repository.getCategories();
  }
}
