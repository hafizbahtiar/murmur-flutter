// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChatList)
final chatListProvider = ChatListProvider._();

final class ChatListProvider
    extends $AsyncNotifierProvider<ChatList, List<ChatConversation>> {
  ChatListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatListHash();

  @$internal
  @override
  ChatList create() => ChatList();
}

String _$chatListHash() => r'c0b62525b3af9707a9ba1a57e7ed2f9437962ae4';

abstract class _$ChatList extends $AsyncNotifier<List<ChatConversation>> {
  FutureOr<List<ChatConversation>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<ChatConversation>>, List<ChatConversation>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ChatConversation>>,
                List<ChatConversation>
              >,
              AsyncValue<List<ChatConversation>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(chatMessages)
final chatMessagesProvider = ChatMessagesFamily._();

final class ChatMessagesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ChatMessage>>,
          List<ChatMessage>,
          FutureOr<List<ChatMessage>>
        >
    with
        $FutureModifier<List<ChatMessage>>,
        $FutureProvider<List<ChatMessage>> {
  ChatMessagesProvider._({
    required ChatMessagesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'chatMessagesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$chatMessagesHash();

  @override
  String toString() {
    return r'chatMessagesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<ChatMessage>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ChatMessage>> create(Ref ref) {
    final argument = this.argument as String;
    return chatMessages(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatMessagesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$chatMessagesHash() => r'59ea1e7dafbd9d52f6c2fa68232cfd31a580029d';

final class ChatMessagesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<ChatMessage>>, String> {
  ChatMessagesFamily._()
    : super(
        retry: null,
        name: r'chatMessagesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ChatMessagesProvider call(String conversationId) =>
      ChatMessagesProvider._(argument: conversationId, from: this);

  @override
  String toString() => r'chatMessagesProvider';
}
