import '../../../product/domain/models/product.dart';
import '../models/cart_item.dart';
import '../repositories/cart_repository.dart';

class AddToCartUseCase {
  final CartRepository _repository;

  const AddToCartUseCase(this._repository);

  List<CartItem> call(Product product) {
    final currentItems = _repository.getItems();
    final existingIndex = currentItems.indexWhere((item) => item.product.id == product.id);

    if (existingIndex >= 0) {
      final existingItem = currentItems[existingIndex];
      final updatedItem = existingItem.copyWith(quantity: existingItem.quantity + 1);
      final updatedItems = List<CartItem>.from(currentItems);
      updatedItems[existingIndex] = updatedItem;
      return _repository.saveItems(updatedItems);
    }

    return _repository.saveItems([...currentItems, CartItem(product: product, quantity: 1)]);
  }
}
