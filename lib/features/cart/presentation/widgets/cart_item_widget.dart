import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/cart_item.dart';
import '../providers/cart_provider.dart';
import 'quantity_button.dart';

class CartItemWidget extends ConsumerWidget {
  final CartItem item;
  final Color primaryColor;

  const CartItemWidget({super.key, required this.item, required this.primaryColor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Checkbox and Image Container (Aligned Center Vertically)
          SizedBox(
            height: 80, // Same as image height
            child: Row(
              children: [
                Checkbox(
                  activeColor: primaryColor,
                  value: item.isSelected,
                  onChanged: (value) {
                    ref.read(cartProvider.notifier).toggleSelection(item.product.id);
                  },
                ),
                // Product Image
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: CachedNetworkImage(
                      imageUrl: 'https://picsum.photos/200?random=${item.product.id}',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                      errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Variation: Default', // Placeholder variation
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                      const Icon(Icons.arrow_drop_down, size: 16, color: Colors.grey),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'RM ${item.product.price.toStringAsFixed(2)}',
                      style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    // Quantity Stepper
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          QuantityButton(
                            icon: Icons.remove,
                            onTap: () {
                              if (item.quantity > 1) {
                                ref.read(cartProvider.notifier).updateQuantity(item.product.id, item.quantity - 1);
                              } else {
                                // Optional: Ask to delete
                                ref.read(cartProvider.notifier).removeFromCart(item.product.id);
                              }
                            },
                          ),
                          Container(
                            width: 32,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(color: Colors.grey[300]!),
                                right: BorderSide(color: Colors.grey[300]!),
                              ),
                            ),
                            child: Text('${item.quantity}'),
                          ),
                          QuantityButton(
                            icon: Icons.add,
                            onTap: () {
                              ref.read(cartProvider.notifier).updateQuantity(item.product.id, item.quantity + 1);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
