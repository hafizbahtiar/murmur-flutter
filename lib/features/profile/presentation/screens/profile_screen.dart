import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../../cart/presentation/screens/cart_screen.dart';
import '../widgets/profile_purchase_item.dart';
import '../widgets/profile_service_item.dart';
import '../widgets/profile_wallet_item.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const primaryColor = Color(0xFFEE4D2D);
    final cartItems = ref.watch(cartProvider);
    final cartItemCount = cartItems.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: CustomScrollView(
        slivers: [
          // Header with Gradient and User Info
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(top: 60, right: 16, bottom: 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFEE4D2D), Color(0xFFFF7337)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 8, right: 12, top: 6, bottom: 6),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.storefront, color: Colors.black, size: 16),
                            SizedBox(width: 4),
                            Text('Start Selling', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                            SizedBox(width: 2),
                            Icon(Icons.chevron_right, color: Colors.grey, size: 16),
                          ],
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.settings_outlined, color: Colors.white),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CartScreen()));
                        },
                        child: Badge(
                          isLabelVisible: cartItemCount > 0,
                          label: Text(
                            cartItemCount > 99 ? '99+' : cartItemCount.toString(),
                            style: const TextStyle(color: primaryColor, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: Colors.white,
                          child: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Badge(
                        isLabelVisible: true,
                        label: const Text(
                          '20',
                          style: TextStyle(color: primaryColor, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: Colors.white,
                        child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(radius: 26, backgroundImage: NetworkImage('https://picsum.photos/100')),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'hafizbahtiar_',
                                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.white24,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: const [
                                      Text('Silver', style: TextStyle(color: Colors.white, fontSize: 10)),
                                      Icon(Icons.chevron_right, color: Colors.white, size: 10),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              '5 Followers  17 Following',
                              style: TextStyle(color: Colors.white70, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // VIP & Birthday Banner
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF8E1),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: const Color(0xFFFFE082)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          color: Colors.orange,
                          child: const Text(
                            'VIP',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'Get Daily 25% Off Vouchers',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: const [
                        Icon(Icons.edit_note, color: primaryColor, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: 'Please set up your Birthday. '),
                                TextSpan(
                                  text: 'Set Now',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ],
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        Icon(Icons.close, size: 16, color: Colors.grey),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 8)),

          // My Purchases
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('My Purchases', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      Row(
                        children: const [
                          Text('View Purchase History', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          Icon(Icons.chevron_right, size: 14, color: Colors.grey),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Expanded(
                        child: ProfilePurchaseItem(icon: Icons.account_balance_wallet_outlined, label: 'To Pay'),
                      ),
                      Expanded(
                        child: ProfilePurchaseItem(icon: Icons.inventory_2_outlined, label: 'To Ship'),
                      ),
                      Expanded(
                        child: ProfilePurchaseItem(
                          icon: Icons.local_shipping_outlined,
                          label: 'To Receive',
                          badge: '1',
                        ),
                      ),
                      Expanded(
                        child: ProfilePurchaseItem(icon: Icons.star_outline, label: 'To Rate', badge: '3'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 1)),

          // Additional Services
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              child: Column(
                children: const [
                  ProfileServiceItem(
                    icon: Icons.phone_android_outlined,
                    title: 'Prepaid, Bills & Tickets',
                    trailing: 'Flash Sale 1% Off',
                    iconColor: Colors.green,
                  ),
                  Divider(height: 1, indent: 16),
                  ProfileServiceItem(
                    icon: Icons.restaurant_outlined,
                    title: 'MurFood',
                    badgeText: '99% OFF',
                    iconColor: Colors.orange,
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 8)),

          // My Wallet
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('My Wallet', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: ProfileWalletItem(
                          icon: Icons.account_balance_wallet_outlined,
                          title: 'MurPay',
                          subtitle: 'Activate',
                          isButton: true,
                        ),
                      ),
                      const Expanded(
                        child: ProfileWalletItem(
                          icon: Icons.monetization_on_outlined,
                          title: 'My Mur Coins',
                          subtitle: '2,459 Coins',
                          subtitleColor: primaryColor,
                        ),
                      ),
                      const Expanded(
                        child: ProfileWalletItem(
                          icon: Icons.receipt_long_outlined,
                          title: 'SPayLater',
                          subtitle: 'RM400.00',
                          subtitleColor: primaryColor,
                        ),
                      ),
                      const Expanded(
                        child: ProfileWalletItem(
                          icon: Icons.confirmation_number_outlined,
                          title: 'Vouchers',
                          subtitle: '50+ Vouchers',
                          subtitleColor: primaryColor,
                          badge: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}
