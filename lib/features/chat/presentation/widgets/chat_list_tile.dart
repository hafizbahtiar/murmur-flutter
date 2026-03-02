import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../domain/models/chat_conversation.dart';

class ChatListTile extends StatelessWidget {
  final ChatConversation conversation;
  final VoidCallback onTap;

  const ChatListTile({super.key, required this.conversation, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar Section
            _buildAvatar(),
            const SizedBox(width: 12),
            // Content Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Row
                  Row(
                    children: [
                      // Status Badge (Mall, Choice, etc.)
                      if (conversation.isOfficial) ...[
                        _buildStatusBadge('Shopee Mall', const Color(0xFFD0011B)),
                        const SizedBox(width: 4),
                      ],
                      if (conversation.isChoice) ...[
                        _buildStatusBadge('Choice', const Color(0xFFF53D2D)),
                        const SizedBox(width: 4),
                      ],
                      if (conversation.isZeroDegree) ...[
                        _buildStatusBadge('Zero Degree', const Color(0xFFDAA520)),
                        const SizedBox(width: 4),
                      ],

                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                conversation.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (conversation.tag != null) ...[
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  conversation.tag!,
                                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(conversation.timestamp, style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Subtitle Row
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conversation.lastMessage,
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (conversation.unreadCount > 0) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Color(0xFFEE4D2D), // Shopee Orange/Red
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                          child: Text(
                            conversation.unreadCount.toString(),
                            style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ] else if (conversation.isChoice || conversation.isZeroDegree || conversation.isOfficial) ...[
                        // Sometimes there's a small dot for unread even without count
                        // But for now let's just use the count
                        const SizedBox(width: 8),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(color: Color(0xFFEE4D2D), shape: BoxShape.circle),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    if (conversation.avatarUrl.isEmpty) {
      return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey[200]),
        child: const Icon(Icons.person, color: Colors.grey),
      );
    }

    if (conversation.avatarUrl.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: conversation.avatarUrl,
        imageBuilder: (context, imageProvider) => Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (context, url) => Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey[200]),
          child: const Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))),
        ),
        errorWidget: (context, url, error) => Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey[200]),
          child: const Icon(Icons.error, color: Colors.grey),
        ),
      );
    } else {
      return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[200],
          image: DecorationImage(image: AssetImage(conversation.avatarUrl), fit: BoxFit.cover),
        ),
      );
    }
  }

  Widget _buildStatusBadge(String text, Color color) {
    // This is a simplification. The image has specific badges.
    // "Shopee Mall" is a red rounded rect.
    // "Choice" is an icon.
    // I will use a small container for now.
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
      child: Text(
        text == 'Shopee Mall' ? 'Mall' : text,
        style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
      ),
    );
  }
}
