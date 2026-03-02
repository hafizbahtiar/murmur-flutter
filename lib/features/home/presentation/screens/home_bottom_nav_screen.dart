import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../product/presentation/screens/product_list_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../../../live/presentation/screens/live_video_screen.dart';
import '../../../notification/presentation/screens/notification_screen.dart';
import '../../../notification/presentation/providers/notification_provider.dart';

class HomeBottomNavScreen extends ConsumerStatefulWidget {
  const HomeBottomNavScreen({super.key});

  @override
  ConsumerState<HomeBottomNavScreen> createState() => _HomeBottomNavScreenState();
}

class _HomeBottomNavScreenState extends ConsumerState<HomeBottomNavScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    const activeColor = Color(0xFFEE4D2D);
    const inactiveColor = Colors.grey;

    final totalUnread = ref.watch(totalUnreadCountProvider).value ?? 0;

    final screens = [
      const ProductListScreen(),
      const Scaffold(body: Center(child: Text('Mall Screen'))),
      LiveVideoScreen(isActive: _currentIndex == 2),
      const NotificationScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: activeColor,
        unselectedItemColor: inactiveColor,
        selectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag),
            label: 'Mall',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.live_tv_outlined),
            activeIcon: Icon(Icons.live_tv),
            label: 'Live & Video',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.notifications_outlined),
                if (totalUnread > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(6)),
                      constraints: const BoxConstraints(minWidth: 12, minHeight: 12),
                      child: Text(
                        totalUnread > 99 ? '99+' : totalUnread.toString(),
                        style: const TextStyle(color: Colors.white, fontSize: 8),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            activeIcon: const Icon(Icons.notifications),
            label: 'Notifications',
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Me'),
        ],
      ),
    );
  }
}
