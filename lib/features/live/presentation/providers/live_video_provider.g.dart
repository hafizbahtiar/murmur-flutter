// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_video_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(liveVideoRepository)
final liveVideoRepositoryProvider = LiveVideoRepositoryProvider._();

final class LiveVideoRepositoryProvider
    extends
        $FunctionalProvider<
          LiveVideoRepository,
          LiveVideoRepository,
          LiveVideoRepository
        >
    with $Provider<LiveVideoRepository> {
  LiveVideoRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'liveVideoRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$liveVideoRepositoryHash();

  @$internal
  @override
  $ProviderElement<LiveVideoRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LiveVideoRepository create(Ref ref) {
    return liveVideoRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LiveVideoRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LiveVideoRepository>(value),
    );
  }
}

String _$liveVideoRepositoryHash() =>
    r'cf48bca911216067abe620388205d11eb1376bfe';

@ProviderFor(LiveVideoList)
final liveVideoListProvider = LiveVideoListFamily._();

final class LiveVideoListProvider
    extends $AsyncNotifierProvider<LiveVideoList, List<LiveVideo>> {
  LiveVideoListProvider._({
    required LiveVideoListFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'liveVideoListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$liveVideoListHash();

  @override
  String toString() {
    return r'liveVideoListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  LiveVideoList create() => LiveVideoList();

  @override
  bool operator ==(Object other) {
    return other is LiveVideoListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$liveVideoListHash() => r'9b3209bbba70db7f6d201ea9e0ce2d5d6fc8163c';

final class LiveVideoListFamily extends $Family
    with
        $ClassFamilyOverride<
          LiveVideoList,
          AsyncValue<List<LiveVideo>>,
          List<LiveVideo>,
          FutureOr<List<LiveVideo>>,
          String
        > {
  LiveVideoListFamily._()
    : super(
        retry: null,
        name: r'liveVideoListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LiveVideoListProvider call({String category = 'For You'}) =>
      LiveVideoListProvider._(argument: category, from: this);

  @override
  String toString() => r'liveVideoListProvider';
}

abstract class _$LiveVideoList extends $AsyncNotifier<List<LiveVideo>> {
  late final _$args = ref.$arg as String;
  String get category => _$args;

  FutureOr<List<LiveVideo>> build({String category = 'For You'});
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<LiveVideo>>, List<LiveVideo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<LiveVideo>>, List<LiveVideo>>,
              AsyncValue<List<LiveVideo>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(category: _$args));
  }
}
