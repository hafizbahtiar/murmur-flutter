import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/fake_chat_conversation_repository.dart';
import '../data/repositories/fake_chat_message_repository.dart';
import '../domain/repositories/chat_conversation_repository.dart';
import '../domain/repositories/chat_message_repository.dart';
import '../domain/usecases/get_chat_conversations_use_case.dart';
import '../domain/usecases/get_chat_messages_use_case.dart';

final chatConversationRepositoryDiProvider = Provider<ChatConversationRepository>((ref) {
  return FakeChatConversationRepository();
});

final chatMessageRepositoryDiProvider = Provider<ChatMessageRepository>((ref) {
  return FakeChatMessageRepository();
});

final getChatConversationsUseCaseProvider = Provider<GetChatConversationsUseCase>((ref) {
  final repository = ref.watch(chatConversationRepositoryDiProvider);
  return GetChatConversationsUseCase(repository);
});

final getChatMessagesUseCaseProvider = Provider<GetChatMessagesUseCase>((ref) {
  final repository = ref.watch(chatMessageRepositoryDiProvider);
  return GetChatMessagesUseCase(repository);
});
