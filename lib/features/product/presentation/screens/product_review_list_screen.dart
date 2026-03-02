import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../../cart/presentation/screens/cart_screen.dart';
import '../../../shared/presentation/widgets/adaptive_back_button.dart';
import '../../../shared/presentation/widgets/bottom_sheet/bottom_sheet.dart';
import '../../domain/models/product.dart';
import '../../domain/models/product_review.dart';
import '../providers/product_review_provider.dart';
import '../widgets/product_bottom_bar.dart';
import '../widgets/product_review_card.dart';
import '../widgets/rating_filter_content.dart';
import 'review_reel_screen.dart';

class ProductReviewListScreen extends ConsumerStatefulWidget {
  final Product product;

  const ProductReviewListScreen({super.key, required this.product});

  @override
  ConsumerState<ProductReviewListScreen> createState() => _ProductReviewListScreenState();
}

class _ProductReviewListScreenState extends ConsumerState<ProductReviewListScreen> {
  int _selectedFilterIndex = 0; // 0: All, 1: With Media, 2: 5 Star, 3: 4 Star, 4: 3 Star, 5: 2 Star, 6: 1 Star

  @override
  Widget build(BuildContext context) {
    final reviewsAsync = ref.watch(productReviewsProvider(widget.product.id));
    final cartItems = ref.watch(cartProvider);
    final cartItemCount = cartItems.length;
    const primaryColor = Color(0xFFEE4D2D);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Review Ratings', style: TextStyle(color: Colors.black, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const AdaptiveBackButton(color: Color(0xFFEE4D2D)),
        forceMaterialTransparency: true,
        actions: [
          IconButton(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.shopping_cart_outlined, color: primaryColor),
                if (cartItemCount > 0)
                  Positioned(
                    top: -4,
                    right: -4,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(color: primaryColor, shape: BoxShape.circle),
                      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                      child: Text(
                        '$cartItemCount',
                        style: const TextStyle(color: Colors.white, fontSize: 10),
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
      body: reviewsAsync.when(
        data: (reviews) {
          // Calculate counts
          final allCount = reviews.length;
          final withMediaCount = reviews.where((r) => r.imageUrls.isNotEmpty).length;
          final star5Count = reviews.where((r) => r.rating >= 4.5).length;
          final star4Count = reviews.where((r) => r.rating >= 3.5 && r.rating < 4.5).length;
          final star3Count = reviews.where((r) => r.rating >= 2.5 && r.rating < 3.5).length;
          final star2Count = reviews.where((r) => r.rating >= 1.5 && r.rating < 2.5).length;
          final star1Count = reviews.where((r) => r.rating < 1.5).length;

          // Filter reviews based on selection
          List<ProductReview> filteredReviews = reviews;
          if (_selectedFilterIndex == 1) {
            filteredReviews = reviews.where((r) => r.imageUrls.isNotEmpty).toList();
          } else if (_selectedFilterIndex == 2) {
            filteredReviews = reviews.where((r) => r.rating >= 4.5).toList();
          } else if (_selectedFilterIndex == 3) {
            filteredReviews = reviews.where((r) => r.rating >= 3.5 && r.rating < 4.5).toList();
          } else if (_selectedFilterIndex == 4) {
            filteredReviews = reviews.where((r) => r.rating >= 2.5 && r.rating < 3.5).toList();
          } else if (_selectedFilterIndex == 5) {
            filteredReviews = reviews.where((r) => r.rating >= 1.5 && r.rating < 2.5).toList();
          } else if (_selectedFilterIndex == 6) {
            filteredReviews = reviews.where((r) => r.rating < 1.5).toList();
          }

          return Column(
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
                      _buildFilterChip(0, 'All', '($allCount)'),
                      const SizedBox(width: 8),
                      _buildFilterChip(1, 'With Media', '($withMediaCount)'),
                      const SizedBox(width: 8),
                      _buildRatingFilter(star5Count, star4Count, star3Count, star2Count, star1Count),
                      const SizedBox(width: 8),
                      _buildDropdownFilter('Variation'),
                    ],
                  ),
                ),
              ),
              // List
              Expanded(
                child: filteredReviews.isEmpty
                    ? const Center(child: Text('No reviews found'))
                    : ListView.builder(
                        itemCount: filteredReviews.length,
                        itemBuilder: (context, index) {
                          return ProductReviewCard(
                            review: filteredReviews[index],
                            isDetailView: false,
                            onImageTap: (_) {
                              final reviewsWithImages = reviews.where((r) => r.imageUrls.isNotEmpty).toList();
                              final review = filteredReviews[index];
                              final initialIndex = reviewsWithImages.indexOf(review);
                              if (initialIndex != -1) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => ReviewReelScreen(
                                      reviews: reviewsWithImages,
                                      initialIndex: initialIndex,
                                      product: widget.product,
                                    ),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
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
    return GestureDetector(
      onTap: () {
        showCustomBottomSheet(
          context: context,
          title: 'Select Variation',
          child: Column(
            children: [
              _buildBottomSheetOption('All Variations', true),
              _buildBottomSheetOption('Titanium Blue, 256GB', false),
              _buildBottomSheetOption('Natural Titanium, 512GB', false),
              _buildBottomSheetOption('Black Titanium, 1TB', false),
            ],
          ),
        );
      },
      child: Container(
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
      ),
    );
  }

  Widget _buildBottomSheetOption(String text, bool isSelected) {
    const primaryColor = Color(0xFFEE4D2D);
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        // TODO: Implement variation filtering logic
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[100]!)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                color: isSelected ? primaryColor : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (isSelected) const Icon(Icons.check, color: primaryColor, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingFilter(int star5Count, int star4Count, int star3Count, int star2Count, int star1Count) {
    bool isRatingSelected = _selectedFilterIndex >= 2 && _selectedFilterIndex <= 6;
    String label = 'Star';
    if (_selectedFilterIndex == 2) {
      label = 'Star 5';
    } else if (_selectedFilterIndex == 3) {
      label = 'Star 4';
    } else if (_selectedFilterIndex == 4) {
      label = 'Star 3';
    } else if (_selectedFilterIndex == 5) {
      label = 'Star 2';
    } else if (_selectedFilterIndex == 6) {
      label = 'Star 1';
    }

    const primaryColor = Color(0xFFEE4D2D);

    return GestureDetector(
      onTap: () {
        showCustomBottomSheet(
          context: context,
          title: '', // Custom header used instead
          padding: EdgeInsets.zero,
          header: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Review Filter', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          child: RatingFilterContent(
            initialSelection: _selectedFilterIndex,
            star5Count: star5Count,
            star4Count: star4Count,
            star3Count: star3Count,
            star2Count: star2Count,
            star1Count: star1Count,
            onApply: (index) {
              setState(() => _selectedFilterIndex = index);
            },
          ),
        );
      },
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: isRatingSelected ? Colors.white : Colors.white,
          border: Border.all(color: isRatingSelected ? primaryColor : Colors.grey[300]!),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Text(label, style: TextStyle(fontSize: 12, color: isRatingSelected ? primaryColor : Colors.black)),
            const SizedBox(width: 4),
            Icon(Icons.keyboard_arrow_down, size: 16, color: isRatingSelected ? primaryColor : Colors.grey),
          ],
        ),
      ),
    );
  }
}
