import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/models/notification_item.dart';

class NotificationListTile extends StatelessWidget {
  final NotificationItem item;

  const NotificationListTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFF5F5F5))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Icon + Title
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item.imageUrl != null)
                Container(
                  width: 36,
                  height: 36,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: item.imageUrl!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(color: Colors.grey[200]),
                      errorWidget: (context, url, error) =>
                          Container(color: Colors.grey[200], child: const Icon(Icons.error, size: 16)),
                    ),
                  ),
                )
              else
                Container(
                  width: 36,
                  height: 36,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: const BoxDecoration(color: Color(0xFFEE4D2D), shape: BoxShape.circle),
                  child: const Icon(Icons.notifications, color: Colors.white, size: 20),
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                    const SizedBox(height: 6),
                    Text(item.description, style: TextStyle(fontSize: 14, color: Colors.grey.shade700, height: 1.3)),
                    const SizedBox(height: 12),
                    if (item.bannerUrl != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.network(
                          item.bannerUrl!,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 150,
                              width: double.infinity,
                              color: Colors.grey.shade200,
                              child: const Center(child: Icon(Icons.broken_image, color: Colors.grey)),
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 8),
                    Text(_formatTimestamp(item.timestamp), style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final diff = now.difference(timestamp);
    if (diff.inDays < 1) {
      return DateFormat('HH:mm').format(timestamp);
    } else if (diff.inDays < 7) {
      return DateFormat('E HH:mm').format(timestamp);
    } else {
      return DateFormat('dd MMM').format(timestamp);
    }
  }
}
