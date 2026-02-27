import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

    // Shopee-like color scheme
    const primaryColor = Color(0xFFEE4D2D); // Shopee Orange

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light grey background like Shopee
      appBar: AppBar(
        title: const Text('Shopping Cart', style: TextStyle(color: Colors.black)),
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
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.shopping_cart_outlined, size: 100, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('Your cart is empty', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: primaryColor, foregroundColor: Colors.white),
                    child: const Text('Go Shopping'),
                  ),
                ],
              ),
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
