import '../models/cart_item.dart';
import '../repositories/cart_repository.dart';

class ToggleCartSelectionUseCase {
  final CartRepository _repository;

  const ToggleCartSelectionUseCase(this._repository);

  List<CartItem> call(String productId) {
    final currentItems = _repository.getItems();
    final updatedItems = [
      for (final item in currentItems)
        if (item.product.id == productId) item.copyWith(isSelected: !item.isSelected) else item,
    ];

    return _repository.saveItems(updatedItems);
  }
}
