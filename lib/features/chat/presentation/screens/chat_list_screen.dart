import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/chat_filter_provider.dart';
import '../providers/chat_provider.dart';
import '../widgets/chat_filter_tab.dart';
import '../widgets/chat_list_tile.dart';

import 'chat_message_screen.dart';

class ChatListScreen extends ConsumerWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatListAsync = ref.watch(chatListProvider);
    final filter = ref.watch(chatFilterStateProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Color(0xFFEE4D2D)),
        centerTitle: false,
        title: const Text(
          'Chats',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        forceMaterialTransparency: true,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const ChatFilterTab(),
          Expanded(
            child: chatListAsync.when(
              data: (conversations) {
                // Filter Logic
                final filteredConversations = conversations.where((chat) {
                  if (filter == ChatFilter.all) return true;
                  if (filter == ChatFilter.active) {
                    // Definition of "Active": Has unread messages or recent activity (not older than X).
                    // For simplicity based on mock data, let's say "Active" excludes official/system messages
                    // OR just shows chats with unread messages.
                    // The user prompt said "follow exactly like shopee".
                    // Shopee "Active" usually means non-hidden, non-blocked user chats.
                    // Let's filter out "Shop Message" and "Shopee Choice" if they are considered "System"?
                    // Or maybe just filter by unread count > 0?
                    // Let's try: Active = Not Official && Not Choice?
                    // Or Active = Unread > 0?
                    // Let's assume Active means "Unread" for now as it's a common pattern if "Active" isn't strictly defined in the prompt.
                    // However, "Active" usually implies "Recent interactions".
                    // Let's assume "Active" filters out "Shop Message" (id: '1') and "Shopee Choice" (id: '3') and "Zero Degree" (id: '4')
                    // which seem like "System/Marketing" chats.
                    // The "Delivery Driver" and "SD CARD STORE" seem like "Active" user interactions.

                    // Implementation: Exclude isOfficial, isChoice, isZeroDegree.
                    return !chat.isOfficial && !chat.isChoice && !chat.isZeroDegree;
                  }
                  return true;
                }).toList();

                if (filteredConversations.isEmpty) {
                  return const Center(child: Text('No chats found'));
                }
                return ListView.separated(
                  itemCount: filteredConversations.length,
                  separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFEEEEEE)),
                  itemBuilder: (context, index) {
                    return ChatListTile(
                      conversation: filteredConversations[index],
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ChatMessageScreen(conversation: filteredConversations[index]),
                          ),
                        );
                      },
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFFEE4D2D))),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    );
  }
}
