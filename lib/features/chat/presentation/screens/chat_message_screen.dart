import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/chat_conversation.dart';
import '../providers/chat_provider.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/chat_message_bubble.dart';

class ChatMessageScreen extends ConsumerWidget {
  final ChatConversation conversation;

  const ChatMessageScreen({super.key, required this.conversation});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messagesAsync = ref.watch(chatMessagesProvider(conversation.id));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leadingWidth: 40,
        leading: const BackButton(color: Colors.black),
        title: Row(
          children: [
            ClipOval(
              child: CachedNetworkImage(
                imageUrl: conversation.avatarUrl,
                width: 32,
                height: 32,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(color: Colors.grey[200]),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[200],
                  child: const Icon(Icons.person, color: Colors.grey, size: 16),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    conversation.title,
                    style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Row(
                    children: [
                      Icon(Icons.circle, size: 8, color: Colors.green),
                      SizedBox(width: 4),
                      Text('Online', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.storefront, color: Colors.black),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz, color: Colors.black),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          Expanded(
            child: messagesAsync.when(
              data: (messages) {
                return ListView.builder(
                  reverse: true, // Start from bottom
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    // Reverse index because ListView is reversed
                    final message = messages[messages.length - 1 - index];
                    return ChatMessageBubble(message: message);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ),
          ChatInputBar(
            onSend: (text) {
              // TODO: Implement send message
              // ref.read(chatMessagesProvider(conversation.id).notifier).sendMessage(text);
            },
          ),
        ],
      ),
    );
  }
}
