import '../models/cart_item.dart';

abstract class CartRepository {
  List<CartItem> getItems();
  List<CartItem> saveItems(List<CartItem> items);
  List<CartItem> clearItems();
}
