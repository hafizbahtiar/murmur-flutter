import 'package:flutter/material.dart';
import '../domain/models/notification_category.dart';
import '../domain/models/notification_item.dart';
import '../domain/repositories/notification_repository.dart';

class FakeNotificationRepository implements NotificationRepository {
  // Master list of all notifications
  static final List<NotificationItem> _allNotifications = [
    // Promotions
    ...List.generate(
      5,
      (index) => NotificationItem(
        id: 'promo_$index',
        type: NotificationType.promotion,
        title: index == 0 ? '50% OFF Asam Laksa NOW 🍜' : 'Shopee Mall Monday 🎉',
        description: index == 0
            ? 'Enjoy a tangy bowl of Asam Laksa from D\'Laksa at RM6 (was RM12)! Tap to get this deal on ShopeeFood 👉'
            : 'Make Monday your favourite day of the week! Shop SOME BY MI, Crocs, Masaki, Baseus & more. Enjoy SPayLater 0% with 6-month instalments + 4-hour delivery! 🚚 Tap to explore & claim now! 👉',
        timestamp: DateTime.now().subtract(Duration(hours: index)),
        isRead: false,
        imageUrl: index == 0
            ? 'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?ixlib=rb-1.2.1&auto=format&fit=crop&w=200&q=80' // Food icon
            : 'https://images.unsplash.com/photo-1483985988355-763728e1935b?ixlib=rb-1.2.1&auto=format&fit=crop&w=200&q=80', // Shopping icon
        bannerUrl: index == 0
            ? 'https://images.unsplash.com/photo-1563379926898-05f4575a45d8?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80' // Pasta/Noodle
            : 'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80', // Shopping
      ),
    ),
    // Social Updates
    ...List.generate(
      2,
      (index) => NotificationItem(
        id: 'social_$index',
        type: NotificationType.social,
        title: 'Social Update ${index + 1}',
        description: 'Join ShopeeFood MY live stream!',
        timestamp: DateTime.now().subtract(Duration(hours: index + 5)),
        isRead: false,
      ),
    ),
    // Finance Updates
    ...List.generate(
      3,
      (index) => NotificationItem(
        id: 'finance_$index',
        type: NotificationType.finance,
        title: 'Finance Update ${index + 1}',
        description: 'Introducing SFinancing-i!',
        timestamp: DateTime.now().subtract(Duration(days: 1, hours: index)),
        isRead: false,
      ),
    ),
    // Shopee Updates
    ...List.generate(
      2,
      (index) => NotificationItem(
        id: 'shopee_$index',
        type: NotificationType.shopeeUpdate,
        title: 'Shopee Update ${index + 1}',
        description: 'Shopee Collection Point - Parcel Locker',
        timestamp: DateTime.now().subtract(Duration(days: 2, hours: index)),
        isRead: false,
      ),
    ),
    // Shopee Prizes
    ...List.generate(
      4,
      (index) => NotificationItem(
        id: 'prize_$index',
        type: NotificationType.shopeePrize,
        title: 'Prize Update ${index + 1}',
        description: 'Don\'t miss today shake!',
        timestamp: DateTime.now().subtract(Duration(hours: index)),
        isRead: false,
      ),
    ),
    // Order Updates
    NotificationItem(
      id: 'order_1',
      type: NotificationType.orderUpdate,
      imageUrl: 'https://images.unsplash.com/photo-1546868871-7041f2a55e12?ixlib=rb-1.2.1&auto=format&fit=crop&w=200&q=80',
      title: 'Reminder: Received Order?',
      description: 'If there is an issue with your order, please raise a Return/Refund request',
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      isRead: false,
    ),
    NotificationItem(
      id: 'order_2',
      type: NotificationType.orderUpdate,
      imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-1.2.1&auto=format&fit=crop&w=200&q=80',
      title: 'Did you enjoy your shopping experience?',
      description: 'Rate your delivered items by 31-03-2026 to earn up to 5 Shopee Coin(s)',
      timestamp: DateTime.now().subtract(const Duration(hours: 4)),
      isRead: true,
    ),
    NotificationItem(
      id: 'order_3',
      type: NotificationType.orderUpdate,
      imageUrl: 'https://images.unsplash.com/photo-1583394838336-acd977736f90?ixlib=rb-1.2.1&auto=format&fit=crop&w=200&q=80',
      title: 'Did you enjoy your shopping experience?',
      description: 'Rate your delivered items by 31-03-2026 to earn up to 5 Shopee Coin(s)',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
    ),
    NotificationItem(
      id: 'order_4',
      type: NotificationType.orderUpdate,
      imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?ixlib=rb-1.2.1&auto=format&fit=crop&w=200&q=80',
      title: 'Parcel Delivered',
      description: 'Your parcel has been delivered to your letterbox/gate. Please check and confirm receipt.',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      isRead: true,
    ),
  ];

