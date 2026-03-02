import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../../cart/presentation/screens/cart_screen.dart';
import '../../domain/models/product.dart';

import '../providers/product_review_provider.dart';
import '../providers/product_provider.dart';
import '../widgets/product_bottom_bar.dart';
import '../widgets/product_review_card.dart';
import 'product_review_list_screen.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  ConsumerState<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  double _opacity = 0.0;
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    if (offset < 0) {
      if (_opacity != 0.0) setState(() => _opacity = 0.0);
    } else if (offset > 200) {
      if (_opacity != 1.0) setState(() => _opacity = 1.0);
    } else {
      setState(() => _opacity = offset / 200);
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final cartItems = ref.watch(cartProvider);
    const primaryColor = Color(0xFFEE4D2D);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Image Sliver
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 400, // Match Shopee image height
                      color: Colors.grey[200],
                      child: product.images.isNotEmpty
                          ? PageView.builder(
                              itemCount: product.images.length,
                              onPageChanged: (index) => setState(() => _currentImageIndex = index),
                              itemBuilder: (context, index) {
                                return Image.network(product.images[index], fit: BoxFit.cover);
                              },
                            )
                          : Image.network('https://picsum.photos/400/400?random=${product.id}', fit: BoxFit.cover),
                    ),
                    // Image Counter
                    if (product.images.isNotEmpty)
                      Positioned(
                        bottom: 16,
                        right: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(100),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            '${_currentImageIndex + 1}/${product.images.length}',
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              // Content
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    // Price & Banner Section
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          // 3.3 Banner
                          Container(
                            height: 40,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(colors: [primaryColor, Color(0xFFFF5722)]),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    '3.3',
                                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  color: const Color(0xFF26AA99),
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  height: double.infinity,
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'FREE\nSHIPPING',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      height: 1.0,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    color: const Color(0xFFF6D600),
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    height: double.infinity,
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      '10% CASHBACK',
                                      style: TextStyle(color: primaryColor, fontSize: 12, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Price Info
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'RM',
                                      style: TextStyle(color: primaryColor, fontSize: 14, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      product.price.toStringAsFixed(2),
                                      style: const TextStyle(
                                        color: primaryColor,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: primaryColor),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      child: const Text(
                                        'After Voucher',
                                        style: TextStyle(color: primaryColor, fontSize: 10),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'RM${(product.price / 12).toStringAsFixed(2)} x 12 months with SPayLater',
                                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                ),
                                const SizedBox(height: 12),
                                // Title with Tags
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: Container(
                                          margin: const EdgeInsets.only(right: 4),
                                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFD0011B),
                                            borderRadius: BorderRadius.circular(2),
                                          ),
                                          child: const Text(
                                            'Fulfilled',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (product.isPreferred)
                                        WidgetSpan(
                                          alignment: PlaceholderAlignment.middle,
                                          child: Container(
                                            margin: const EdgeInsets.only(right: 4),
                                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFD0011B),
                                              borderRadius: BorderRadius.circular(2),
                                            ),
                                            child: const Text(
                                              'Mall',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      TextSpan(
                                        text: product.name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          height: 1.3,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Info Section
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          _buildInfoRow(
                            Icons.timer_outlined,
                            'Pre-Order (ships in 30 days)',
                            subtitle: 'Get a RM5.00 voucher if your order arrives late.',
                          ),
                          const Divider(height: 1, indent: 16),
                          _buildInfoRow(
                            Icons.verified_user_outlined,
                            '15 Days Free Returns • 100% Authentic • Free Shipping',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Trade In
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          const Icon(Icons.sync_alt, color: primaryColor, size: 20),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text('Trade in and save up to RM1,016', style: TextStyle(fontSize: 14)),
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              foregroundColor: primaryColor,
                              side: const BorderSide(color: primaryColor),
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              minimumSize: const Size(0, 32),
                            ),
                            child: const Text('Get a Quote', style: TextStyle(fontSize: 12)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Description
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Product Description',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product.description,
                            style: TextStyle(fontSize: 14, color: Colors.grey[800], height: 1.5),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Reviews
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Consumer(
                            builder: (context, ref, child) {
                              final reviewsAsyncValue = ref.watch(productReviewsProvider(product.id));

                              return reviewsAsyncValue.when(
                                data: (reviews) {
                                  if (reviews.isEmpty) {
                                    return const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 16),
                                      child: Text('No reviews yet.'),
                                    );
                                  }
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                '5.0',
                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                              ),
                                              const SizedBox(width: 4),
                                              const Icon(Icons.star, color: Color(0xFFFFC107), size: 16),
                                              const SizedBox(width: 4),
                                              const Text(
                                                'Product Ratings',
                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                '(${reviews.length})',
                                                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                                              ),
                                            ],
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (_) => ProductReviewListScreen(product: product),
                                                ),
                                              );
                                            },
                                            style: TextButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                              minimumSize: Size.zero,
                                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                            ),
                                            child: const Row(
                                              children: [
                                                Text(
                                                  'View All',
                                                  style: TextStyle(color: Color(0xFFEE4D2D), fontSize: 14),
                                                ),
                                                Icon(Icons.chevron_right, color: Color(0xFFEE4D2D), size: 16),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(height: 24, color: Color(0xFFEEEEEE)),
                                      // Show only first 3 reviews
                                      ...reviews
                                          .take(3)
                                          .map((review) => ProductReviewCard(review: review, isDetailView: true)),
                                    ],
                                  );
                                },
                                loading: () => const Center(child: CircularProgressIndicator()),
                                error: (error, stack) => Text('Error: $error'),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    // You May Also Like Section (Using CarouselView if available)
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'You May Also Like',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 220,
                            child: Consumer(
                              builder: (context, ref, _) {
                                final productsAsync = ref.watch(productListProvider);
                                return productsAsync.when(
                                  data: (products) {
                                    // Filter out current product
                                    final relatedProducts = products.where((p) => p.id != product.id).toList();

                                    if (relatedProducts.isEmpty) return const SizedBox.shrink();

                                    // Use ListView.separated as a fallback if CarouselView is not available in your Flutter version
                                    // or preferred for strict control.
                                    // If you are on Flutter 3.24+, you can replace this with CarouselView.
                                    return ListView.separated(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: relatedProducts.length,
                                      separatorBuilder: (context, index) => const SizedBox(width: 8),
                                      itemBuilder: (context, index) {
                                        final item = relatedProducts[index];
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (_) => ProductDetailScreen(product: item)),
                                            );
                                          },
                                          child: Container(
                                            width: 150,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey[200]!),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: ClipRRect(
                                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                                                    child: Image.network(
                                                      item.images.isNotEmpty
                                                          ? item.images.first
                                                          : 'https://picsum.photos/200/200?random=${item.id}',
                                                      fit: BoxFit.cover,
                                                      width: double.infinity,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        item.name,
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: const TextStyle(fontSize: 12),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        'RM${item.price.toStringAsFixed(2)}',
                                                        style: const TextStyle(
                                                          color: Color(0xFFEE4D2D),
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  loading: () => const Center(child: CircularProgressIndicator()),
                                  error: (_, _) => const SizedBox.shrink(),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Add bottom padding for navbar
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
          // Custom AppBar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white.withAlpha((_opacity * 255).toInt()),
              child: SafeArea(
                bottom: false,
                child: SizedBox(
                  height: 56,
                  child: Row(
                    children: [
                      const SizedBox(width: 8),
                      _buildAppBarButton(
                        icon: Icons.arrow_back,
                        onPressed: () => Navigator.of(context).pop(),
                        opacity: _opacity,
                      ),
                      if (_opacity > 0.5) ...[
                        const SizedBox(width: 8),
                        Expanded(
                          child: Opacity(
                            opacity: (_opacity - 0.5) * 2, // Fade in search bar
                            child: Container(
                              height: 36,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.search, color: Colors.grey[600], size: 20),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      product.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ] else
                        const Spacer(),
                      const SizedBox(width: 8),
                      _buildAppBarButton(icon: Icons.share, onPressed: () {}, opacity: _opacity),
                      const SizedBox(width: 8),
                      Stack(
                        children: [
                          _buildAppBarButton(
                            icon: Icons.shopping_cart,
                            onPressed: () =>
                                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CartScreen())),
                            opacity: _opacity,
                          ),
                          if (cartItems.isNotEmpty)
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(color: primaryColor, shape: BoxShape.circle),
                                child: Text(
                                  cartItems.length.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      _buildAppBarButton(icon: Icons.more_vert, onPressed: () {}, opacity: _opacity),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ProductBottomBar(product: product),
    );
  }

  Widget _buildAppBarButton({required IconData icon, required VoidCallback onPressed, required double opacity}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: opacity < 0.5 ? Colors.black.withAlpha(75) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: opacity > 0.5 ? const Color(0xFFEE4D2D) : Colors.white, size: 24),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, {String? subtitle}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFFEE4D2D), size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text, style: const TextStyle(fontSize: 14)),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                ],
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
        ],
      ),
    );
  }
}
