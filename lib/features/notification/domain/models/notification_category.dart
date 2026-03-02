import 'package:flutter/material.dart';
import 'notification_item.dart';

class NotificationCategory {
  final String id;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String title;
  final String subtitle;
  final int unreadCount;
  final NotificationType? type; // Link to NotificationType for filtering

  const NotificationCategory({
    required this.id,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.title,
    required this.subtitle,
    required this.unreadCount,
    this.type,
  });
}
