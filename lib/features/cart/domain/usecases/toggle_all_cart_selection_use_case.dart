import '../models/cart_item.dart';
import '../repositories/cart_repository.dart';

class ToggleAllCartSelectionUseCase {
  final CartRepository _repository;

  const ToggleAllCartSelectionUseCase(this._repository);

  List<CartItem> call(bool isSelected) {
    final currentItems = _repository.getItems();
    final updatedItems = [for (final item in currentItems) item.copyWith(isSelected: isSelected)];
    return _repository.saveItems(updatedItems);
  }
}
