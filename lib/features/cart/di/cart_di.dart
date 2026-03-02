import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/in_memory_cart_repository.dart';
import '../domain/repositories/cart_repository.dart';
import '../domain/usecases/add_to_cart_use_case.dart';
import '../domain/usecases/clear_cart_use_case.dart';
import '../domain/usecases/get_cart_items_use_case.dart';
import '../domain/usecases/get_cart_total_use_case.dart';
import '../domain/usecases/remove_from_cart_use_case.dart';
import '../domain/usecases/toggle_all_cart_selection_use_case.dart';
import '../domain/usecases/toggle_cart_selection_use_case.dart';
import '../domain/usecases/update_cart_quantity_use_case.dart';

final cartRepositoryDiProvider = Provider<CartRepository>((ref) {
  return InMemoryCartRepository();
});

final getCartItemsUseCaseProvider = Provider<GetCartItemsUseCase>((ref) {
  final repository = ref.watch(cartRepositoryDiProvider);
  return GetCartItemsUseCase(repository);
});

final addToCartUseCaseProvider = Provider<AddToCartUseCase>((ref) {
  final repository = ref.watch(cartRepositoryDiProvider);
  return AddToCartUseCase(repository);
});

final removeFromCartUseCaseProvider = Provider<RemoveFromCartUseCase>((ref) {
  final repository = ref.watch(cartRepositoryDiProvider);
  return RemoveFromCartUseCase(repository);
});

final updateCartQuantityUseCaseProvider = Provider<UpdateCartQuantityUseCase>((ref) {
  final repository = ref.watch(cartRepositoryDiProvider);
  return UpdateCartQuantityUseCase(repository);
});

final toggleCartSelectionUseCaseProvider = Provider<ToggleCartSelectionUseCase>((ref) {
  final repository = ref.watch(cartRepositoryDiProvider);
  return ToggleCartSelectionUseCase(repository);
});

final toggleAllCartSelectionUseCaseProvider = Provider<ToggleAllCartSelectionUseCase>((ref) {
  final repository = ref.watch(cartRepositoryDiProvider);
  return ToggleAllCartSelectionUseCase(repository);
});

final clearCartUseCaseProvider = Provider<ClearCartUseCase>((ref) {
  final repository = ref.watch(cartRepositoryDiProvider);
  return ClearCartUseCase(repository);
});

final getCartTotalUseCaseProvider = Provider<GetCartTotalUseCase>((ref) {
  return const GetCartTotalUseCase();
});
