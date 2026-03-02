import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../di/chat_di.dart';
import '../../domain/models/chat_conversation.dart';
import '../../domain/models/chat_message.dart';

part 'chat_provider.g.dart';

@riverpod
class ChatList extends _$ChatList {
  @override
  Future<List<ChatConversation>> build() async {
    final getConversations = ref.watch(getChatConversationsUseCaseProvider);
    return getConversations();
  }
}

@riverpod
Future<List<ChatMessage>> chatMessages(Ref ref, String conversationId) async {
  final getMessages = ref.watch(getChatMessagesUseCaseProvider);
  return getMessages(conversationId);
}
