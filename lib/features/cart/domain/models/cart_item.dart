import '../../../product/domain/models/product.dart';

class CartItem {
  final Product product;
  final int quantity;
  final bool isSelected;

  const CartItem({required this.product, required this.quantity, this.isSelected = true});

  CartItem copyWith({Product? product, int? quantity, bool? isSelected}) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  double get totalPrice => isSelected ? product.price * quantity : 0;
}