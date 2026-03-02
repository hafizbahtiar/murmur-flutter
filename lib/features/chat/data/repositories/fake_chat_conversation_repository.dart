import '../../domain/models/chat_conversation.dart';
import '../../domain/repositories/chat_conversation_repository.dart';

class FakeChatConversationRepository implements ChatConversationRepository {
  @override
  Future<List<ChatConversation>> getConversations() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      const ChatConversation(
        id: '1',
        avatarUrl: 'https://api.dicebear.com/7.x/initials/png?seed=SM', // Placeholder
        title: 'Shop Message',
        lastMessage: 'k05xdszg2q: Dear customer, this is c...',
        timestamp: '17:24',
        unreadCount: 19,
        isOfficial: false,
      ),
      const ChatConversation(
        id: '2',
        avatarUrl: 'https://api.dicebear.com/7.x/initials/png?seed=SD', // Placeholder
        title: 'k05xdszg2q',
        tag: '~ SD CARD STORE',
        lastMessage: 'Dear customer, this is customer servi...',
        timestamp: '17:24',
        unreadCount: 3,
      ),
      const ChatConversation(
        id: '3',
        avatarUrl: 'https://api.dicebear.com/7.x/initials/png?seed=SC', // Placeholder
        title: 'shopee_choice_global.my',
        lastMessage: '', // Empty if hidden or implied
        timestamp: 'Yesterday',
        unreadCount: 1, // Dot
        isChoice: true,
      ),
      const ChatConversation(
        id: '4',
        avatarUrl: 'https://api.dicebear.com/7.x/initials/png?seed=MM', // Placeholder
        title: 'mask.medishield',
        lastMessage: '',
        timestamp: 'Yesterday',
        unreadCount: 1,
        isZeroDegree: true,
      ),
      const ChatConversation(
        id: '5',
        avatarUrl: 'https://api.dicebear.com/7.x/avataaars/png?seed=D1', // Placeholder
        title: 'Delivery Driver',
        tag: '~ No. 5528',
        lastMessage: 'Parcel delivered! Enjoy your item',
        timestamp: 'Friday',
        unreadCount: 1,
      ),
      const ChatConversation(
        id: '6',
        avatarUrl: 'https://api.dicebear.com/7.x/avataaars/png?seed=D2', // Placeholder
        title: 'Delivery Driver',
        tag: '~ No. 4916',
        lastMessage: 'Parcel delivered! Enjoy your item',
        timestamp: 'Thursday',
        unreadCount: 0,
      ),
      const ChatConversation(
        id: '7',
        avatarUrl: 'https://api.dicebear.com/7.x/initials/png?seed=OK', // Placeholder
        title: 'ookas',
        lastMessage: '260224JEDQ735Q Great news! 🎉 Yo...',
        timestamp: 'Wednesday',
        unreadCount: 1,
        isOfficial: true,
      ),
      const ChatConversation(
        id: '8',
        avatarUrl: 'https://api.dicebear.com/7.x/avataaars/png?seed=D3', // Placeholder
        title: 'Delivery Driver',
        tag: '~ No. 7025',
        lastMessage: 'Parcel delivered! Enjoy your item',
        timestamp: '11/02',
        unreadCount: 1,
      ),
    ];
  }
}
