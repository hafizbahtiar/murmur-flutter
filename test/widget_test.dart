// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:murmur/features/cart/data/repositories/in_memory_cart_repository.dart';
import 'package:murmur/features/cart/domain/usecases/add_to_cart_use_case.dart';
import 'package:murmur/features/cart/domain/usecases/clear_cart_use_case.dart';
import 'package:murmur/features/cart/domain/usecases/get_cart_total_use_case.dart';
import 'package:murmur/features/product/domain/models/product.dart';

void main() {
  test('Cart architecture smoke test', () {
    final repository = InMemoryCartRepository();
    final addToCart = AddToCartUseCase(repository);
    final clearCart = ClearCartUseCase(repository);
    const getCartTotal = GetCartTotalUseCase();

    const product = Product(
      id: 'p1',
      name: 'Test Product',
      description: 'Test Description',
      price: 12.5,
    );

    final firstAdd = addToCart(product);
    expect(firstAdd.length, 1);
    expect(firstAdd.first.quantity, 1);

    final secondAdd = addToCart(product);
    expect(secondAdd.length, 1);
    expect(secondAdd.first.quantity, 2);
    expect(getCartTotal(secondAdd), 25.0);

    final cleared = clearCart();
    expect(cleared, isEmpty);
  });
}
