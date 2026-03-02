enum ChatMessageType { text, image, system, product, orderUpdate }

class ChatMessage {
  final String id;
  final String text;
  final ChatMessageType type;
  final bool isMe;
  final DateTime timestamp;
  final bool isRead;
  final String? imageUrl; // For image messages
  final Map<String, dynamic>? metadata; // For product or other extra data

  const ChatMessage({
    required this.id,
    required this.text,
    required this.type,
    required this.isMe,
    required this.timestamp,
    this.isRead = false,
    this.imageUrl,
    this.metadata,
  });
}
