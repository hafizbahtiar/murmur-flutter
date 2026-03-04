import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../../cart/presentation/screens/cart_screen.dart';
import '../../../chat/presentation/providers/chat_provider.dart';
import '../../../chat/presentation/screens/chat_list_screen.dart';
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
    final chatListAsync = ref.watch(chatListProvider);
    final unreadChatCount = chatListAsync.value?.fold<int>(0, (sum, chat) => sum + chat.unreadCount) ?? 0;
    final cartItemCount = cartItems.length;
    const primaryColor = Color(0xFFEE4D2D);
    const murmurGreen = Color(0xFF1E8373); // Dark Green Background

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: CustomScrollView(
        slivers: [
          // App Bar with Search
          SliverAppBar(
            pinned: true,
            floating: true,
            backgroundColor: murmurGreen,
            flexibleSpace: Container(color: murmurGreen),
            title: Container(
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Color(0xFFEE4D2D), size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'CCTV Hard Disk',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.camera_alt_outlined, color: Colors.grey, size: 20),
                ],
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CartScreen()));
                },
                icon: Badge(
                  isLabelVisible: cartItems.isNotEmpty,
                  label: Text(cartItemCount.toString()),
                  backgroundColor: Colors.white,
                  textColor: primaryColor,
                  child: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ChatListScreen()));
                  },
                  icon: Badge(
                    isLabelVisible: unreadChatCount > 0,
                    label: Text(unreadChatCount > 99 ? '99+' : unreadChatCount.toString()),
                    backgroundColor: Colors.white,
                    textColor: primaryColor,
                    child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),

          // Wallet / Finance Row
          SliverToBoxAdapter(
            child: Container(
              color: murmurGreen,
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 4, offset: const Offset(0, 2))],
                ),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      // QR Scan
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Icon(Icons.qr_code_scanner, color: Colors.black, size: 20),
                            ),
                          ],
                        ),
                      ),
                      const VerticalDivider(width: 1, color: Colors.grey, indent: 8, endIndent: 8),
                      // MurPay
                      Expanded(
                        child: _buildWalletItem(
                          icon: Icons.account_balance_wallet,
                          label: 'MurPay',
                          subLabel: 'Up to 6% p.a.*',
                          subLabel2: 'Daily Returns',
                          iconColor: primaryColor,
                        ),
                      ),
                      const VerticalDivider(width: 1, color: Colors.grey, indent: 8, endIndent: 8),
                      // Coins
                      Expanded(
                        child: _buildWalletItem(
                          icon: Icons.monetization_on,
                          label: '2,459',
                          subLabel: 'Redeem',
                          subLabel2: 'exclusive vouc...',
                          iconColor: Colors.amber,
                        ),
                      ),
                      const VerticalDivider(width: 1, color: Colors.grey, indent: 8, endIndent: 8),
                      // Vouchers
                      Expanded(
                        child: _buildWalletItem(
                          icon: Icons.confirmation_number,
                          label: 'MurVoucher',
                          subLabel: 'Daily 25% Off',
                          subLabel2: 'Voucher',
                          iconColor: primaryColor,
                          isVoucher: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Menu Icons Grid
          SliverToBoxAdapter(
            child: Container(
              color: murmurGreen,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMenuItem(Icons.thumb_up, 'Lagi Murah', 'Daily 50% Off', const Color(0xFF004D8C)),
                  _buildMenuItem(Icons.checkroom, '#GetReady', 'WithMurmur', const Color(0xFFE94E3D)),
                  _buildMenuItem(Icons.restaurant, 'MurFood', '99% OFF', const Color(0xFFEE4D2D)),
                  _buildMenuItem(Icons.local_shipping, 'Fulfilled by', 'Mur', const Color(0xFFB71C1C)),
                  _buildMenuItem(Icons.card_giftcard, 'Mur', 'Prizes', const Color(0xFFEE4D2D)),
                ],
              ),
            ),
          ),

          // Banners Row (Flexible)
          SliverToBoxAdapter(
            child: Container(
              color: murmurGreen,
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
              child: SizedBox(
                height: 120,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 4,
                      child: _buildBannerItem(
                        const Color(0xFF0059BE),
                        '3.3 TAWARAN',
                        'HEBAT RAYA',
                        'RM45',
                        'RM54',
                        Colors.yellow,
                        imageUrl: 'https://picsum.photos/100/100?random=10', // Placeholder
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      flex: 7,
                      child: _buildBannerItem(
                        const Color(0xFFE31E26),
                        'MORE SURPRISES AT',
                        '8PM, 2 MAR',
                        'RM800',
                        'KNOCKOUT VOUCHER',
                        Colors.black,
                        isMain: true,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      flex: 4,
                      child: _buildBannerItem(
                        const Color(0xFF86CDA6),
                        '50% OFF RAYA',
                        'FASHION TRENDS',
                        'RM120',
                        'RM239',
                        Colors.green[900]!,
                        imageUrl: 'https://picsum.photos/100/100?random=11', // Placeholder
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Discover Header
          SliverToBoxAdapter(
            child: Container(
              color: murmurGreen,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: _buildDiscoverSection(
                      'DISCOVER LIVE',
                      'LIVE',
                      'Tapo CCTV Deals',
                      '5210',
                      'https://picsum.photos/300/300?random=1',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildDiscoverSection(
                      'DISCOVER VIDEO',
                      'VIDEO',
                      '',
                      '118.3k',
                      'https://picsum.photos/300/300?random=2',
                      isVideo: true,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Products Grid
          products.when(
            loading: () => const SliverToBoxAdapter(child: AppLoadingState(message: 'Loading products...')),
            error: (error, stack) => SliverToBoxAdapter(
              child: AppEmptyState(
                icon: Icons.error_outline,
                title: 'Something went wrong',
                message: error.toString(),
                actionLabel: 'Retry',
                onAction: () => ref.invalidate(productListProvider),
              ),
            ),
            data: (items) {
              if (items.isEmpty) {
                return SliverToBoxAdapter(
                  child: AppEmptyState(
                    icon: Icons.inventory_2_outlined,
                    title: 'No products',
                    message: 'There are no products available right now.',
                    actionLabel: 'Refresh',
                    onAction: () => ref.invalidate(productListProvider),
                  ),
                );
              }
              return SliverPadding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 100),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return ProductCard(product: items[index]);
                  }, childCount: items.length),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWalletItem({
    required IconData icon,
    required String label,
    String? subLabel,
    String? subLabel2,
    Color? iconColor,
    bool isVoucher = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              if (isVoucher)
                Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(2)),
                  child: const Text(
                    'S',
                    style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                  ),
                )
              else
                Icon(icon, size: 16, color: iconColor ?? Colors.black),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          if (subLabel != null)
            Text(
              subLabel,
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          if (subLabel2 != null)
            Text(
              subLabel2,
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label, String subLabel, Color color) {
    return SizedBox(
      width: 65,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey[200]!),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.white),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            subLabel,
            style: const TextStyle(fontSize: 10, color: Colors.white70),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildBannerItem(
    Color bgColor,
    String topText,
    String midText,
    String price,
    String priceLabel,
    Color textColor, {
    bool isMain = false,
    String? imageUrl,
  }) {
    return Container(
      // width: isMain ? 160 : 130, // Removed fixed width
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(8)),
      child: Stack(
        children: [
          // Content
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Header Text
              Column(
                children: [
                  Text(
                    topText,
                    style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    midText,
                    style: TextStyle(
                      color: isMain ? Colors.yellow : Colors.white,
                      fontSize: isMain ? 14 : 9,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),

              // Image Placeholder for side banners
              if (!isMain && imageUrl != null)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => const Center(
                        child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.grey),
                    ),
                  ),
                ),
              if (isMain) const Spacer(),

              // Price/Button Section
              if (isMain)
                Column(
                  children: [
                    Text(
                      price,
                      style: const TextStyle(color: Colors.yellow, fontSize: 20, fontWeight: FontWeight.w900),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      priceLabel,
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
                      child: const Text('CLAIM NOW >', style: TextStyle(color: Colors.white, fontSize: 8)),
                    ),
                  ],
                )
              else
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        price,
                        style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        priceLabel,
                        style: const TextStyle(color: Colors.grey, fontSize: 9, decoration: TextDecoration.lineThrough),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDiscoverSection(
    String header,
    String tag,
    String title,
    String count,
    String imageUrl, {
    bool isVideo = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                header,
                style: const TextStyle(color: Color(0xFFEE4D2D), fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: imageUrl,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    height: 140,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 140,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: const Icon(Icons.error, color: Colors.grey),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: isVideo ? Colors.black54 : const Color(0xFFEE4D2D),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        if (isVideo) const Icon(Icons.play_arrow, size: 10, color: Colors.white),
                        if (!isVideo) const Icon(Icons.circle, size: 6, color: Colors.white),
                        const SizedBox(width: 4),
                        Text(
                          tag,
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black87],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (title.isNotEmpty)
                          Text(
                            title,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        Text(count, style: const TextStyle(color: Colors.white, fontSize: 10)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