  @override
  Future<List<NotificationCategory>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    // Helper to count unread items for a specific type
    int countUnread(NotificationType type) {
      return _allNotifications.where((n) => n.type == type && !n.isRead).length;
    }

    return [
      NotificationCategory(
        id: '1',
        icon: Icons.local_offer,
        iconColor: const Color(0xFFEE4D2D), // Shopee Orange
        backgroundColor: const Color(0xFFFFF1F0), // Light Orange
        title: 'Promotions',
        subtitle: 'Enjoy a tangy bowl of Asam Laksa fr...',
        unreadCount: countUnread(NotificationType.promotion),
        type: NotificationType.promotion,
      ),
      NotificationCategory(
        id: '2',
        icon: Icons.live_tv,
        iconColor: const Color(0xFF00BFA5), // Teal
        backgroundColor: const Color(0xFFE0F2F1), // Light Teal
        title: 'Social Updates',
        subtitle: 'Join ShopeeFood MY live stream: Jo...',
        unreadCount: countUnread(NotificationType.social),
        type: NotificationType.social,
      ),
      NotificationCategory(
        id: '3',
        icon: Icons.account_balance_wallet,
        iconColor: const Color(0xFFFFB300), // Amber
        backgroundColor: const Color(0xFFFFF8E1), // Light Amber
        title: 'Finance Updates',
        subtitle: 'Introducing SFinancing-i, a Sharia...',
        unreadCount: countUnread(NotificationType.finance),
        type: NotificationType.finance,
      ),
      NotificationCategory(
        id: '4',
        icon: Icons.shopping_bag,
        iconColor: const Color(0xFFEE4D2D), // Shopee Orange
        backgroundColor: const Color(0xFFFFF1F0),
        title: 'Shopee Updates',
        subtitle: 'Shopee Collection Point - Parcel Lock...',
        unreadCount: countUnread(NotificationType.shopeeUpdate),
        type: NotificationType.shopeeUpdate,
      ),
      NotificationCategory(
        id: '5',
        icon: Icons.card_giftcard,
        iconColor: const Color(0xFF1E88E5), // Blue
        backgroundColor: const Color(0xFFE3F2FD), // Light Blue
        title: 'Shopee Prizes',
        subtitle: 'Don\'t miss today shake! Drop by ...',
        unreadCount: countUnread(NotificationType.shopeePrize),
        type: NotificationType.shopeePrize,
      ),
    ];
  }

  @override
  Future<List<NotificationItem>> getOrderUpdates() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _allNotifications
        .where((n) => n.type == NotificationType.orderUpdate)
        .toList();
  }

  @override
  Future<List<NotificationItem>> getNotificationsByType(NotificationType type) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _allNotifications.where((n) => n.type == type).toList();
  }

  @override
  Future<int> getTotalUnreadCount() async {
    return _allNotifications.where((n) => !n.isRead).length;
  }
}
