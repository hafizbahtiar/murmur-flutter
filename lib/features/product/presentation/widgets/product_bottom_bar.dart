import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../../cart/presentation/screens/cart_screen.dart';
import '../../domain/models/product.dart';

class ProductBottomBar extends ConsumerWidget {
  final Product product;

  const ProductBottomBar({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const primaryColor = Color(0xFFEE4D2D);
    const tealColor = Color(0xFF26AA99);

    return SafeArea(
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            Expanded(
              child: Material(
                color: tealColor,
                child: InkWell(
                  onTap: () {
                    // Chat action
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.chat_bubble_outline, color: Colors.white, size: 20),
                      Text('Chat Now', style: TextStyle(color: Colors.white, fontSize: 10)),
                    ],
                  ),
                ),
              ),
            ),
            const VerticalDivider(width: 1, color: Colors.white24),
            Expanded(
              child: Material(
                color: tealColor,
                child: InkWell(
                  onTap: () {
                    ref.read(cartProvider.notifier).addToCart(product);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('Added to cart'), duration: Duration(seconds: 1)));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add_shopping_cart, color: Colors.white, size: 20),
                      Text('Add to Cart', style: TextStyle(color: Colors.white, fontSize: 10)),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Material(
                color: primaryColor,
                child: InkWell(
                  onTap: () {
                    ref.read(cartProvider.notifier).addToCart(product);
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CartScreen()));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Buy with Voucher', style: TextStyle(color: Colors.white, fontSize: 12)),
                      Text(
                        'RM${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
