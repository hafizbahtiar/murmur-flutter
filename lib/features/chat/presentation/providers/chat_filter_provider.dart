import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_filter_provider.g.dart';

enum ChatFilter { all, active }

@riverpod
class ChatFilterState extends _$ChatFilterState {
  @override
  ChatFilter build() {
    return ChatFilter.all;
  }

  void setFilter(ChatFilter filter) {
    state = filter;
  }
}
