import '../models/chat_message.dart';

abstract class ChatMessageRepository {
  Future<List<ChatMessage>> getMessages(String conversationId);
}
