import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/models/chat_message.dart';

class ChatMessageBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    if (message.type == ChatMessageType.system) {
      return _buildSystemMessage();
    }

    final isMe = message.isMe;
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFFD3F8E2) : Colors.white, // Light green for user, White for others
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: isMe ? const Radius.circular(12) : const Radius.circular(0),
            bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(12),
          ),
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 1, offset: const Offset(0, 1))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message.text, style: const TextStyle(fontSize: 15, color: Colors.black87)),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DateFormat('HH:mm').format(message.timestamp),
                  style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                ),
                if (isMe) ...[
                  const SizedBox(width: 4),
                  Icon(
                    message.isRead ? Icons.done_all : Icons.done,
                    size: 14,
                    color: message.isRead ? Colors.blue : Colors.grey[500],
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSystemMessage() {
    // Check if it's a warning message
    final isWarning = message.metadata?['isWarning'] == true;

    if (isWarning) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF8E1), // Light yellow
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFFFE082)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.info_outline, color: Colors.orange, size: 16),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'IMPORTANT: Beware of scams!',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.orange),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              message.text.replaceFirst('IMPORTANT: Beware of scams! ', ''),
              style: const TextStyle(fontSize: 12, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text('Learn More', style: TextStyle(fontSize: 12, color: Colors.blue[700])),
                const SizedBox(width: 12),
                Text('Report User', style: TextStyle(fontSize: 12, color: Colors.red[700])),
              ],
            ),
          ],
        ),
      );
    }

    // Default system message (e.g. "Chat with Seller")
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
        child: Text(
          message.text,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
