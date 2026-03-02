import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../product/presentation/providers/product_provider.dart';
import '../../../product/presentation/widgets/product_list/product_card.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_item_widget.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(cartProvider);
    final total = ref.read(cartProvider.notifier).totalPrice;
    final allSelected = items.isNotEmpty && items.every((item) => item.isSelected);
    final selectedCount = items.where((item) => item.isSelected).length;
    final productsAsync = ref.watch(productListProvider);

    // Shopee-like color scheme
    const primaryColor = Color(0xFFEE4D2D); // Shopee Orange

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light grey background like Shopee
      appBar: AppBar(
        title: Text(
          items.isEmpty ? 'Shopping Cart' : 'Shopping Cart (${items.length})',
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          TextButton(
            onPressed: () {
              // Edit mode or similar action
            },
            child: const Text('Edit', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
      body: items.isEmpty
          ? CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 16),
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFE0E0E0)),
                            ),
                            const Icon(Icons.shopping_cart_outlined, size: 60, color: Colors.white),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text('Your shopping cart is empty', style: TextStyle(color: Colors.grey, fontSize: 16)),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                            ),
                            child: const Text('Go Shopping Now'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        const Expanded(child: Divider(color: Colors.grey)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'You may also like',
                            style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ),
                        const Expanded(child: Divider(color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
                productsAsync.when(
                  data: (products) => SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final product = products[index];
                        return ProductCard(product: product);
                      }, childCount: products.length),
                    ),
                  ),
                  loading: () => const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Center(child: CircularProgressIndicator(color: primaryColor)),
                    ),
                  ),
                  error: (error, _) => SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(child: Text('Error loading recommendations: $error')),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
              ],
            )
          : ListView.separated(
              padding: const EdgeInsets.only(bottom: 100), // Space for bottom bar
              itemCount: items.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final item = items[index];
                return CartItemWidget(item: item, primaryColor: primaryColor);
              },
            ),
      bottomNavigationBar: items.isEmpty
          ? null
          : Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(25),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, -1),
                  ),
                ],
              ),
              child: SafeArea(
                child: SizedBox(
                  height: 60,
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            activeColor: primaryColor,
                            value: allSelected,
                            onChanged: (value) {
                              ref.read(cartProvider.notifier).toggleAllSelection(value ?? false);
                            },
                          ),
                          const Text('All', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              const Text('Total: ', style: TextStyle(fontSize: 14)),
                              Text(
                                'RM ${total.toStringAsFixed(2)}',
                                style: TextStyle(color: primaryColor, fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          // Optional: Savings text
                        ],
                      ),
                      const SizedBox(width: 12),
                      InkWell(
                        onTap: selectedCount > 0
                            ? () {
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(const SnackBar(content: Text('Proceed to Checkout')));
                              }
                            : null,
                        child: Container(
                          height: double.infinity,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          color: selectedCount > 0 ? primaryColor : Colors.grey,
                          child: Text(
                            'Check Out ($selectedCount)',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
