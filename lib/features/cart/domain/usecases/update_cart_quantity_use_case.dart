import '../models/cart_item.dart';
import '../repositories/cart_repository.dart';

class UpdateCartQuantityUseCase {
  final CartRepository _repository;

  const UpdateCartQuantityUseCase(this._repository);

  List<CartItem> call(String productId, int quantity) {
    if (quantity < 1) {
      return _repository.getItems();
    }

    final currentItems = _repository.getItems();
    final updatedItems = [
      for (final item in currentItems)
        if (item.product.id == productId) item.copyWith(quantity: quantity) else item,
    ];

    return _repository.saveItems(updatedItems);
  }
}
