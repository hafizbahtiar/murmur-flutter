import '../models/cart_item.dart';

class GetCartTotalUseCase {
  const GetCartTotalUseCase();

  double call(List<CartItem> items) {
    return items.fold(0, (sum, item) => sum + item.totalPrice);
  }
}
