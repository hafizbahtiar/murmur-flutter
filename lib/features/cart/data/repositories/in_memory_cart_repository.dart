import '../../domain/models/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';

class InMemoryCartRepository implements CartRepository {
  List<CartItem> _items = [];

  @override
  List<CartItem> getItems() {
    return List<CartItem>.unmodifiable(_items);
  }

  @override
  List<CartItem> saveItems(List<CartItem> items) {
    _items = List<CartItem>.from(items);
    return List<CartItem>.unmodifiable(_items);
  }

  @override
  List<CartItem> clearItems() {
    _items = [];
    return List<CartItem>.unmodifiable(_items);
  }
}
