import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../features/cart/presentation/providers/cart_provider.dart';
import '../../../../features/cart/presentation/screens/cart_screen.dart';
import '../providers/notification_provider.dart';
import '../widgets/notification_category_tile.dart';
import '../widgets/order_update_tile.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(notificationCategoriesProvider);
    final updatesAsync = ref.watch(orderUpdatesProvider);
    final cartItems = ref.watch(cartProvider);
    final cartItemCount = cartItems.fold<int>(0, (sum, item) => sum + item.quantity);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0.5,
        forceMaterialTransparency: true,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, color: Color(0xFFEE4D2D)),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen()));
                },
              ),
              if (cartItemCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(color: Color(0xFFEE4D2D), shape: BoxShape.circle),
                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text(
                      cartItemCount > 99 ? '99+' : cartItemCount.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.chat_bubble_outline, color: Color(0xFFEE4D2D)),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(color: Color(0xFFEE4D2D), shape: BoxShape.circle),
                  constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                  child: const Text(
                    '20',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // 1. Categories List
          categoriesAsync.when(
            data: (categories) => SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => NotificationCategoryTile(category: categories[index]),
                childCount: categories.length,
              ),
            ),
            loading: () => const SliverToBoxAdapter(child: LinearProgressIndicator()),
            error: (_, _) => const SliverToBoxAdapter(child: SizedBox()),
          ),

          // 2. Section Header: Order Updates
          SliverToBoxAdapter(
            child: Container(
              color: const Color(0xFFF5F5F5),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Order Updates', style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
                  const Text('Read All (18)', style: TextStyle(color: Color(0xFFEE4D2D), fontSize: 14)),
                ],
              ),
            ),
          ),

          // 3. Order Updates List
          updatesAsync.when(
            data: (updates) => SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => OrderUpdateTile(update: updates[index]),
                childCount: updates.length,
              ),
            ),
            loading: () => const SliverToBoxAdapter(
              child: Center(
                child: Padding(padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
              ),
            ),
            error: (_, _) => const SliverToBoxAdapter(child: SizedBox()),
          ),
        ],
      ),
    );
  }
}
