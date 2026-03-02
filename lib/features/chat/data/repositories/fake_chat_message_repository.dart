import '../../domain/models/chat_message.dart';
import '../../domain/repositories/chat_message_repository.dart';

class FakeChatMessageRepository implements ChatMessageRepository {
  @override
  Future<List<ChatMessage>> getMessages(String conversationId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    // Mock data matching the screenshot roughly
    final now = DateTime.now();
    return [
      ChatMessage(
        id: '1',
        text: 'Please select a question from the above FAQ or click the "Chat with Seller" button.',
        type: ChatMessageType.system,
        isMe: false,
        timestamp: now.subtract(const Duration(minutes: 10)),
      ),
      ChatMessage(
        id: '2',
        text: 'Chat with Seller',
        type: ChatMessageType.system,
        isMe: true, // Displayed as action
        timestamp: now.subtract(const Duration(minutes: 9)),
      ),
      ChatMessage(
        id: '3',
        text: 'Chat with Seller',
        type: ChatMessageType.text,
        isMe: true,
        timestamp: now.subtract(const Duration(minutes: 9)),
        isRead: true,
      ),
      ChatMessage(
        id: '4',
        text: 'Chat has been transferred to seller, who will assist you',
        type: ChatMessageType.system,
        isMe: false,
        timestamp: now.subtract(const Duration(minutes: 9)),
      ),
      ChatMessage(
        id: '5',
        text: 'Where you location? I mean shop',
        type: ChatMessageType.text,
        isMe: true,
        timestamp: now.subtract(const Duration(minutes: 8)),
        isRead: true,
      ),
      ChatMessage(
        id: '6',
        text: 'Hi bos, this model available for in store pickup',
        type: ChatMessageType.text,
        isMe: false,
        timestamp: now.subtract(const Duration(minutes: 7)),
      ),
      ChatMessage(
        id: '7',
        text: 'IMPORTANT: Beware of scams! Avoid sharing personal information...',
        type: ChatMessageType.system, // Using system type for warning banner for now
        isMe: false,
        timestamp: now.subtract(const Duration(minutes: 7)),
        metadata: {'isWarning': true},
      ),
      ChatMessage(
        id: '8',
        text: 'Our store at kelana jaya]',
        type: ChatMessageType.text,
        isMe: false,
        timestamp: now.subtract(const Duration(minutes: 6)),
      ),
      ChatMessage(
        id: '9',
        text: 'U may purchase 1st, choose variation in store pickup',
        type: ChatMessageType.text,
        isMe: false,
        timestamp: now.subtract(const Duration(minutes: 5)),
      ),
      ChatMessage(
        id: '10',
        text: 'once ready we will notify her',
        type: ChatMessageType.text,
        isMe: false,
        timestamp: now.subtract(const Duration(minutes: 5)),
      ),
      ChatMessage(
        id: '11',
        text: '*here',
        type: ChatMessageType.text,
        isMe: false,
        timestamp: now.subtract(const Duration(minutes: 5)),
      ),
    ];
  }
}
