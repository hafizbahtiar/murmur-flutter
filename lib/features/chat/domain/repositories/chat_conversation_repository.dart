import '../models/chat_conversation.dart';

abstract class ChatConversationRepository {
  Future<List<ChatConversation>> getConversations();
}
