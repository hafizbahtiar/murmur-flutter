class ChatConversation {
  final String id;
  final String avatarUrl; // Can be a local asset or network URL
  final String title;
  final String? tag; // e.g., "~ SD CARD STORE"
  final String lastMessage;
  final String timestamp;
  final int unreadCount;
  final bool isOfficial; // Shopee Mall
  final bool isChoice; // Choice
  final bool isZeroDegree; // Zero Degree
  final bool isVideo; // Play icon overlay

  const ChatConversation({
    required this.id,
    required this.avatarUrl,
    required this.title,
    this.tag,
    required this.lastMessage,
    required this.timestamp,
    this.unreadCount = 0,
    this.isOfficial = false,
    this.isChoice = false,
    this.isZeroDegree = false,
    this.isVideo = false,
  });
}
