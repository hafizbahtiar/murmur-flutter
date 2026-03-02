// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_filter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChatFilterState)
final chatFilterStateProvider = ChatFilterStateProvider._();

final class ChatFilterStateProvider
    extends $NotifierProvider<ChatFilterState, ChatFilter> {
  ChatFilterStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatFilterStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatFilterStateHash();

  @$internal
  @override
  ChatFilterState create() => ChatFilterState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChatFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChatFilter>(value),
    );
  }
}

String _$chatFilterStateHash() => r'badef17889046cf6befa40f7963efb07614c79b3';

abstract class _$ChatFilterState extends $Notifier<ChatFilter> {
  ChatFilter build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ChatFilter, ChatFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ChatFilter, ChatFilter>,
              ChatFilter,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
