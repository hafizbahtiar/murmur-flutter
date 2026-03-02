import '../repositories/notification_repository.dart';

class GetTotalUnreadCountUseCase {
  final NotificationRepository _repository;

  const GetTotalUnreadCountUseCase(this._repository);

  Future<int> call() {
    return _repository.getTotalUnreadCount();
  }
}
