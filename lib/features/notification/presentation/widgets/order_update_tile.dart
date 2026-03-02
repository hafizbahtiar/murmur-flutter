import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/models/notification_item.dart';

class OrderUpdateTile extends StatelessWidget {
  final NotificationItem update;

  const OrderUpdateTile({super.key, required this.update});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: update.isRead ? Colors.white : const Color(0xFFFFF9F8), // Highlight unread
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          if (update.imageUrl != null)
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(4),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CachedNetworkImage(
                  imageUrl: update.imageUrl!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(color: Colors.grey[200]),
                  errorWidget: (context, url, error) =>
                      Container(color: Colors.grey[200], child: const Icon(Icons.error)),
                ),
              ),
            ),
          if (update.imageUrl != null) const SizedBox(width: 12),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(update.title, style: const TextStyle(fontSize: 14, color: Colors.black87)),
                const SizedBox(height: 4),
                Text(
                  update.description,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(_formatTimestamp(update.timestamp), style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
              ],
            ),
          ),

          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    if (now.difference(timestamp).inDays < 1 && now.day == timestamp.day) {
      return DateFormat('HH:mm').format(timestamp);
    } else {
      return DateFormat('dd-MM-yyyy HH:mm').format(timestamp);
    }
  }
}
