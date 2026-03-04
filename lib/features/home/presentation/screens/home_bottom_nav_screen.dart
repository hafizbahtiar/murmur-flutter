import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../product/presentation/screens/product_list_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../../../notification/presentation/screens/notification_list_screen.dart';
import '../../../notification/presentation/providers/notification_provider.dart';
import '../widgets/floating_bottom_nav_bar.dart';

class HomeBottomNavScreen extends ConsumerStatefulWidget {
  const HomeBottomNavScreen({super.key});

  @override
  ConsumerState<HomeBottomNavScreen> createState() => _HomeBottomNavScreenState();
}

class _HomeBottomNavScreenState extends ConsumerState<HomeBottomNavScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final totalUnread = ref.watch(totalUnreadCountProvider).value ?? 0;

    final screens = [
      const ProductListScreen(),
      const Scaffold(body: Center(child: Text('Mall Screen'))),
      const NotificationListScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: _currentIndex, children: screens),
      bottomNavigationBar: FloatingBottomNavBar(
        selectedIndex: _currentIndex,
        onItemTapped: (index) => setState(() => _currentIndex = index),
        unreadCount: totalUnread,
      ),
    );
  }
}
