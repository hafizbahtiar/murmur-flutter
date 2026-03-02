import '../models/cart_item.dart';
import '../repositories/cart_repository.dart';

class GetCartItemsUseCase {
  final CartRepository _repository;

  const GetCartItemsUseCase(this._repository);

  List<CartItem> call() {
    return _repository.getItems();
  }
}
