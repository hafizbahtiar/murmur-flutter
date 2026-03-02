import 'package:flutter/material.dart';
import '../domain/models/notification_category.dart';
import '../domain/models/order_update.dart';
import '../domain/repositories/notification_repository.dart';

class FakeNotificationRepository implements NotificationRepository {
  @override
  Future<List<NotificationCategory>> fetchCategories() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      const NotificationCategory(
        id: '1',
        icon: Icons.local_offer,
        iconColor: Color(0xFFEE4D2D), // Shopee Orange
        backgroundColor: Color(0xFFFFF1F0), // Light Orange
        title: 'Promotions',
        subtitle: 'Enjoy a tangy bowl of Asam Laksa fr...',
        unreadCount: 77,
      ),
      const NotificationCategory(
        id: '2',
        icon: Icons.live_tv,
        iconColor: Color(0xFF00BFA5), // Teal
        backgroundColor: Color(0xFFE0F2F1), // Light Teal
        title: 'Social Updates',
        subtitle: 'Join ShopeeFood MY live stream: Jo...',
        unreadCount: 2,
      ),
      const NotificationCategory(
        id: '3',
        icon: Icons.account_balance_wallet,
        iconColor: Color(0xFFFFB300), // Amber
        backgroundColor: Color(0xFFFFF8E1), // Light Amber
        title: 'Finance Updates',
        subtitle: 'Introducing SFinancing-i, a Sharia...',
        unreadCount: 10,
      ),
      const NotificationCategory(
        id: '4',
        icon: Icons.shopping_bag,
        iconColor: Color(0xFFEE4D2D), // Shopee Orange
        backgroundColor: Color(0xFFFFF1F0),
        title: 'Shopee Updates',
        subtitle: 'Shopee Collection Point - Parcel Lock...',
        unreadCount: 6,
      ),
      const NotificationCategory(
        id: '5',
        icon: Icons.card_giftcard,
        iconColor: Color(0xFF1E88E5), // Blue
        backgroundColor: Color(0xFFE3F2FD), // Light Blue
        title: 'Shopee Prizes',
        subtitle: 'Don\'t miss today shake! Drop by ...',
        unreadCount: 19,
      ),
    ];
  }

  @override
  Future<List<OrderUpdate>> fetchOrderUpdates() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      OrderUpdate(
        id: '1',
        imageUrl:
            'https://images.unsplash.com/photo-1546868871-7041f2a55e12?ixlib=rb-1.2.1&auto=format&fit=crop&w=200&q=80', // Watch
        title: 'Reminder: Received Order?',
        description: 'If there is an issue with your order, please raise a Return/Refund request',
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        isRead: false,
      ),
      OrderUpdate(
        id: '2',
        imageUrl:
            'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-1.2.1&auto=format&fit=crop&w=200&q=80', // Headphones
        title: 'Did you enjoy your shopping experience?',
        description: 'Rate your delivered items by 31-03-2026 to earn up to 5 Shopee Coin(s)',
        timestamp: DateTime.now().subtract(const Duration(hours: 4)),
        isRead: true,
      ),
      OrderUpdate(
        id: '3',
        imageUrl:
            'https://images.unsplash.com/photo-1583394838336-acd977736f90?ixlib=rb-1.2.1&auto=format&fit=crop&w=200&q=80', // Mask/Product
        title: 'Did you enjoy your shopping experience?',
        description: 'Rate your delivered items by 31-03-2026 to earn up to 5 Shopee Coin(s)',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        isRead: true,
      ),
      OrderUpdate(
        id: '4',
        imageUrl:
            'https://images.unsplash.com/photo-1523275335684-37898b6baf30?ixlib=rb-1.2.1&auto=format&fit=crop&w=200&q=80', // Watch
        title: 'Parcel Delivered',
        description: 'Your parcel has been delivered to your letterbox/gate. Please check and confirm receipt.',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        isRead: true,
      ),
    ];
  }
}
