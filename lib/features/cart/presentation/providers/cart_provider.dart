import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../di/cart_di.dart';
import '../../domain/models/cart_item.dart';
import '../../../product/domain/models/product.dart';

part 'cart_provider.g.dart';

@riverpod
class CartNotifier extends _$CartNotifier {
  @override
  List<CartItem> build() {
    final getCartItems = ref.watch(getCartItemsUseCaseProvider);
    return getCartItems();
  }

  void addToCart(Product product) {
    final addToCart = ref.read(addToCartUseCaseProvider);
    state = addToCart(product);
  }

  void removeFromCart(String productId) {
    final removeFromCart = ref.read(removeFromCartUseCaseProvider);
    state = removeFromCart(productId);
  }

  void updateQuantity(String productId, int quantity) {
    final updateQuantity = ref.read(updateCartQuantityUseCaseProvider);
    state = updateQuantity(productId, quantity);
  }

  void toggleSelection(String productId) {
    final toggleSelection = ref.read(toggleCartSelectionUseCaseProvider);
    state = toggleSelection(productId);
  }

  void toggleAllSelection(bool isSelected) {
    final toggleAllSelection = ref.read(toggleAllCartSelectionUseCaseProvider);
    state = toggleAllSelection(isSelected);
  }

  void clearCart() {
    final clearCart = ref.read(clearCartUseCaseProvider);
    state = clearCart();
  }

  double get totalPrice {
    final getCartTotal = ref.read(getCartTotalUseCaseProvider);
    return getCartTotal(state);
  }
}
