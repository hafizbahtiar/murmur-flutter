import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../../cart/presentation/screens/cart_screen.dart';
import '../../../shared/presentation/widgets/app_empty_state.dart';
import '../../../shared/presentation/widgets/app_loading_state.dart';
import '../providers/product_provider.dart';
import '../widgets/product_list/product_card.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productListProvider);
    final cartItems = ref.watch(cartProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light grey background
      appBar: AppBar(
        title: const Text('Products', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CartScreen()));
            },
            icon: Badge(
              isLabelVisible: cartItems.isNotEmpty,
              label: Text(cartItems.length.toString()),
              child: const Icon(Icons.shopping_cart, color: Colors.black),
            ),
          ),
        ],
      ),
      body: products.when(
        loading: () => const AppLoadingState(message: 'Loading products...'),
        error: (error, stack) => AppEmptyState(
          icon: Icons.error_outline,
          title: 'Something went wrong',
          message: error.toString(),
          actionLabel: 'Retry',
          onAction: () => ref.invalidate(productListProvider),
        ),
        data: (items) {
          if (items.isEmpty) {
            return AppEmptyState(
              icon: Icons.inventory_2_outlined,
              title: 'No products',
              message: 'There are no products available right now.',
              actionLabel: 'Refresh',
              onAction: () => ref.invalidate(productListProvider),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65, // Adjusted aspect ratio for new card
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final product = items[index];
              return ProductCard(product: product);
            },
          );
        },
      ),
    );
  }
}
