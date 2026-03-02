import '../models/cart_item.dart';
import '../repositories/cart_repository.dart';

class ClearCartUseCase {
  final CartRepository _repository;

  const ClearCartUseCase(this._repository);

  List<CartItem> call() {
    return _repository.clearItems();
  }
}
