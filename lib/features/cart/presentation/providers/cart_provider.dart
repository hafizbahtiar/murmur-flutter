import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/cart_item.dart';
import '../../../product/domain/models/product.dart';

part 'cart_provider.g.dart';

@riverpod
class CartNotifier extends _$CartNotifier {
  @override
  List<CartItem> build() {
    return [];
  }

  void addToCart(Product product) {
    final index = state.indexWhere((item) => item.product.id == product.id);

    if (index >= 0) {
      final updatedItem = state[index].copyWith(quantity: state[index].quantity + 1);

      state = [...state..removeAt(index), updatedItem];
    } else {
      state = [...state, CartItem(product: product, quantity: 1)];
    }
  }

  void removeFromCart(String productId) {
    state = state.where((item) => item.product.id != productId).toList();
  }

  void updateQuantity(String productId, int quantity) {
    if (quantity < 1) return;
    state = [
      for (final item in state)
        if (item.product.id == productId) item.copyWith(quantity: quantity) else item,
    ];
  }

  void toggleSelection(String productId) {
    state = [
      for (final item in state)
        if (item.product.id == productId) item.copyWith(isSelected: !item.isSelected) else item,
    ];
  }

  void toggleAllSelection(bool isSelected) {
    state = [for (final item in state) item.copyWith(isSelected: isSelected)];
  }

  void clearCart() {
    state = [];
  }

  double get totalPrice {
    return state.fold(0, (sum, item) => sum + item.totalPrice);
  }
}
