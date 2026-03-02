import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../cart/presentation/screens/cart_screen.dart';
import '../../domain/models/product.dart';
import '../providers/product_review_provider.dart';
import '../widgets/product_bottom_bar.dart';
import '../widgets/product_review_card.dart';

class ProductReviewListScreen extends ConsumerStatefulWidget {
  final Product product;

  const ProductReviewListScreen({super.key, required this.product});

  @override
  ConsumerState<ProductReviewListScreen> createState() => _ProductReviewListScreenState();
}

class _ProductReviewListScreenState extends ConsumerState<ProductReviewListScreen> {
  int _selectedFilterIndex = 0; // 0: All, 1: With Media

  @override
  Widget build(BuildContext context) {
    final reviewsAsync = ref.watch(productReviewsProvider(widget.product.id));
    const primaryColor = Color(0xFFEE4D2D);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Review Ratings', style: TextStyle(color: Colors.black, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        forceMaterialTransparency: true,
        actions: [
          IconButton(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.shopping_cart_outlined, color: primaryColor),
                Positioned(
                  top: -4,
                  right: -4,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(color: primaryColor, shape: BoxShape.circle),
                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                    child: const Text(
                      '21',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen())),
          ),
          IconButton(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.chat_bubble_outline, color: primaryColor),
                Positioned(
                  top: -4,
                  right: -4,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(color: primaryColor, shape: BoxShape.circle),
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
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey[200], height: 1),
        ),
      ),
      body: Column(
        children: [
          // Top Tabs
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: primaryColor, width: 2)),
                  ),
                  child: const Text(
                    'Product Ratings',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
                  ),
                  child: const Text(
                    'Shop Reviews',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          // Filters
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildFilterChip(0, 'All', '(14)'),
                  const SizedBox(width: 8),
                  _buildFilterChip(1, 'With Media', '(3)'),
                  const SizedBox(width: 8),
                  _buildDropdownFilter('Star', icon: Icons.star, iconColor: Colors.orange),
                  const SizedBox(width: 8),
                  _buildDropdownFilter('Variation'),
                ],
              ),
            ),
          ),
          // List
          Expanded(
            child: reviewsAsync.when(
              data: (reviews) {
                return ListView.builder(
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    return ProductReviewCard(review: reviews[index], isDetailView: false);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ProductBottomBar(product: widget.product),
    );
  }

  Widget _buildFilterChip(int index, String line1, String line2) {
    final isSelected = _selectedFilterIndex == index;
    const primaryColor = Color(0xFFEE4D2D);

    return GestureDetector(
      onTap: () => setState(() => _selectedFilterIndex = index),
      child: Container(
        constraints: const BoxConstraints(minWidth: 80, minHeight: 48),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white
              : Colors.white, // Selected bg is actually very light orange or white with border
          border: Border.all(color: isSelected ? primaryColor : Colors.grey[300]!),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(line1, style: TextStyle(color: isSelected ? primaryColor : Colors.black, fontSize: 12)),
            Text(line2, style: TextStyle(color: isSelected ? primaryColor : Colors.black, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownFilter(String label, {IconData? icon, Color? iconColor}) {
    return Container(
      height: 48, // Match height of other chips
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontSize: 12)),
          if (icon != null) ...[const SizedBox(width: 4), Icon(icon, size: 12, color: iconColor)],
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}
