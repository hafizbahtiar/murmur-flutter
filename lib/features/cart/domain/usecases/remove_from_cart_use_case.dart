import '../models/cart_item.dart';
import '../repositories/cart_repository.dart';

class RemoveFromCartUseCase {
  final CartRepository _repository;

  const RemoveFromCartUseCase(this._repository);

  List<CartItem> call(String productId) {
    final currentItems = _repository.getItems();
    final updatedItems = currentItems.where((item) => item.product.id != productId).toList();
    return _repository.saveItems(updatedItems);
  }
}
