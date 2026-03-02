import '../models/chat_message.dart';
import '../repositories/chat_message_repository.dart';

class GetChatMessagesUseCase {
  final ChatMessageRepository _repository;

  const GetChatMessagesUseCase(this._repository);

  Future<List<ChatMessage>> call(String conversationId) {
    return _repository.getMessages(conversationId);
  }
}
