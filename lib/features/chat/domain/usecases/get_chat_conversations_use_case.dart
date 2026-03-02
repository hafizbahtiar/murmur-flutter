import '../models/chat_conversation.dart';
import '../repositories/chat_conversation_repository.dart';

class GetChatConversationsUseCase {
  final ChatConversationRepository _repository;

  GetChatConversationsUseCase(this._repository);

  Future<List<ChatConversation>> call() {
    return _repository.getConversations();
  }
}
