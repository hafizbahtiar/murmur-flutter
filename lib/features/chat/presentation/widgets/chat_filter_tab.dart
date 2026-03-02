import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/chat_filter_provider.dart';

class ChatFilterTab extends ConsumerWidget {
  const ChatFilterTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFilter = ref.watch(chatFilterStateProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => ref.read(chatFilterStateProvider.notifier).setFilter(ChatFilter.all),
            child: _buildFilterChip('All', currentFilter == ChatFilter.all, hasUnread: true),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => ref.read(chatFilterStateProvider.notifier).setFilter(ChatFilter.active),
            child: _buildFilterChip('Active', currentFilter == ChatFilter.active, hasUnread: true),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, {bool hasUnread = false}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFFFF0EC) : Colors.grey[100],
            borderRadius: BorderRadius.circular(20),
            border: isSelected
                ? Border.all(color: const Color(0xFFEE4D2D).withOpacity(0.5))
                : Border.all(color: Colors.transparent),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? const Color(0xFFEE4D2D) : Colors.grey[600],
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ),
        if (hasUnread)
          Positioned(
            right: -2,
            top: -2,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFFEE4D2D),
                shape: BoxShape.circle,
                border: Border.fromBorderSide(BorderSide(color: Colors.white, width: 1.5)),
              ),
            ),
          ),
      ],
    );
  }
}
